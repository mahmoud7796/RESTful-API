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
use App\Support\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ProjectController extends Controller
{
    public function __construct(private readonly ProjectService $projectService) {}

    public function index(IndexProjectRequest $request): JsonResponse
    {
        return ApiResponse::success(
            ProjectResource::collection($this->projectService->list(
                $request->user(), $request->status(), $request->perPage(),
            )),
            'Projects loaded successfully',
        );
    }

    public function store(StoreProjectRequest $request): JsonResponse
    {
        return ApiResponse::success(
            new ProjectResource($this->projectService->create(
                $request->user(), $request->validatedArray(),
            )),
            'Project created successfully',
            201,
        );
    }

    public function show(Request $request, Project $project): JsonResponse
    {
        return ApiResponse::success(
            new ProjectResource($this->projectService->show($project, $request->user())),
            'Project loaded successfully',
        );
    }

    public function update(UpdateProjectRequest $request, Project $project): JsonResponse
    {
        return ApiResponse::success(
            new ProjectResource($this->projectService->update(
                $project, $request->user(), $request->validatedArray(),
            )),
            'Project updated successfully',
        );
    }

    public function destroy(Request $request, Project $project): JsonResponse
    {
        $this->projectService->delete($project, $request->user());

        return ApiResponse::success(null, 'Project deleted successfully');
    }
}
