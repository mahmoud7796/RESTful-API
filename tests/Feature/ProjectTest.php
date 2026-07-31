<?php

declare(strict_types=1);

use App\Enums\ProjectStatus;
use App\Models\Project;
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
});

it('returns only the authenticated users projects on index', function (): void {
    Project::factory()->count(2)->for($this->user)->create();
    Project::factory()->count(3)->for($this->otherUser)->create();

    $response = $this->getJson('/api/v1/projects', $this->authHeaders);

    $response->assertOk();
    expect($response->json('data'))->toHaveCount(2);
    expect(collect($response->json('data'))->pluck('id')->sort()->values()->all())
        ->toEqual($this->user->projects()->pluck('id')->sort()->values()->all());
});

it('filters index by status and includes pagination meta', function (): void {
    Project::factory()->for($this->user)->create(['status' => ProjectStatus::Active]);
    Project::factory()->for($this->user)->create(['status' => ProjectStatus::Completed]);
    Project::factory()->for($this->user)->create(['status' => ProjectStatus::Archived]);

    $response = $this->getJson('/api/v1/projects?status=active', $this->authHeaders);

    $response->assertOk();
    $response->assertJsonStructure([
        'success',
        'message',
        'data' => [['id', 'name', 'description', 'status', 'tasks_count', 'created_at', 'updated_at']],
        'links' => ['first', 'last', 'prev', 'next'],
        'meta' => ['current_page', 'from', 'last_page', 'path', 'per_page', 'to', 'total'],
    ]);
    expect($response->json('data'))->toHaveCount(1);
    expect($response->json('data.0.status.value'))->toBe('active');
});

it('stores a project and returns 201 with the correct user_id', function (): void {
    $response = $this->postJson('/api/v1/projects', [
        'name' => 'New Project',
        'description' => 'A description',
        'status' => 'active',
    ], $this->authHeaders);

    $response->assertCreated();
    $response->assertJsonStructure([
        'success',
        'message',
        'data' => [
            'id',
            'name',
            'description',
            'status' => ['value', 'label'],
            'created_at',
            'updated_at',
        ],
    ]);
    $response->assertJsonPath('data.name', 'New Project');
    $response->assertJsonPath('data.status.value', 'active');
    $response->assertJsonPath('data.status.label', 'Active');

    $project = Project::query()->find($response->json('data.id'));
    expect($project)->not->toBeNull();
    expect($project->user_id)->toBe($this->user->id);
});

it('returns 422 when storing with an invalid status', function (): void {
    $response = $this->postJson('/api/v1/projects', [
        'name' => 'Bad Status Project',
        'status' => 'invalid',
    ], $this->authHeaders);

    $response->assertUnprocessable();
    $response->assertJsonStructure(['success', 'message', 'errors' => ['status']]);
});

it('returns 403 when showing another users project', function (): void {
    $project = Project::factory()->for($this->otherUser)->create();

    $this->getJson("/api/v1/projects/{$project->id}", $this->authHeaders)
        ->assertForbidden()
        ->assertJson([
            'success' => false,
            'message' => 'This action is unauthorized.',
        ]);
});

it('returns 404 when showing a non-existent project', function (): void {
    $this->getJson('/api/v1/projects/999999', $this->authHeaders)
        ->assertNotFound()
        ->assertJson([
            'success' => false,
            'message' => 'Resource not found.',
        ]);
});

it('updates only the provided fields', function (): void {
    $project = Project::factory()->for($this->user)->create([
        'name' => 'Original Name',
        'description' => 'Original description',
        'status' => ProjectStatus::Active,
    ]);

    $response = $this->patchJson("/api/v1/projects/{$project->id}", [
        'name' => 'Updated Name',
    ], $this->authHeaders);

    $response->assertOk();
    $response->assertJsonPath('data.name', 'Updated Name');
    $response->assertJsonPath('data.description', 'Original description');
    $response->assertJsonPath('data.status.value', 'active');

    $project->refresh();
    expect($project->name)->toBe('Updated Name');
    expect($project->description)->toBe('Original description');
    expect($project->status)->toBe(ProjectStatus::Active);
});

it('soft-deletes a project and returns the standard envelope', function (): void {
    $project = Project::factory()->for($this->user)->create();

    $this->deleteJson("/api/v1/projects/{$project->id}", [], $this->authHeaders)
        ->assertOk()
        ->assertJson([
            'success' => true,
            'message' => 'Project deleted successfully',
            'data' => null,
        ]);

    expect($project->fresh()->trashed())->toBeTrue();
});

it('excludes soft-deleted projects from index', function (): void {
    $active = Project::factory()->for($this->user)->create(['name' => 'Visible']);
    $deleted = Project::factory()->for($this->user)->create(['name' => 'Hidden']);
    $deleted->delete();

    $response = $this->getJson('/api/v1/projects', $this->authHeaders);

    $response->assertOk();
    expect(collect($response->json('data'))->pluck('id')->all())->toBe([$active->id]);
});

it('returns nested tasks on show', function (): void {
    $project = Project::factory()->for($this->user)->hasTasks(2)->create();

    $response = $this->getJson("/api/v1/projects/{$project->id}", $this->authHeaders);

    $response->assertOk();
    $response->assertJsonStructure([
        'success',
        'message',
        'data' => [
            'id',
            'tasks_count',
            'tasks' => [['id', 'title', 'status', 'priority']],
        ],
    ]);
    expect($response->json('data.tasks'))->toHaveCount(2);
});
