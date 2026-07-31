<?php

declare(strict_types=1);

use App\Http\Controllers\Api\V1\AuthController;
use App\Http\Controllers\Api\V1\DashboardController;
use App\Http\Controllers\Api\V1\ProjectController;
use App\Http\Controllers\Api\V1\TaskController;
use Illuminate\Support\Facades\Route;

Route::prefix('v1')->group(function (): void {
    Route::prefix('auth')->group(function (): void {
        Route::post('register', [AuthController::class, 'register']);
        Route::post('login', [AuthController::class, 'login']);

        Route::post('logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');
    });

    Route::middleware('auth:sanctum')->scopeBindings()->group(function (): void {
        Route::get('dashboard', DashboardController::class)
            ->middleware('permission:dashboard.view');

        Route::apiResource('projects', ProjectController::class)
            ->middlewareFor('index', 'permission:projects.index')
            ->middlewareFor('store', 'permission:projects.store')
            ->middlewareFor('show', 'permission:projects.show')
            ->middlewareFor('update', 'permission:projects.update')
            ->middlewareFor('destroy', 'permission:projects.destroy');

        Route::apiResource('projects.tasks', TaskController::class)
            ->shallow()
            ->middlewareFor('index', 'permission:tasks.index')
            ->middlewareFor('store', 'permission:tasks.store')
            ->middlewareFor('show', 'permission:tasks.show')
            ->middlewareFor('update', 'permission:tasks.update')
            ->middlewareFor('destroy', 'permission:tasks.destroy');
    });
});
