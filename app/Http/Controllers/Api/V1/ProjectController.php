<?php

declare(strict_types=1);

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Http\Requests\Project\IndexProjectRequest;
use App\Http\Requests\Project\StoreProjectRequest;
use App\Http\Requests\Project\UpdateProjectRequest;
use App\Http\Resources\ProjectResource;
use App\Models\Project;
use App\Services\ProjectService;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Response;

class ProjectController extends Controller
{
    public function __construct(private readonly ProjectService $projectService) {}

    public function index(IndexProjectRequest $request): JsonResponse
    {
        $this->authorize('viewAny', Project::class);

        return ProjectResource::collection($this->projectService->list(
            $request->user(), $request->status(), $request->perPage(),
        ))->response();
    }

    public function store(StoreProjectRequest $request): JsonResponse
    {
        $this->authorize('create', Project::class);

        return (new ProjectResource($this->projectService->create(
            $request->user(), $request->validatedArray(),
        )))->response()->setStatusCode(Response::HTTP_CREATED);
    }

    public function show(Project $project): ProjectResource
    {
        $this->authorize('view', $project);

        return new ProjectResource($this->projectService->show($project));
    }

    public function update(UpdateProjectRequest $request, Project $project): ProjectResource
    {
        $this->authorize('update', $project);

        return new ProjectResource($this->projectService->update($project, $request->validatedArray()));
    }

    public function destroy(Project $project): Response
    {
        $this->authorize('delete', $project);
        $this->projectService->delete($project);

        return response()->noContent();
    }
}
