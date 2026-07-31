<?php

declare(strict_types=1);

use App\Support\ApiResponse;
use Illuminate\Auth\Access\AuthorizationException;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;
use Illuminate\Http\Request;
use Illuminate\Validation\ValidationException;
use Spatie\Permission\Exceptions\UnauthorizedException;
use Spatie\Permission\Middleware\PermissionMiddleware;
use Spatie\Permission\Middleware\RoleMiddleware;
use Spatie\Permission\Middleware\RoleOrPermissionMiddleware;
use Symfony\Component\HttpKernel\Exception\AccessDeniedHttpException;
use Symfony\Component\HttpKernel\Exception\MethodNotAllowedHttpException;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->redirectGuestsTo(
            fn (Request $request) => $request->expectsJson() || $request->is('api/*') ? null : '/',
        );

        $middleware->alias([
            'role' => RoleMiddleware::class,
            'permission' => PermissionMiddleware::class,
            'role_or_permission' => RoleOrPermissionMiddleware::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        $exceptions->shouldRenderJsonWhen(
            fn (Request $request) => $request->expectsJson() || $request->is('api/*'),
        );

        $exceptions->render(function (Throwable $e, Request $request) {
            if (! $request->expectsJson() && ! $request->is('api/*')) {
                return null;
            }

            if ($e instanceof ValidationException) {
                return ApiResponse::error($e->getMessage(), 422, $e->errors());
            }

            if ($e instanceof AuthenticationException) {
                return ApiResponse::error('Unauthenticated.', 401);
            }

            if ($e instanceof UnauthorizedException
                || $e instanceof AuthorizationException
                || $e instanceof AccessDeniedHttpException) {
                return ApiResponse::error('This action is unauthorized.', 403);
            }

            if ($e instanceof ModelNotFoundException || $e instanceof NotFoundHttpException) {
                return ApiResponse::error('Resource not found.', 404);
            }

            if ($e instanceof MethodNotAllowedHttpException) {
                return ApiResponse::error('Method not allowed.', 405);
            }

            return ApiResponse::error(
                'Server Error.',
                500,
                config('app.debug') ? [
                    'exception' => $e->getMessage(),
                    'file' => $e->getFile(),
                    'line' => $e->getLine(),
                ] : null,
            );
        });
    })->create();
