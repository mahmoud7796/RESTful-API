<?php

declare(strict_types=1);

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

beforeEach(function (): void {
    $this->user = User::factory()->create([
        'email' => 'owner@example.com',
        'password' => Hash::make('password123'),
    ]);
    $this->otherUser = User::factory()->create();
    $this->token = $this->user->createToken('test')->plainTextToken;
    $this->authHeaders = ['Authorization' => 'Bearer '.$this->token];
    $this->project = Project::factory()->for($this->user)->create();
    $this->otherProject = Project::factory()->for($this->otherUser)->create();
});

it('lists only tasks belonging to the given project', function (): void {
    Task::factory()->count(3)->for($this->project)->create();
    Task::factory()->count(2)->for($this->otherProject)->create();

    $response = $this->getJson("/api/v1/projects/{$this->project->id}/tasks", $this->authHeaders);

    $response->assertOk();
    expect($response->json('data'))->toHaveCount(3);
    expect(collect($response->json('data'))->pluck('project_id')->unique()->all())->toBe([$this->project->id]);
});

dataset('task statuses', fn () => collect(TaskStatus::cases())->mapWithKeys(
    fn (TaskStatus $status) => [$status->value => [$status]],
)->all());

it('filters tasks by status', function (TaskStatus $filterStatus): void {
    foreach (TaskStatus::cases() as $status) {
        Task::factory()->for($this->project)->create(['status' => $status]);
    }

    $response = $this->getJson(
        "/api/v1/projects/{$this->project->id}/tasks?status={$filterStatus->value}",
        $this->authHeaders,
    );

    $response->assertOk();
    expect($response->json('data'))->toHaveCount(1);
    expect($response->json('data.0.status.value'))->toBe($filterStatus->value);
})->with('task statuses');

dataset('task priorities', fn () => collect(TaskPriority::cases())->mapWithKeys(
    fn (TaskPriority $priority) => [$priority->value => [$priority]],
)->all());

it('filters tasks by priority', function (TaskPriority $filterPriority): void {
    foreach (TaskPriority::cases() as $priority) {
        Task::factory()->for($this->project)->create(['priority' => $priority]);
    }

    $response = $this->getJson(
        "/api/v1/projects/{$this->project->id}/tasks?priority={$filterPriority->value}",
        $this->authHeaders,
    );

    $response->assertOk();
    expect($response->json('data'))->toHaveCount(1);
    expect($response->json('data.0.priority.value'))->toBe($filterPriority->value);
})->with('task priorities');

it('searches tasks by title case-insensitively with partial matches', function (): void {
    Task::factory()->for($this->project)->create(['title' => 'Deploy Production Release']);
    Task::factory()->for($this->project)->create(['title' => 'Unrelated Item']);

    $response = $this->getJson(
        "/api/v1/projects/{$this->project->id}/tasks?search=production",
        $this->authHeaders,
    );

    $response->assertOk();
    expect($response->json('data'))->toHaveCount(1);
    expect($response->json('data.0.title'))->toBe('Deploy Production Release');
});

it('treats a literal percent sign in search as a literal character', function (): void {
    Task::factory()->for($this->project)->create(['title' => '100% complete']);
    Task::factory()->for($this->project)->create(['title' => '1000 items done']);
    Task::factory()->for($this->project)->create(['title' => 'totally finished']);

    $response = $this->getJson(
        '/api/v1/projects/'.$this->project->id.'/tasks?'.http_build_query(['search' => '100%']),
        $this->authHeaders,
    );

    $response->assertOk();
    expect($response->json('data'))->toHaveCount(1);
    expect($response->json('data.0.title'))->toBe('100% complete');
});

it('returns 403 when creating a task in another users project', function (): void {
    $response = $this->postJson("/api/v1/projects/{$this->otherProject->id}/tasks", [
        'title' => 'Forbidden task',
    ], $this->authHeaders);

    $response->assertForbidden();
    $response->assertJson([
        'message' => 'This action is unauthorized.',
        'errors' => null,
    ]);
});

it('returns 404 when a task does not belong to the scoped project', function (): void {
    $task = Task::factory()->for($this->otherProject)->create();

    $this->getJson("/api/v1/projects/{$this->project->id}/tasks/{$task->id}", $this->authHeaders)
        ->assertNotFound()
        ->assertJson([
            'message' => 'Resource not found.',
            'errors' => null,
        ]);
});

it('returns correct pagination meta when per_page is set', function (): void {
    Task::factory()->count(20)->for($this->project)->create();

    $response = $this->getJson(
        "/api/v1/projects/{$this->project->id}/tasks?per_page=5",
        $this->authHeaders,
    );

    $response->assertOk();
    $response->assertJsonStructure([
        'data',
        'links' => ['first', 'last', 'prev', 'next'],
        'meta' => ['current_page', 'from', 'last_page', 'path', 'per_page', 'to', 'total'],
    ]);
    expect($response->json('data'))->toHaveCount(5);
    expect($response->json('meta.per_page'))->toBe(5);
    expect($response->json('meta.total'))->toBe(20);
    expect($response->json('meta.last_page'))->toBe(4);
});

it('excludes soft-deleted tasks from the list', function (): void {
    $visible = Task::factory()->for($this->project)->create(['title' => 'Visible']);
    $hidden = Task::factory()->for($this->project)->create(['title' => 'Hidden']);
    $hidden->delete();

    $response = $this->getJson("/api/v1/projects/{$this->project->id}/tasks", $this->authHeaders);

    $response->assertOk();
    expect(collect($response->json('data'))->pluck('id')->all())->toBe([$visible->id]);
});

it('reports is_overdue true for past due dates when status is not done', function (): void {
    $task = Task::factory()->for($this->project)->create([
        'due_date' => now()->subDay()->toDateString(),
        'status' => TaskStatus::Todo,
    ]);

    $response = $this->getJson("/api/v1/tasks/{$task->id}", $this->authHeaders);

    $response->assertOk();
    expect($response->json('data.is_overdue'))->toBeTrue();
});

it('reports is_overdue false when status is done even with a past due date', function (): void {
    $task = Task::factory()->for($this->project)->create([
        'due_date' => now()->subDay()->toDateString(),
        'status' => TaskStatus::Done,
    ]);

    $response = $this->getJson("/api/v1/tasks/{$task->id}", $this->authHeaders);

    $response->assertOk();
    expect($response->json('data.is_overdue'))->toBeFalse();
});
