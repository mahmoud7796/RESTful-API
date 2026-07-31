<?php

declare(strict_types=1);

use Database\Seeders\PermissionSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

uses(TestCase::class)->in('Feature', 'Unit');

uses(RefreshDatabase::class)->in('Feature');

beforeEach(function (): void {
    $this->seed(PermissionSeeder::class);
})->in('Feature');
