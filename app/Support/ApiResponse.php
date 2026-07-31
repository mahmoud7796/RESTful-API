<?php

declare(strict_types=1);

namespace App\Support;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Http\Resources\Json\ResourceCollection;

final class ApiResponse
{
    public static function success(mixed $data = null, int $code = 200): JsonResponse
    {
        if ($data instanceof ResourceCollection || $data instanceof JsonResource) {
            return $data->response()->setStatusCode($code);
        }

        return response()->json(self::normalize($data), $code);
    }

    public static function error(string $message, int $code = 400, ?array $errors = null): JsonResponse
    {
        return response()->json([
            'message' => $message,
            'errors' => $errors,
        ], $code);
    }

    private static function normalize(mixed $data): mixed
    {
        if ($data instanceof ResourceCollection) {
            return $data->response()->getData(true);
        }

        if ($data instanceof JsonResource) {
            return $data->resolve(request());
        }

        if (is_array($data)) {
            $normalized = [];

            foreach ($data as $key => $value) {
                $normalized[$key] = self::normalize($value);
            }

            return $normalized;
        }

        return $data;
    }
}
