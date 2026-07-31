<?php

declare(strict_types=1);

namespace App\Repositories\Eloquent;

use App\Enums\ProjectStatus;
use App\Models\Project;
use App\Models\User;
use App\Repositories\Contracts\ProjectRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class EloquentProjectRepository implements ProjectRepositoryInterface
{
    public function __construct(
        private readonly Project $project,
    ) {}

    public function paginateForUser(User $user, ?ProjectStatus $status, int $perPage): LengthAwarePaginator
    {
        return $this->project->newQuery()
            ->ownedBy($user)
            ->withStatus($status)
            ->withCount('tasks')
            ->latest()
            ->paginate($perPage);
    }

    public function create(User $user, array $attributes): Project
    {
        return $user->projects()->create($attributes);
    }

    public function update(Project $project, array $attributes): Project
    {
        $project->update($attributes);

        return $project->refresh();
    }

    public function delete(Project $project): bool
    {
        return (bool) $project->delete();
    }

    public function loadTasks(Project $project): Project
    {
        $project->loadCount('tasks');
        $project->load('tasks');

        return $project;
    }

    public function countsForUser(User $user): array
    {
        $result = $this->project->newQuery()
            ->ownedBy($user)
            ->selectRaw(
                'COUNT(*) as total,
                SUM(CASE WHEN status = ? THEN 1 ELSE 0 END) as active,
                SUM(CASE WHEN status = ? THEN 1 ELSE 0 END) as completed,
                SUM(CASE WHEN status = ? THEN 1 ELSE 0 END) as archived',
                [
                    ProjectStatus::Active->value,
                    ProjectStatus::Completed->value,
                    ProjectStatus::Archived->value,
                ],
            )
            ->first();

        return [
            'total' => (int) $result->total,
            'active' => (int) $result->active,
            'completed' => (int) $result->completed,
            'archived' => (int) $result->archived,
        ];
    }
}
