<?php

declare(strict_types=1);

use App\Enums\ProjectStatus;
use App\Models\Project;
use App\Models\User;
use App\Repositories\Contracts\ProjectRepositoryInterface;
use App\Services\ProjectService;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

beforeEach(function (): void {
    $this->repository = Mockery::mock(ProjectRepositoryInterface::class);
    $this->service = new ProjectService($this->repository);
    $this->user = (new User)->forceFill(['id' => 1]);
    $this->project = (new Project)->forceFill(['id' => 1, 'user_id' => 1]);
});

afterEach(function (): void {
    Mockery::close();
});

it('delegates list to the repository with expected arguments', function (): void {
    $paginator = Mockery::mock(LengthAwarePaginator::class);

    $this->repository
        ->shouldReceive('paginateForUser')
        ->once()
        ->with($this->user, ProjectStatus::Active, 20)
        ->andReturn($paginator);

    $result = $this->service->list($this->user, ProjectStatus::Active, 20);

    expect($result)->toBe($paginator);
});

it('delegates create to the repository with expected arguments', function (): void {
    $attributes = ['name' => 'Test', 'description' => null, 'status' => ProjectStatus::Active];

    $this->repository
        ->shouldReceive('create')
        ->once()
        ->with($this->user, $attributes)
        ->andReturn($this->project);

    $result = $this->service->create($this->user, $attributes);

    expect($result)->toBe($this->project);
});

it('delegates show to the repository loadTaskCount method', function (): void {
    $this->repository
        ->shouldReceive('loadTaskCount')
        ->once()
        ->with($this->project)
        ->andReturn($this->project);

    $result = $this->service->show($this->project, $this->user);

    expect($result)->toBe($this->project);
});

it('delegates update to the repository with expected arguments', function (): void {
    $attributes = ['name' => 'Updated'];

    $this->repository
        ->shouldReceive('update')
        ->once()
        ->with($this->project, $attributes)
        ->andReturn($this->project);

    $result = $this->service->update($this->project, $this->user, $attributes);

    expect($result)->toBe($this->project);
});

it('delegates delete to the repository', function (): void {
    $this->repository
        ->shouldReceive('delete')
        ->once()
        ->with($this->project)
        ->andReturn(true);

    $result = $this->service->delete($this->project, $this->user);

    expect($result)->toBeTrue();
});
it('rejects show when the project belongs to another user', function (): void {
    $foreignProject = (new Project)->forceFill(['id' => 2, 'user_id' => 2]);

    $this->repository->shouldNotReceive('loadTaskCount');

    expect(fn () => $this->service->show($foreignProject, $this->user))
        ->toThrow(AuthorizationException::class);
});
