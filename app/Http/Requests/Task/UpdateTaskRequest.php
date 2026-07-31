<?php

declare(strict_types=1);

namespace App\Http\Requests\Task;

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class UpdateTaskRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'title' => ['sometimes', 'required', 'string', 'max:255'],
            'description' => ['sometimes', 'nullable', 'string', 'max:5000'],
            'priority' => ['sometimes', 'nullable', Rule::enum(TaskPriority::class)],
            'status' => ['sometimes', 'nullable', Rule::enum(TaskStatus::class)],
            'due_date' => ['sometimes', 'nullable', 'date'],
        ];
    }

    public function validatedArray(): array
    {
        return $this->safe()->only(['title', 'description', 'priority', 'status', 'due_date']);
    }
}
