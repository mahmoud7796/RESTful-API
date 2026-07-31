<?php

declare(strict_types=1);

use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

beforeEach(function (): void {
    $this->owner = User::factory()->create();
    $this->otherUser = User::factory()->create();
    $this->ownerToken = $this->owner->createToken('test')->plainTextToken;
    $this->ownerHeaders = ['Authorization' => 'Bearer '.$this->ownerToken];
    $this->ownerProject = Project::factory()->for($this->owner)->create();
    $this->otherProject = Project::factory()->for($this->otherUser)->create();
    $this->ownerTask = Task::factory()->for($this->ownerProject)->create();
    $this->otherTask = Task::factory()->for($this->otherProject)->create();
});

it('returns 403 when a user lacks the projects.show permission', function (): void {
    $user = User::factory()->create();
    $token = $user->createToken('test')->plainTextToken;

    $this->getJson("/api/v1/projects/{$this->ownerProject->id}", [
        'Authorization' => 'Bearer '.$token,
    ])->assertForbidden()
        ->assertJson([
            'success' => false,
            'message' => 'This action is unauthorized.',
        ]);
});

it('returns 403 when a user has projects.show but does not own the project', function (): void {
    $user = User::factory()->create();
    $user->syncRoles([]);
    $user->givePermissionTo('projects.show');
    $token = $user->createToken('test')->plainTextToken;

    $this->getJson("/api/v1/projects/{$this->ownerProject->id}", [
        'Authorization' => 'Bearer '.$token,
    ])->assertForbidden()
        ->assertJson([
            'success' => false,
            'message' => 'This action is unauthorized.',
        ]);
});

it('returns 200 when a user has projects.show and owns the project', function (): void {
    $this->getJson("/api/v1/projects/{$this->ownerProject->id}", $this->ownerHeaders)
        ->assertOk()
        ->assertJsonPath('data.id', $this->ownerProject->id);
});

it('returns 403 when a user lacks the tasks.show permission', function (): void {
    $user = User::factory()->create();
    $token = $user->createToken('test')->plainTextToken;

    $this->getJson("/api/v1/tasks/{$this->ownerTask->id}", [
        'Authorization' => 'Bearer '.$token,
    ])->assertForbidden()
        ->assertJson([
            'success' => false,
            'message' => 'This action is unauthorized.',
        ]);
});

it('returns 403 when a user has tasks.show but does not own the task', function (): void {
    $user = User::factory()->create();
    $user->syncRoles([]);
    $user->givePermissionTo('tasks.show');
    $token = $user->createToken('test')->plainTextToken;

    $this->getJson("/api/v1/tasks/{$this->ownerTask->id}", [
        'Authorization' => 'Bearer '.$token,
    ])->assertForbidden()
        ->assertJson([
            'success' => false,
            'message' => 'This action is unauthorized.',
        ]);
});

it('returns 200 when a user has tasks.show and owns the task', function (): void {
    $this->getJson("/api/v1/tasks/{$this->ownerTask->id}", $this->ownerHeaders)
        ->assertOk()
        ->assertJsonPath('data.id', $this->ownerTask->id);
});

it('assigns the user role on registration when permissions are seeded', function (): void {
    $response = $this->postJson('/api/v1/auth/register', [
        'name' => 'New User',
        'email' => 'new-user@example.com',
        'password' => 'password123',
        'password_confirmation' => 'password123',
    ]);

    $response->assertCreated();

    $user = User::query()->where('email', 'new-user@example.com')->first();

    expect($user)->not->toBeNull();
    expect($user->hasRole('user'))->toBeTrue();
    expect($user->can('projects.index'))->toBeTrue();
});

it('does not re-seed permissions on registration when the user role already exists', function (): void {
    $permissionCountBefore = Permission::query()->count();
    $roleCountBefore = Role::query()->count();

    $this->postJson('/api/v1/auth/register', [
        'name' => 'Another User',
        'email' => 'another-user@example.com',
        'password' => 'password123',
        'password_confirmation' => 'password123',
    ])->assertCreated();

    expect(Permission::query()->count())->toBe($permissionCountBefore);
    expect(Role::query()->count())->toBe($roleCountBefore);
});
