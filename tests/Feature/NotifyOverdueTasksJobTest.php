<?php

declare(strict_types=1);

use App\Jobs\NotifyOverdueTasksJob;
use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use App\Enums\TaskStatus;
use App\Notifications\TaskOverdueNotification;
use App\Repositories\Contracts\TaskRepositoryInterface;
use Illuminate\Support\Facades\Notification;

beforeEach(function (): void {
    Notification::fake();
    $this->user = User::factory()->create();
    $this->project = Project::factory()->for($this->user)->create();
    $this->taskRepository = app(TaskRepositoryInterface::class);
});

it('sends a notification for an overdue task', function (): void {
    Task::factory()->for($this->project)->overdue()->create();

    (new NotifyOverdueTasksJob)->handle($this->taskRepository);

    Notification::assertSentTo($this->user, TaskOverdueNotification::class);
});

it('does not send a notification when overdue_notified_at is already set', function (): void {
    Task::factory()->for($this->project)->overdue()->create([
        'overdue_notified_at' => now(),
    ]);

    (new NotifyOverdueTasksJob)->handle($this->taskRepository);

    Notification::assertNothingSent();
});

it('does not send a notification for a task with a future due date', function (): void {
    Task::factory()->for($this->project)->create([
        'due_date' => now()->addWeek()->toDateString(),
        'status' => TaskStatus::Todo,
    ]);

    (new NotifyOverdueTasksJob)->handle($this->taskRepository);

    Notification::assertNothingSent();
});

it('does not send a notification for a done task even with a past due date', function (): void {
    Task::factory()->for($this->project)->done()->create([
        'due_date' => now()->subWeek()->toDateString(),
    ]);

    (new NotifyOverdueTasksJob)->handle($this->taskRepository);

    Notification::assertNothingSent();
});

it('sends exactly one notification when the job runs twice', function (): void {
    Task::factory()->for($this->project)->overdue()->create();

    $job = new NotifyOverdueTasksJob;
    $job->handle($this->taskRepository);
    $job->handle($this->taskRepository);

    Notification::assertSentToTimes($this->user, TaskOverdueNotification::class, 1);
});
