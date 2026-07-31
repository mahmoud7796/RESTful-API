<?php

declare(strict_types=1);

use App\DTOs\TaskData;
use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use Carbon\CarbonImmutable;
use Spatie\LaravelData\Optional;

it('casts strings into enums and CarbonImmutable', function (): void {
    $data = TaskData::from([
        'title' => 'Deploy',
        'priority' => 'high',
        'status' => 'todo',
        'due_date' => '2026-08-15',
    ]);

    expect($data->title)->toBe('Deploy');
    expect($data->priority)->toBe(TaskPriority::High);
    expect($data->status)->toBe(TaskStatus::Todo);
    expect($data->dueDate)->toBeInstanceOf(CarbonImmutable::class)
        ->and($data->dueDate->toDateString())->toBe('2026-08-15');
});

it('excludes omitted fields from toArray', function (): void {
    $data = TaskData::from([
        'title' => 'Deploy',
    ]);

    expect($data->toArray())->toBe(['title' => 'Deploy']);
    expect($data->dueDate)->toBeInstanceOf(Optional::class);
});

it('includes explicit null values in toArray', function (): void {
    $data = TaskData::from([
        'title' => 'Deploy',
        'due_date' => null,
    ]);

    expect($data->toArray())->toBe([
        'title' => 'Deploy',
        'due_date' => null,
    ]);
});
