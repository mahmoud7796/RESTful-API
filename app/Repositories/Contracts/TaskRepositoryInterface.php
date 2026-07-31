<?php

declare(strict_types=1);

namespace App\Repositories\Contracts;

use App\DTOs\TaskData;
use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Support\LazyCollection;

/**
 * No method may return an Eloquent Builder — returning a builder leaks persistence
 * concerns to the caller and defeats the abstraction.
 */
interface TaskRepositoryInterface
{
    public function paginateForProject(
        Project $project,
        ?TaskStatus $status,
        ?TaskPriority $priority,
        ?string $search,
        int $perPage,
    ): LengthAwarePaginator;

    public function create(Project $project, TaskData $data): Task;

    public function update(Task $task, TaskData $data): Task;

    public function delete(Task $task): bool;

    public function countsForUser(User $user): array;

    public function overdueNotYetNotified(int $chunkSize): LazyCollection;

    public function markOverdueNotified(Task $task): Task;
}
