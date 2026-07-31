<?php

declare(strict_types=1);

namespace App\Models;

use Database\Factories\UserFactory;
use Database\Seeders\PermissionSeeder;
use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Attributes\Hidden;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Traits\HasRoles;

#[Fillable(['name', 'email', 'password'])]
#[Hidden(['password', 'remember_token'])]
class User extends Authenticatable
{
    /** @use HasFactory<UserFactory> */
    use HasApiTokens, HasFactory, HasRoles, Notifiable;

    protected string $guard_name = 'web';

    public function assignDefaultRole(): void
    {
        if (! Role::query()->where('name', PermissionSeeder::ROLE_USER)->where('guard_name', 'web')->exists()) {
            return;
        }

        if ($this->hasRole(PermissionSeeder::ROLE_USER)) {
            return;
        }

        $this->assignRole(PermissionSeeder::ROLE_USER);
    }

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function projects(): HasMany
    {
        return $this->hasMany(Project::class);
    }
}
