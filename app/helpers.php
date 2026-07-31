<?php

declare(strict_types=1);

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Http\Resources\Json\ResourceCollection;

function responseSuccess(mixed $data, ?string $message = 'Data loaded successfully', int $code = 200): JsonResponse
{
    return response()->json([
        'status' => true,
        'message' => $message,
        'data' => normalizeResponseData($data),
    ], $code);
}

function responseError(mixed $message, int $code = 400, ?array $errors = null): JsonResponse
{
    $payload = [
        'status' => false,
        'message' => $message,
    ];

    if ($errors !== null) {
        $payload['errors'] = $errors;
    }

    return response()->json($payload, $code);
}

function normalizeResponseData(mixed $data): mixed
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
            $normalized[$key] = normalizeResponseData($value);
        }

        return $normalized;
    }

    return $data;
}
