<?php

declare(strict_types=1);

namespace Database\Seeders;

use App\Enums\ProjectStatus;
use App\Models\Project;
use App\Models\Task;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    public function run(): void
    {
        $this->call(PermissionSeeder::class);

        $demoUser = User::factory()->create([
            'name' => 'Demo User',
            'email' => 'demo@example.com',
            'password' => Hash::make('password'),
        ]);

        $users = collect([$demoUser])->merge(User::factory(2)->create());

        foreach ($users as $user) {
            $projects = Project::factory()
                ->count(4)
                ->for($user)
                ->sequence(
                    ['status' => ProjectStatus::Active],
                    ['status' => ProjectStatus::Completed],
                    ['status' => ProjectStatus::Archived],
                    ['status' => fake()->randomElement(ProjectStatus::cases())],
                )
                ->create();

            foreach ($projects as $project) {
                Task::factory()
                    ->count(fake()->numberBetween(5, 12))
                    ->for($project)
                    ->create();
            }
        }

        Task::factory()
            ->count(3)
            ->overdue()
            ->for($demoUser->projects()->inRandomOrder()->first())
            ->create();

        $this->command?->info('');
        $this->command?->info('Demo credentials: demo@example.com / password');
        $this->command?->info('');
    }
}
