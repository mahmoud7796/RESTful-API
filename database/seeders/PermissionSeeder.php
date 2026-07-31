<?php

declare(strict_types=1);

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Spatie\Permission\PermissionRegistrar;

class PermissionSeeder extends Seeder
{
    public const ROLE_USER = 'user';

    /** @var list<string> */
    public const PERMISSIONS = [
        'dashboard.view',
        'projects.index',
        'projects.store',
        'projects.show',
        'projects.update',
        'projects.destroy',
        'tasks.index',
        'tasks.store',
        'tasks.show',
        'tasks.update',
        'tasks.destroy',
    ];

    public function run(): void
    {
        app(PermissionRegistrar::class)->forgetCachedPermissions();

        foreach (self::PERMISSIONS as $permission) {
            Permission::findOrCreate($permission, 'web');
        }

        app(PermissionRegistrar::class)->forgetCachedPermissions();

        $role = Role::findOrCreate(self::ROLE_USER, 'web');
        $role->syncPermissions(
            Permission::query()
                ->where('guard_name', 'web')
                ->whereIn('name', self::PERMISSIONS)
                ->get(),
        );
    }
}
