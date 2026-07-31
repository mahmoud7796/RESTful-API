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

        Route::middleware('auth:sanctum')->post('logout', [AuthController::class, 'logout']);
    });

    Route::middleware('auth:sanctum')->scopeBindings()->group(function (): void {
        Route::get('dashboard', DashboardController::class)
            ->middleware('permission:dashboard.view');

        Route::apiResource('projects', ProjectController::class)->middleware([
            'index' => 'permission:projects.index',
            'store' => 'permission:projects.store',
            'show' => 'permission:projects.show',
            'update' => 'permission:projects.update',
            'destroy' => 'permission:projects.destroy',
        ]);

        Route::apiResource('projects.tasks', TaskController::class)->shallow()->middleware([
            'index' => 'permission:tasks.index',
            'store' => 'permission:tasks.store',
            'show' => 'permission:tasks.show',
            'update' => 'permission:tasks.update',
            'destroy' => 'permission:tasks.destroy',
        ]);

        Route::get('projects/{project}/tasks/{task}', [TaskController::class, 'showNested'])
            ->middleware('permission:tasks.show')
            ->scopeBindings()
            ->name('projects.tasks.nested-show');
    });
});
