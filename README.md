# Task Management API

## Overview

A Laravel REST API for managing projects and tasks with token-based authentication, policy-driven authorization, and a dashboard of aggregated metrics. Built on **Laravel 13** and **PHP 8.3**, with **Pest 4** as the test runner. All endpoints live under `/api/v1` and return JSON via API Resources.

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
cp .env.example .env
# Set DB_HOST=127.0.0.1, REDIS_HOST=127.0.0.1, and matching credentials
composer install
php artisan key:generate
php artisan migrate --seed
php artisan serve
```

Run a queue worker and the scheduler in separate terminals for overdue notifications:

```bash
php artisan queue:work
php artisan schedule:work
```

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

### Authorization: Policies vs query scopes

**Policies** answer "may this user act on this specific model?" — ownership checks on `view`, `update`, and `delete`. **Query scopes** (`ownedBy`, `withStatus`) answer "which rows belong in this list?" — applied in repositories so index endpoints never return another user's data. Policies gate individual resources; scopes constrain collections.

### Shallow-nested tasks with scopeBindings

Tasks are created under `/projects/{project}/tasks` but accessed at `/tasks/{task}` (shallow nesting). This keeps URLs short for common CRUD while preserving the parent context at creation time. `scopeBindings()` on the route group ensures nested routes like `/projects/{project}/tasks/{task}` return 404 when the task does not belong to the project.

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
| `GET` | `/api/v1/projects/{project}/tasks/{task}` | Yes | Show a task scoped to parent project |

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
  "data": {
    "id": 1,
    "name": "Jane Doe",
    "email": "jane@example.com",
    "email_verified_at": null,
    "created_at": "2026-07-31T12:00:00.000000Z",
    "updated_at": "2026-07-31T12:00:00.000000Z"
  },
  "token": "1|abc123..."
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

## Error Response Format

All API errors use a consistent envelope:

```json
{
  "message": "Human-readable summary",
  "errors": { "field": ["Detail"] }
}
```

`errors` is `null` for non-validation failures.

| Status | When |
|--------|------|
| `200` | Successful read or update |
| `201` | Resource created |
| `204` | Resource deleted (empty body) |
| `401` | Missing or invalid token |
| `403` | Authenticated but not authorized |
| `404` | Resource not found (includes scope binding mismatches) |
| `422` | Validation failure (`errors` contains field messages) |
| `500` | Unexpected server error |

## Testing

```bash
docker compose exec app php artisan test
```

The suite uses **Pest** exclusively for domain tests. **Feature tests** hit real HTTP routes with `RefreshDatabase` and cover authentication, project CRUD, task CRUD with filter/search datasets, dashboard aggregates (including a query-count assertion), and the overdue notification job. **Unit tests** mock repository interfaces — currently `ProjectService` — to verify delegation without a database.

## What I Would Add With More Time

- A `UserRepository` to bring auth in line with the repository layering used elsewhere.
- OpenAPI documentation wired to the existing `l5-swagger` package.
- Unit tests for `TaskService` and `DashboardService`.
- CI pipeline (Pint, Pest, static analysis) on every push.
- Rate limiting on auth endpoints and API-wide throttling.
- Production mail configuration and notification channel tests beyond `Notification::fake()`.
