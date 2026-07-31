<?php

declare(strict_types=1);

namespace App\Providers;

use App\Repositories\Contracts\ProjectRepositoryInterface;
use App\Repositories\Contracts\TaskRepositoryInterface;
use App\Repositories\Contracts\UserRepositoryInterface;
use App\Repositories\Eloquent\EloquentProjectRepository;
use App\Repositories\Eloquent\EloquentTaskRepository;
use App\Repositories\Eloquent\EloquentUserRepository;
use Illuminate\Support\ServiceProvider;

class RepositoryServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        $this->app->bind(ProjectRepositoryInterface::class, EloquentProjectRepository::class);
        $this->app->bind(TaskRepositoryInterface::class, EloquentTaskRepository::class);
        $this->app->bind(UserRepositoryInterface::class, EloquentUserRepository::class);
    }
}
