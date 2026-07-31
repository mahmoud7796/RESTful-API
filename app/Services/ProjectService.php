<?php

declare(strict_types=1);

namespace App\Services;

use App\DTOs\ProjectData;
use App\Enums\ProjectStatus;
use App\Models\Project;
use App\Models\User;
use App\Repositories\Contracts\ProjectRepositoryInterface;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class ProjectService
{
    public function __construct(
        private readonly ProjectRepositoryInterface $projectRepository,
    ) {}

    public function list(User $user, ?ProjectStatus $status, int $perPage): LengthAwarePaginator
    {
        return $this->projectRepository->paginateForUser($user, $status, $perPage);
    }

    public function create(User $user, ProjectData $data): Project
    {
        return $this->projectRepository->create($user, $data);
    }

    public function show(Project $project, User $user): Project
    {
        $this->ensureOwnedBy($project, $user);

        return $this->projectRepository->loadTaskCount($project);
    }

    public function update(Project $project, User $user, ProjectData $data): Project
    {
        $this->ensureOwnedBy($project, $user);

        return $this->projectRepository->update($project, $data);
    }

    public function delete(Project $project, User $user): bool
    {
        $this->ensureOwnedBy($project, $user);

        return $this->projectRepository->delete($project);
    }

    private function ensureOwnedBy(Project $project, User $user): void
    {
        if ($project->user_id !== $user->id) {
            throw new AuthorizationException('This action is unauthorized.');
        }
    }
}
