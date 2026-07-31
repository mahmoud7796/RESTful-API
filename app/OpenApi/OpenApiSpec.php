<?php

declare(strict_types=1);

namespace App\OpenApi;

use OpenApi\Attributes as OA;

#[OA\OpenApi(
    openapi: '3.0.0',
    info: new OA\Info(
        title: 'Task Management API',
        version: '1.0.0',
        description: 'REST API for projects, tasks, dashboard metrics, and Sanctum token auth.',
    ),
    servers: [
        new OA\Server(url: 'http://localhost:8000/api/v1', description: 'Local development'),
    ],
    components: new OA\Components(
        securitySchemes: [
            new OA\SecurityScheme(
                securityScheme: 'sanctum',
                type: 'http',
                scheme: 'bearer',
                bearerFormat: 'Sanctum',
                description: 'Bearer token from /auth/login or /auth/register',
            ),
        ],
    ),
    security: [['sanctum' => []]],
    tags: [
        new OA\Tag(name: 'Auth', description: 'Registration, login, logout'),
        new OA\Tag(name: 'Dashboard', description: 'Aggregated metrics'),
        new OA\Tag(name: 'Projects', description: 'Project CRUD'),
        new OA\Tag(name: 'Tasks', description: 'Task CRUD and filtering'),
    ],
)]
#[OA\Post(
    path: '/auth/register',
    operationId: 'authRegister',
    summary: 'Register a new user',
    tags: ['Auth'],
    security: [],
    requestBody: new OA\RequestBody(
        required: true,
        content: new OA\JsonContent(
            required: ['name', 'email', 'password', 'password_confirmation'],
            properties: [
                new OA\Property(property: 'name', type: 'string', example: 'Jane Doe'),
                new OA\Property(property: 'email', type: 'string', format: 'email', example: 'jane@example.com'),
                new OA\Property(property: 'password', type: 'string', format: 'password', example: 'password123'),
                new OA\Property(property: 'password_confirmation', type: 'string', format: 'password', example: 'password123'),
            ],
        ),
    ),
    responses: [
        new OA\Response(response: 201, description: 'User registered'),
        new OA\Response(response: 422, description: 'Validation error'),
    ],
)]
#[OA\Post(
    path: '/auth/login',
    operationId: 'authLogin',
    summary: 'Obtain a bearer token',
    tags: ['Auth'],
    security: [],
    requestBody: new OA\RequestBody(
        required: true,
        content: new OA\JsonContent(
            required: ['email', 'password'],
            properties: [
                new OA\Property(property: 'email', type: 'string', format: 'email', example: 'demo@example.com'),
                new OA\Property(property: 'password', type: 'string', format: 'password', example: 'password'),
            ],
        ),
    ),
    responses: [
        new OA\Response(response: 200, description: 'Authenticated'),
        new OA\Response(response: 422, description: 'Invalid credentials'),
    ],
)]
#[OA\Post(
    path: '/auth/logout',
    operationId: 'authLogout',
    summary: 'Revoke the current token',
    tags: ['Auth'],
    responses: [
        new OA\Response(response: 200, description: 'Logged out'),
        new OA\Response(response: 401, description: 'Unauthenticated'),
    ],
)]
#[OA\Get(
    path: '/dashboard',
    operationId: 'dashboardShow',
    summary: 'Dashboard metrics for the authenticated user',
    tags: ['Dashboard'],
    responses: [
        new OA\Response(response: 200, description: 'Dashboard totals'),
        new OA\Response(response: 401, description: 'Unauthenticated'),
        new OA\Response(response: 403, description: 'Missing permission'),
    ],
)]
#[OA\Get(
    path: '/projects',
    operationId: 'projectsIndex',
    summary: 'List projects',
    tags: ['Projects'],
    parameters: [
        new OA\Parameter(name: 'status', in: 'query', schema: new OA\Schema(type: 'string', enum: ['active', 'completed', 'archived'])),
        new OA\Parameter(name: 'per_page', in: 'query', schema: new OA\Schema(type: 'integer', minimum: 1, maximum: 100, default: 15)),
    ],
    responses: [
        new OA\Response(response: 200, description: 'Paginated project list'),
    ],
)]
#[OA\Post(
    path: '/projects',
    operationId: 'projectsStore',
    summary: 'Create a project',
    tags: ['Projects'],
    requestBody: new OA\RequestBody(
        required: true,
        content: new OA\JsonContent(
            required: ['name'],
            properties: [
                new OA\Property(property: 'name', type: 'string', example: 'Website Redesign'),
                new OA\Property(property: 'description', type: 'string', nullable: true, example: 'Q3 marketing site refresh'),
                new OA\Property(property: 'status', type: 'string', enum: ['active', 'completed', 'archived'], example: 'active'),
            ],
        ),
    ),
    responses: [
        new OA\Response(response: 201, description: 'Project created'),
        new OA\Response(response: 422, description: 'Validation error'),
    ],
)]
#[OA\Get(
    path: '/projects/{project}',
    operationId: 'projectsShow',
    summary: 'Show a project with nested tasks',
    tags: ['Projects'],
    parameters: [
        new OA\Parameter(name: 'project', in: 'path', required: true, schema: new OA\Schema(type: 'integer')),
    ],
    responses: [
        new OA\Response(response: 200, description: 'Project details'),
        new OA\Response(response: 403, description: 'Not owned by user'),
        new OA\Response(response: 404, description: 'Not found'),
    ],
)]
#[OA\Patch(
    path: '/projects/{project}',
    operationId: 'projectsUpdate',
    summary: 'Update a project',
    tags: ['Projects'],
    parameters: [
        new OA\Parameter(name: 'project', in: 'path', required: true, schema: new OA\Schema(type: 'integer')),
    ],
    requestBody: new OA\RequestBody(
        content: new OA\JsonContent(
            properties: [
                new OA\Property(property: 'name', type: 'string'),
                new OA\Property(property: 'description', type: 'string', nullable: true),
                new OA\Property(property: 'status', type: 'string', enum: ['active', 'completed', 'archived']),
            ],
        ),
    ),
    responses: [
        new OA\Response(response: 200, description: 'Project updated'),
    ],
)]
#[OA\Delete(
    path: '/projects/{project}',
    operationId: 'projectsDestroy',
    summary: 'Soft-delete a project',
    tags: ['Projects'],
    parameters: [
        new OA\Parameter(name: 'project', in: 'path', required: true, schema: new OA\Schema(type: 'integer')),
    ],
    responses: [
        new OA\Response(response: 200, description: 'Project deleted'),
    ],
)]
#[OA\Get(
    path: '/projects/{project}/tasks',
    operationId: 'tasksIndex',
    summary: 'List tasks in a project',
    tags: ['Tasks'],
    parameters: [
        new OA\Parameter(name: 'project', in: 'path', required: true, schema: new OA\Schema(type: 'integer')),
        new OA\Parameter(name: 'status', in: 'query', schema: new OA\Schema(type: 'string', enum: ['todo', 'in_progress', 'done'])),
        new OA\Parameter(name: 'priority', in: 'query', schema: new OA\Schema(type: 'string', enum: ['low', 'medium', 'high'])),
        new OA\Parameter(name: 'search', in: 'query', schema: new OA\Schema(type: 'string')),
        new OA\Parameter(name: 'per_page', in: 'query', schema: new OA\Schema(type: 'integer', minimum: 1, maximum: 100, default: 15)),
    ],
    responses: [
        new OA\Response(response: 200, description: 'Paginated task list'),
        new OA\Response(response: 403, description: 'Project not owned by user'),
    ],
)]
#[OA\Post(
    path: '/projects/{project}/tasks',
    operationId: 'tasksStore',
    summary: 'Create a task',
    tags: ['Tasks'],
    parameters: [
        new OA\Parameter(name: 'project', in: 'path', required: true, schema: new OA\Schema(type: 'integer')),
    ],
    requestBody: new OA\RequestBody(
        required: true,
        content: new OA\JsonContent(
            required: ['title'],
            properties: [
                new OA\Property(property: 'title', type: 'string', example: 'Draft homepage copy'),
                new OA\Property(property: 'description', type: 'string', nullable: true),
                new OA\Property(property: 'priority', type: 'string', enum: ['low', 'medium', 'high'], example: 'high'),
                new OA\Property(property: 'status', type: 'string', enum: ['todo', 'in_progress', 'done'], example: 'todo'),
                new OA\Property(property: 'due_date', type: 'string', format: 'date', example: '2026-08-15'),
            ],
        ),
    ),
    responses: [
        new OA\Response(response: 201, description: 'Task created'),
    ],
)]
#[OA\Get(
    path: '/tasks/{task}',
    operationId: 'tasksShow',
    summary: 'Show a task (shallow route)',
    tags: ['Tasks'],
    parameters: [
        new OA\Parameter(name: 'task', in: 'path', required: true, schema: new OA\Schema(type: 'integer')),
    ],
    responses: [
        new OA\Response(response: 200, description: 'Task details'),
        new OA\Response(response: 403, description: 'Not owned by user'),
    ],
)]
#[OA\Get(
    path: '/projects/{project}/tasks/{task}',
    operationId: 'tasksShowNested',
    summary: 'Show a task scoped to a project',
    tags: ['Tasks'],
    parameters: [
        new OA\Parameter(name: 'project', in: 'path', required: true, schema: new OA\Schema(type: 'integer')),
        new OA\Parameter(name: 'task', in: 'path', required: true, schema: new OA\Schema(type: 'integer')),
    ],
    responses: [
        new OA\Response(response: 200, description: 'Task details'),
        new OA\Response(response: 404, description: 'Task does not belong to project'),
    ],
)]
#[OA\Patch(
    path: '/tasks/{task}',
    operationId: 'tasksUpdate',
    summary: 'Update a task',
    tags: ['Tasks'],
    parameters: [
        new OA\Parameter(name: 'task', in: 'path', required: true, schema: new OA\Schema(type: 'integer')),
    ],
    requestBody: new OA\RequestBody(
        content: new OA\JsonContent(
            properties: [
                new OA\Property(property: 'title', type: 'string'),
                new OA\Property(property: 'description', type: 'string', nullable: true),
                new OA\Property(property: 'priority', type: 'string', enum: ['low', 'medium', 'high']),
                new OA\Property(property: 'status', type: 'string', enum: ['todo', 'in_progress', 'done']),
                new OA\Property(property: 'due_date', type: 'string', format: 'date', nullable: true),
            ],
        ),
    ),
    responses: [
        new OA\Response(response: 200, description: 'Task updated'),
    ],
)]
#[OA\Delete(
    path: '/tasks/{task}',
    operationId: 'tasksDestroy',
    summary: 'Soft-delete a task',
    tags: ['Tasks'],
    parameters: [
        new OA\Parameter(name: 'task', in: 'path', required: true, schema: new OA\Schema(type: 'integer')),
    ],
    responses: [
        new OA\Response(response: 200, description: 'Task deleted'),
    ],
)]
class OpenApiSpec {}
