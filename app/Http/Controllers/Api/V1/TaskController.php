<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\Task\IndexTaskRequest;
use App\Http\Requests\Task\StoreTaskRequest;
use App\Http\Requests\Task\UpdateTaskRequest;
use App\Http\Resources\TaskResource;
use App\Models\Project;
use App\Models\Task;
use App\Services\TaskService;
use App\Support\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class TaskController extends Controller
{
    public function __construct(private readonly TaskService $taskService) {}

    public function index(IndexTaskRequest $request, Project $project): JsonResponse
    {
        return ApiResponse::success(
            TaskResource::collection($this->taskService->list(
                $project,
                $request->user(),
                $request->status(),
                $request->priority(),
                $request->search(),
                $request->perPage(),
            )),
        );
    }

    public function store(StoreTaskRequest $request, Project $project): JsonResponse
    {
        return ApiResponse::success(
            new TaskResource($this->taskService->create(
                $project,
                $request->user(),
                $request->validatedArray(),
            )),
            code: 201,
        );
    }

    public function show(Request $request, Task $task): JsonResponse
    {
        return ApiResponse::success(
            new TaskResource($this->taskService->show($task, $request->user())),
        );
    }

    public function update(UpdateTaskRequest $request, Task $task): JsonResponse
    {
        return ApiResponse::success(
            new TaskResource($this->taskService->update(
                $task, $request->user(), $request->validatedArray(),
            )),
        );
    }

    public function destroy(Request $request, Task $task): Response
    {
        $this->taskService->delete($task, $request->user());

        return response()->noContent();
    }
}
