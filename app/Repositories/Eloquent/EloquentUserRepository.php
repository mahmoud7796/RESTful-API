<?php

declare(strict_types=1);

namespace App\Repositories\Eloquent;

use App\Models\User;
use App\Repositories\Contracts\UserRepositoryInterface;

class EloquentUserRepository implements UserRepositoryInterface
{
    public function __construct(
        private readonly User $user,
    ) {}

    public function create(array $attributes): User
    {
        return $this->user->newQuery()->create($attributes);
    }

    public function findByEmail(string $email): ?User
    {
        return $this->user->newQuery()->where('email', $email)->first();
    }
}
