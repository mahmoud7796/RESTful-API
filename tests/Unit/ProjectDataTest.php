<?php

declare(strict_types=1);

use App\DTOs\ProjectData;
use App\Enums\ProjectStatus;
use Spatie\LaravelData\Optional;

it('casts status strings into ProjectStatus enums', function (): void {
    $data = ProjectData::from([
        'name' => 'Website',
        'status' => 'active',
    ]);

    expect($data->name)->toBe('Website');
    expect($data->status)->toBe(ProjectStatus::Active);
});

it('excludes omitted fields from toArray', function (): void {
    $data = ProjectData::from([
        'name' => 'Website',
    ]);

    expect($data->toArray())->toBe(['name' => 'Website']);
    expect($data->description)->toBeInstanceOf(Optional::class);
});

it('includes explicit null values in toArray', function (): void {
    $data = ProjectData::from([
        'name' => 'Website',
        'description' => null,
    ]);

    expect($data->toArray())->toBe([
        'name' => 'Website',
        'description' => null,
    ]);
});
