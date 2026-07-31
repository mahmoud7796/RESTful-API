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
use Illuminate\Http\Response;

class TaskController extends Controller
{
    public function __construct(private readonly TaskService $taskService) {}

    public function index(IndexTaskRequest $request, Project $project): JsonResponse
    {
        $this->authorize('view', $project);

        return TaskResource::collection($this->taskService->list(
            $project,
            $request->status(),
            $request->priority(),
            $request->search(),
            $request->perPage(),
        ))->response();
    }

    public function store(StoreTaskRequest $request, Project $project): JsonResponse
    {
        $this->authorize('update', $project);

        return (new TaskResource($this->taskService->create(
            $project,
            $request->validatedArray(),
        )))->response()->setStatusCode(Response::HTTP_CREATED);
    }

    public function show(Task $task): TaskResource
    {
        $this->authorize('view', $task);

        return new TaskResource($task);
    }

    public function showNested(Project $project, Task $task): TaskResource
    {
        return $this->show($task);
    }

    public function update(UpdateTaskRequest $request, Task $task): TaskResource
    {
        $this->authorize('update', $task);

        return new TaskResource($this->taskService->update($task, $request->validatedArray()));
    }

    public function destroy(Task $task): Response
    {
        $this->authorize('delete', $task);

        $this->taskService->delete($task);

        return response()->noContent();
    }
}
