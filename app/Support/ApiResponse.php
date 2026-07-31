<?php

declare(strict_types=1);

namespace App\Support;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Http\Resources\Json\ResourceCollection;

final class ApiResponse
{
    public static function success(
        mixed $data = null,
        ?string $message = null,
        int $code = 200,
    ): JsonResponse {
        $body = [
            'success' => true,
            'message' => $message,
        ];

        if ($data instanceof ResourceCollection) {
            $resolved = $data->response()->getData(true);

            $body['data'] = $resolved['data'] ?? [];

            foreach (['meta', 'links'] as $key) {
                if (isset($resolved[$key])) {
                    $body[$key] = $resolved[$key];
                }
            }
        } elseif ($data instanceof JsonResource) {
            $body['data'] = $data->resolve(request());
        } else {
            $body['data'] = self::resolveValue($data);
        }

        return response()->json($body, $code);
    }

    private static function resolveValue(mixed $value): mixed
    {
        if ($value instanceof JsonResource) {
            return $value->resolve(request());
        }

        if (is_array($value)) {
            $resolved = [];

            foreach ($value as $key => $item) {
                $resolved[$key] = self::resolveValue($item);
            }

            return $resolved;
        }

        return $value;
    }

    public static function error(
        string $message,
        int $code = 400,
        ?array $errors = null,
    ): JsonResponse {
        $body = [
            'success' => false,
            'message' => $message,
        ];

        if ($errors !== null) {
            $body['errors'] = $errors;
        }

        return response()->json($body, $code);
    }
}
