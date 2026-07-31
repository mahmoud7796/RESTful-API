<?php

declare(strict_types=1);

namespace App\Repositories\Contracts;

use App\Enums\ProjectStatus;
use App\Models\Project;
use App\Models\User;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;

/**
 * No method may return an Eloquent Builder — returning a builder leaks persistence
 * concerns to the caller and defeats the abstraction.
 */
interface ProjectRepositoryInterface
{
    public function paginateForUser(User $user, ?ProjectStatus $status, int $perPage): LengthAwarePaginator;

    public function create(User $user, array $attributes): Project;

    public function update(Project $project, array $attributes): Project;

    public function delete(Project $project): bool;

    public function loadTasks(Project $project): Project;

    public function countsForUser(User $user): array;
}
