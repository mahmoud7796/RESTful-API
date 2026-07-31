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
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    public function __construct(private readonly TaskService $taskService) {}

    public function index(IndexTaskRequest $request, Project $project): JsonResponse
    {
        return responseSuccess(
            data: TaskResource::collection($this->taskService->list(
                $project,
                $request->user(),
                $request->status(),
                $request->priority(),
                $request->search(),
                $request->perPage(),
            )),
            message: 'Tasks loaded successfully',
        );
    }

    public function store(StoreTaskRequest $request, Project $project): JsonResponse
    {
        return responseSuccess(
            data: new TaskResource($this->taskService->create(
                $project,
                $request->user(),
                $request->validatedArray(),
            )),
            message: 'Task created successfully',
            code: 201,
        );
    }

    public function show(Request $request, Task $task): JsonResponse
    {
        return responseSuccess(
            data: new TaskResource($this->taskService->show($task, $request->user())),
            message: 'Task loaded successfully',
        );
    }

    public function showNested(Request $request, Project $project, Task $task): JsonResponse
    {
        return $this->show($request, $task);
    }

    public function update(UpdateTaskRequest $request, Task $task): JsonResponse
    {
        return responseSuccess(
            data: new TaskResource($this->taskService->update(
                $task, $request->user(), $request->validatedArray(),
            )),
            message: 'Task updated successfully',
        );
    }

    public function destroy(Request $request, Task $task): JsonResponse
    {
        $this->taskService->delete($task, $request->user());

        return responseSuccess(null, 'Task deleted successfully');
    }
}
