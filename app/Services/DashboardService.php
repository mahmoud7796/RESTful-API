<?php

declare(strict_types=1);

namespace App\Services;

use App\Models\User;
use App\Repositories\Contracts\ProjectRepositoryInterface;
use App\Repositories\Contracts\TaskRepositoryInterface;

class DashboardService
{
    public function __construct(
        private readonly ProjectRepositoryInterface $projectRepository,
        private readonly TaskRepositoryInterface $taskRepository,
    ) {}

    /**
     * @return array{
     *     total_projects: int,
     *     active_projects: int,
     *     total_tasks: int,
     *     completed_tasks: int,
     *     pending_tasks: int,
     *     overdue_tasks: int,
     * }
     */
    public function forUser(User $user): array
    {
        $projectCounts = $this->projectRepository->countsForUser($user);
        $taskCounts = $this->taskRepository->countsForUser($user);

        return [
            'total_projects' => $projectCounts['total'],
            'active_projects' => $projectCounts['active'],
            'total_tasks' => $taskCounts['total'],
            'completed_tasks' => $taskCounts['done'],
            'pending_tasks' => $taskCounts['pending'],
            'overdue_tasks' => $taskCounts['overdue'],
        ];
    }
}
