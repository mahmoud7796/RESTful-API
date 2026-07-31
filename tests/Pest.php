<?php

declare(strict_types=1);

use Database\Seeders\PermissionSeeder;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

uses(TestCase::class, RefreshDatabase::class)
    ->beforeEach(function (): void {
        $this->seed(PermissionSeeder::class);
    })
    ->in('Feature');

uses(TestCase::class)->in('Unit');
