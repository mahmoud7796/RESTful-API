<?php

declare(strict_types=1);

namespace App\Jobs;

use App\Notifications\TaskOverdueNotification;
use App\Repositories\Contracts\TaskRepositoryInterface;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Queue\Queueable;

class NotifyOverdueTasksJob implements ShouldQueue
{
    use Queueable;

    public function handle(TaskRepositoryInterface $taskRepository): void
    {
        foreach ($taskRepository->overdueNotYetNotified(200) as $task) {
            $task->project->user->notify(new TaskOverdueNotification($task));

            // overdue_notified_at is the idempotency guard — re-running the job must not re-notify the same task.
            $taskRepository->markOverdueNotified($task);
        }
    }
}
