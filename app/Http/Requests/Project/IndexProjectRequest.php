<?php

declare(strict_types=1);

namespace App\Http\Requests\Project;

use App\Enums\ProjectStatus;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class IndexProjectRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'status' => ['nullable', Rule::enum(ProjectStatus::class)],
            'per_page' => ['nullable', 'integer', 'between:1,100'],
        ];
    }

    public function status(): ?ProjectStatus
    {
        $status = $this->validated('status');

        if ($status === null) {
            return null;
        }

        return $status instanceof ProjectStatus ? $status : ProjectStatus::from($status);
    }

    public function perPage(): int
    {
        return $this->integer('per_page', 15);
    }
}
