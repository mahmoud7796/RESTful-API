<?php

declare(strict_types=1);

namespace App\Repositories\Eloquent;

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use App\Repositories\Contracts\TaskRepositoryInterface;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\LazyCollection;

class EloquentTaskRepository implements TaskRepositoryInterface
{
    public function __construct(
        private readonly Task $task,
    ) {}

    public function paginateForProject(
        Project $project,
        ?TaskStatus $status,
        ?TaskPriority $priority,
        ?string $search,
        int $perPage,
    ): LengthAwarePaginator {
        return $this->task->newQuery()
            ->where('project_id', $project->id)
            ->withStatus($status)
            ->withPriority($priority)
            ->when($search, function (Builder $query, string $term): void {
                $escaped = str_replace(['\\', '%', '_'], ['\\\\', '\\%', '\\_'], $term);
                $query->whereRaw('LOWER(title) LIKE ? ESCAPE ?', [
                    '%'.mb_strtolower($escaped).'%',
                    '\\',
                ]);
            })
            ->latest()
            ->paginate($perPage);
    }

    public function create(Project $project, array $attributes): Task
    {
        return $project->tasks()->create($attributes);
    }

    public function update(Task $task, array $attributes): Task
    {
        $task->update($attributes);

        return $task->refresh();
    }

    public function delete(Task $task): bool
    {
        return (bool) $task->delete();
    }

    public function countsForUser(User $user): array
    {
        $result = $this->task->newQuery()
            ->join('projects', 'projects.id', '=', 'tasks.project_id')
            ->where('projects.user_id', $user->id)
            ->whereNull('projects.deleted_at')
            ->selectRaw(
                'COUNT(*) as total,
                SUM(CASE WHEN tasks.status = ? THEN 1 ELSE 0 END) as done,
                SUM(CASE WHEN tasks.status != ? THEN 1 ELSE 0 END) as pending,
                SUM(CASE WHEN tasks.due_date IS NOT NULL AND tasks.due_date < ? AND tasks.status != ? THEN 1 ELSE 0 END) as overdue',
                [
                    TaskStatus::Done->value,
                    TaskStatus::Done->value,
                    now()->toDateString(),
                    TaskStatus::Done->value,
                ],
            )
            ->first();

        return [
            'total' => (int) $result->total,
            'done' => (int) $result->done,
            'pending' => (int) $result->pending,
            'overdue' => (int) $result->overdue,
        ];
    }

    public function overdueNotYetNotified(int $chunkSize): LazyCollection
    {
        return $this->task->newQuery()
            ->overdue()
            ->whereNull('overdue_notified_at')
            ->with('project.user')
            ->lazy($chunkSize);
    }

    public function markOverdueNotified(Task $task): Task
    {
        $task->forceFill(['overdue_notified_at' => now()])->save();

        return $task->refresh();
    }
}
