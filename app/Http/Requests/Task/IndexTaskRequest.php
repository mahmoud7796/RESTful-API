<?php

declare(strict_types=1);

namespace App\Http\Requests\Task;

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class IndexTaskRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'status' => ['nullable', Rule::enum(TaskStatus::class)],
            'priority' => ['nullable', Rule::enum(TaskPriority::class)],
            'search' => ['nullable', 'string', 'max:255'],
            'per_page' => ['nullable', 'integer', 'between:1,100'],
        ];
    }

    public function status(): ?TaskStatus
    {
        $status = $this->validated('status');

        if ($status === null) {
            return null;
        }

        return $status instanceof TaskStatus ? $status : TaskStatus::from($status);
    }

    public function priority(): ?TaskPriority
    {
        $priority = $this->validated('priority');

        if ($priority === null) {
            return null;
        }

        return $priority instanceof TaskPriority ? $priority : TaskPriority::from($priority);
    }

    public function search(): ?string
    {
        return $this->validated('search');
    }

    public function perPage(): int
    {
        return $this->integer('per_page', 15);
    }
}
