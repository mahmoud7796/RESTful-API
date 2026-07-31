# Task Management API

## Overview

A Laravel REST API for managing projects and tasks with Sanctum token authentication, Spatie route permissions, and a dashboard of aggregated metrics. Built on **Laravel 13** and **PHP 8.3**, with **Pest 4** as the test runner. All endpoints live under `/api/v1` and share one JSON envelope via `App\Support\ApiResponse`.

## Quick Start (Docker)

Keep the project inside the **WSL filesystem** (e.g. `/home/you/...`), not on a Windows-mounted drive (`/mnt/c/...`). Bind mounts across the Windows/WSL boundary are slow and can cause permission issues with Composer and PHP.

```bash
git clone <repository-url> task-management-api
cd task-management-api
cp .env.example .env
docker compose up -d --build
docker compose exec app composer install
docker compose exec app php artisan key:generate
docker compose exec app php artisan migrate --seed
docker compose exec app php artisan l5-swagger:generate
```

The API is available at `http://localhost:8000/api/v1`.

**Demo credentials** (created by the seeder):

| Email | Password |
|-------|----------|
| `demo@example.com` | `password` |

Import `docs/postman_collection.json` into Postman and run **Login** to populate the bearer token automatically.

Run the test suite:

```bash
docker compose exec app php artisan test
```

## Manual Setup (without Docker)

Requires PHP 8.3+, Composer, MySQL 8, and Redis (used for cache and queues).

```bash
composer install
cp .env.example .env
# Set DB_HOST=127.0.0.1, REDIS_HOST=127.0.0.1, and matching credentials
php artisan key:generate
php artisan migrate --seed
php artisan l5-swagger:generate
php artisan serve
```

Run a queue worker and the scheduler in separate terminals for overdue notifications:

```bash
php artisan queue:work
php artisan schedule:work
```

If `php artisan migrate` fails with `Class "L5Swagger\Generator" not found`, run `composer install` first — the Swagger package must be present in `vendor/` before any Artisan command loads config.

## API Documentation (Swagger)

OpenAPI 3 spec lives in `app/OpenApi/OpenApiSpec.php`. Regenerate after changing endpoints:

```bash
php artisan l5-swagger:generate
```

