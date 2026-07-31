<?php

declare(strict_types=1);

namespace Database\Factories;

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use App\Models\Project;
use App\Models\Task;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Task>
 */
class TaskFactory extends Factory
{
    protected $model = Task::class;

    public function definition(): array
    {
        return [
            'project_id' => Project::factory(),
            'title' => fake()->sentence(4),
            'description' => fake()->optional()->paragraph(),
            'priority' => fake()->randomElement(TaskPriority::cases()),
            'status' => fake()->randomElement(TaskStatus::cases()),
            'due_date' => fake()->randomElement([
                fake()->dateTimeBetween('-60 days', '-1 day')->format('Y-m-d'),
                fake()->dateTimeBetween('+1 day', '+60 days')->format('Y-m-d'),
                null,
            ]),
        ];
    }

    public function overdue(): static
    {
        return $this->state(fn () => [
            'due_date' => fake()->dateTimeBetween('-60 days', '-1 day')->format('Y-m-d'),
            'status' => fake()->randomElement([TaskStatus::Todo, TaskStatus::InProgress]),
        ]);
    }

    public function done(): static
    {
        return $this->state(fn () => [
            'status' => TaskStatus::Done,
        ]);
    }
}
