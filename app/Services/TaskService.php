<?php

declare(strict_types=1);

namespace App\Services;

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use App\Models\Project;
use App\Models\Task;
use App\Repositories\Contracts\TaskRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

class TaskService
{
    public function __construct(
        private readonly TaskRepositoryInterface $taskRepository,
    ) {}

    public function list(
        Project $project,
        ?TaskStatus $status,
        ?TaskPriority $priority,
        ?string $search,
        int $perPage,
    ): LengthAwarePaginator {
        return $this->taskRepository->paginateForProject(
            $project,
            $status,
            $priority,
            $search,
            $perPage,
        );
    }

    public function create(Project $project, array $attributes): Task
    {
        return $this->taskRepository->create($project, $attributes);
    }

    public function update(Task $task, array $attributes): Task
    {
        return $this->taskRepository->update($task, $attributes);
    }

    public function delete(Task $task): bool
    {
        return $this->taskRepository->delete($task);
    }
}