Swagger UI: [http://localhost:8000/api/documentation](http://localhost:8000/api/documentation)

1. Run **POST /auth/login** (or register) in Swagger and copy the `token` field from the response.
2. Click the **Authorize** button (lock icon, top right).
3. In the **sanctum** field, paste the token from `data.token` in the login/register response — **without** the `Bearer` prefix.
4. Click **Authorize**, then **Close**, then **Try it out** on protected routes.

The generated curl may show `X-CSRF-TOKEN` in addition to `Authorization` — that is normal for the Swagger UI page. If `Authorization` is missing, you have not authorized yet.

Unauthenticated API requests return **401** with `{ "message": "Unauthenticated." }`, not 500.

Postman collection: import `docs/postman_collection.json` (alternative to Swagger UI).

## Architecture Decisions

### Controller → Service → Repository layering

Controllers resolve Form Requests, call a Service, and return an API Resource — nothing else. Services hold business logic and depend on repository **interfaces**, never on Eloquent directly. Repositories handle persistence only: queries, creates, updates, and deletes. Each layer has a single job; crossing boundaries (e.g. query building in a controller, or domain rules in a repository) is avoided.

### Repositories return models and paginators, never query builders

Returning an Eloquent `Builder` leaks persistence concerns to callers and makes it impossible to swap implementations or mock cleanly. Repository methods terminate queries and return concrete results: a `Model`, a `Collection`, a `LengthAwarePaginator`, or a `LazyCollection`.

### Unit-testing services with mocked repositories

Because services type-hint `ProjectRepositoryInterface` and `TaskRepositoryInterface`, unit tests inject Mockery doubles and assert delegation without touching the database. Feature tests hit real HTTP routes with `RefreshDatabase` for end-to-end coverage.

### Application enums over MySQL ENUM columns

Status and priority are backed PHP enums (`ProjectStatus`, `TaskStatus`, `TaskPriority`) stored as `VARCHAR` columns. This keeps migrations simple, avoids painful ENUM alterations, allows enum methods like `label()`, and lets validation use `Rule::enum()` without database coupling.

### Dashboard conditional aggregation (2 queries, not 6)

The dashboard needs six metrics across projects and tasks. Instead of six separate `count()` calls, each repository runs one `SELECT` with conditional `SUM(CASE WHEN …)` aggregation. `DashboardService` composes the two result sets. Query cost stays fixed regardless of how many metrics are displayed.

### Authorization: Spatie permissions vs ownership

**Spatie `permission:` middleware** on routes gates each action (`projects.index`, `tasks.store`, etc.). Run `php artisan migrate --seed` so permissions and the `user` role exist before registering users. New users receive the `user` role automatically when it exists (`User::created` hook). **Ownership** (user A cannot mutate user B's project) is enforced in `ProjectService` / `TaskService`, not in policies or controllers.

### Shallow-nested tasks

Tasks are created under `/projects/{project}/tasks` but show/update/delete use `/tasks/{task}` (shallow nesting). This keeps URLs short for common CRUD while preserving the parent context at creation time.

### Index strategy

| Index | Table | Serves |
|-------|-------|--------|
| `(user_id, status)` | `projects` | Paginated project list filtered by status for the authenticated user |
| `deleted_at` | `projects`, `tasks` | Efficient exclusion of soft-deleted rows |
| `(project_id, status)` | `tasks` | Task list filtered by status within a project |
| `(project_id, priority)` | `tasks` | Task list filtered by priority within a project |
| `due_date` | `tasks` | Overdue detection in the dashboard aggregate and the notification job |

### Overdue notification idempotency

`NotifyOverdueTasksJob` runs hourly and processes overdue tasks in chunks. After notifying the project owner, it stamps `overdue_notified_at` on the task (via `forceFill`, since the column is not mass-assignable). A re-run skips tasks that already have a timestamp, preventing duplicate notifications without external deduplication infrastructure.

## API Reference

| Method | Path | Auth | Description |
|--------|------|------|-------------|
| `POST` | `/api/v1/auth/register` | No | Register a new user; returns user + token |
| `POST` | `/api/v1/auth/login` | No | Authenticate; returns user + token |
| `POST` | `/api/v1/auth/logout` | Yes | Revoke the current token |
| `GET` | `/api/v1/dashboard` | Yes | Aggregated project and task metrics |
| `GET` | `/api/v1/projects` | Yes | List projects (paginated; optional `?status=`, `?per_page=`) |
| `POST` | `/api/v1/projects` | Yes | Create a project |
| `GET` | `/api/v1/projects/{project}` | Yes | Show a project with nested tasks |
| `PATCH` | `/api/v1/projects/{project}` | Yes | Update a project |
| `DELETE` | `/api/v1/projects/{project}` | Yes | Soft-delete a project |
| `GET` | `/api/v1/projects/{project}/tasks` | Yes | List tasks (optional `?status=`, `?priority=`, `?search=`, `?per_page=`) |
| `POST` | `/api/v1/projects/{project}/tasks` | Yes | Create a task |
| `GET` | `/api/v1/tasks/{task}` | Yes | Show a task (shallow route) |
| `PATCH` | `/api/v1/tasks/{task}` | Yes | Update a task (shallow route) |
| `DELETE` | `/api/v1/tasks/{task}` | Yes | Soft-delete a task |

### Auth — register

**Request**

```http
POST /api/v1/auth/register
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com",
  "password": "password123",
  "password_confirmation": "password123"
}
```

**Response** `201 Created`

```json
{
  "success": true,
  "message": "Registered successfully",
  "data": {
    "user": {
      "id": 1,
      "name": "Jane Doe",
      "email": "jane@example.com",
      "created_at": "2026-07-31T12:00:00.000000Z",
      "updated_at": "2026-07-31T12:00:00.000000Z"
    },
    "token": "1|abc123..."
  }
}
```

### Task filtering

**Request**

```http
GET /api/v1/projects/1/tasks?status=in_progress&priority=high&search=homepage&per_page=10
Authorization: Bearer {token}
```

**Response** `200 OK`

```json
{
  "success": true,
  "message": "Tasks loaded successfully",
  "data": [
    {
      "id": 5,
      "title": "Draft homepage copy",
      "description": "Hero section first pass",
      "priority": { "value": "high", "label": "High" },
      "status": { "value": "in_progress", "label": "In Progress" },
      "due_date": "2026-08-15",
      "is_overdue": false,
      "project_id": 1,
      "created_at": "2026-07-31T12:00:00.000000Z",
      "updated_at": "2026-07-31T12:00:00.000000Z"
    }
  ],
  "links": { "first": "...", "last": "...", "prev": null, "next": null },
  "meta": { "current_page": 1, "per_page": 10, "total": 1 }
}
```

### Dashboard

**Request**

```http
GET /api/v1/dashboard
Authorization: Bearer {token}
```

**Response** `200 OK`

```json
{
  "success": true,
  "message": "Dashboard loaded successfully",
  "data": {
    "total_projects": 4,
    "active_projects": 2,
    "total_tasks": 28,
    "completed_tasks": 8,
    "pending_tasks": 20,
    "overdue_tasks": 3
  }
}
```

## Response Format

Every endpoint returns the same top-level shape.

**Success (single resource):**

```json
{
  "success": true,
  "message": "Project loaded successfully",
  "data": { }
}
```

**Success (paginated):**

```json
{
  "success": true,
  "message": "Projects loaded successfully",
  "data": [ ],
  "meta": { "current_page": 1, "per_page": 15, "total": 42 },
  "links": { "first": "...", "last": "...", "prev": null, "next": "..." }
}
```

**Success (delete / logout):**

```json
{
  "success": true,
  "message": "Project deleted successfully",
  "data": null
}
```

**Error:**

```json
{
  "success": false,
  "message": "Human-readable summary",
  "errors": { "field": ["Detail"] }
}
```

Omit `errors` when there are no field-level validation messages.

| Status | When |
|--------|------|
| `200` | Successful read, update, delete, or logout |
| `201` | Resource created |
| `401` | Missing or invalid token |
| `403` | Missing permission or ownership violation |
| `404` | Resource not found |
| `422` | Validation failure (`errors` contains field messages) |
| `500` | Unexpected server error |

## Testing

```bash
docker compose exec app php artisan test
```

The suite uses **Pest** exclusively for domain tests. **Feature tests** hit real HTTP routes with `RefreshDatabase` and cover authentication, authorization (Spatie permissions and service ownership), project CRUD, task CRUD with filter/search datasets, dashboard aggregates (including a query-count assertion), and the overdue notification job. **Unit tests** mock repository interfaces — `ProjectService`, `AuthService` — to verify delegation without a database.

## What I Would Add With More Time

- Unit tests for `TaskService` and `DashboardService`.
- CI pipeline (Pint, Pest, static analysis) on every push.
- Rate limiting on auth endpoints and API-wide throttling.
- Production mail configuration and notification channel tests beyond `Notification::fake()`.
