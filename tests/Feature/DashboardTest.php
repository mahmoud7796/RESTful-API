<?php

declare(strict_types=1);

use App\Enums\ProjectStatus;
use App\Enums\TaskStatus;
use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Middleware\PermissionMiddleware;

beforeEach(function (): void {
    $this->user = User::factory()->create();
    $this->otherUser = User::factory()->create();
});

function seedDashboardFixture(User $user): void
{
    $activeOne = Project::factory()->for($user)->create(['status' => ProjectStatus::Active]);
    $activeTwo = Project::factory()->for($user)->create(['status' => ProjectStatus::Active]);
    $completedProject = Project::factory()->for($user)->create(['status' => ProjectStatus::Completed]);

    Task::factory()->count(4)->for($activeOne)->done()->create();
    Task::factory()->count(3)->for($activeTwo)->overdue()->create();
    Task::factory()->count(3)->for($completedProject)->create([
        'status' => TaskStatus::Todo,
        'due_date' => now()->addWeek()->toDateString(),
    ]);
}

it('returns exact dashboard metrics for the authenticated user', function (): void {
    seedDashboardFixture($this->user);

    $response = $this->actingAs($this->user, 'sanctum')
        ->getJson('/api/v1/dashboard');

    $response->assertOk();
    $response->assertJson([
        'total_projects' => 3,
        'active_projects' => 2,
        'total_tasks' => 10,
        'completed_tasks' => 4,
        'pending_tasks' => 6,
        'overdue_tasks' => 3,
    ]);
});

it('does not include another users data in dashboard totals', function (): void {
    seedDashboardFixture($this->user);

    $otherProject = Project::factory()->for($this->otherUser)->create(['status' => ProjectStatus::Active]);
    Task::factory()->count(5)->for($otherProject)->overdue()->create();

    $response = $this->actingAs($this->user, 'sanctum')
        ->getJson('/api/v1/dashboard');

    $response->assertOk();
    $response->assertJsonPath('total_projects', 3);
    $response->assertJsonPath('total_tasks', 10);
    $response->assertJsonPath('overdue_tasks', 3);
});

it('excludes soft-deleted projects and tasks from dashboard totals', function (): void {
    seedDashboardFixture($this->user);

    $deletedProject = Project::factory()->for($this->user)->create(['status' => ProjectStatus::Active]);
    Task::factory()->count(2)->for($deletedProject)->overdue()->create();
    $deletedProject->delete();

    $existingProject = Project::factory()->for($this->user)->create(['status' => ProjectStatus::Active]);
    $deletedTask = Task::factory()->for($existingProject)->overdue()->create();
    $deletedTask->delete();
    $existingProject->delete();

    $response = $this->actingAs($this->user, 'sanctum')
        ->getJson('/api/v1/dashboard');

    $response->assertOk();
    $response->assertJsonPath('total_projects', 3);
    $response->assertJsonPath('total_tasks', 10);
    $response->assertJsonPath('overdue_tasks', 3);
});

it('issues at most two database queries for dashboard aggregates', function (): void {
    seedDashboardFixture($this->user);

    $queryCount = 0;

    DB::listen(function ($query) use (&$queryCount): void {
        if (preg_match('/^\s*select/i', $query->sql)) {
            $queryCount++;
        }
    });

    $this->withoutMiddleware(PermissionMiddleware::class);

    $this->actingAs($this->user, 'sanctum')
        ->getJson('/api/v1/dashboard')
        ->assertOk();

    expect($queryCount)->toBeLessThanOrEqual(2);
});
