<?php

declare(strict_types=1);

namespace App\Services;

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use App\Repositories\Contracts\TaskRepositoryInterface;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class TaskService
{
    public function __construct(
        private readonly TaskRepositoryInterface $taskRepository,
    ) {}

    public function list(
        Project $project,
        User $user,
        ?TaskStatus $status,
        ?TaskPriority $priority,
        ?string $search,
        int $perPage,
    ): LengthAwarePaginator {
        $this->ensureProjectOwnedBy($project, $user);

        return $this->taskRepository->paginateForProject(
            $project,
            $status,
            $priority,
            $search,
            $perPage,
        );
    }

    public function create(Project $project, User $user, array $attributes): Task
    {
        $this->ensureProjectOwnedBy($project, $user);

        return $this->taskRepository->create($project, $attributes);
    }

    public function show(Task $task, User $user): Task
    {
        $this->ensureTaskOwnedBy($task, $user);

        return $task;
    }

    public function update(Task $task, User $user, array $attributes): Task
    {
        $this->ensureTaskOwnedBy($task, $user);

        return $this->taskRepository->update($task, $attributes);
    }

    public function delete(Task $task, User $user): bool
    {
        $this->ensureTaskOwnedBy($task, $user);

        return $this->taskRepository->delete($task);
    }

    private function ensureProjectOwnedBy(Project $project, User $user): void
    {
        if ($project->user_id !== $user->id) {
            throw new AuthorizationException('This action is unauthorized.');
        }
    }

    private function ensureTaskOwnedBy(Task $task, User $user): void
    {
        $task->loadMissing('project');

        if ($task->project->user_id !== $user->id) {
            throw new AuthorizationException('This action is unauthorized.');
        }
    }
}
