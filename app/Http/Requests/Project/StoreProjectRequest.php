<?php

declare(strict_types=1);

namespace App\Http\Requests\Project;

use App\DTOs\ProjectData;
use App\Enums\ProjectStatus;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StoreProjectRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name' => ['required', 'string', 'max:255'],
            'description' => ['nullable', 'string', 'max:5000'],
            'status' => ['nullable', Rule::enum(ProjectStatus::class)],
        ];
    }

    public function toData(): ProjectData
    {
        return ProjectData::from($this->safe()->only(['name', 'description', 'status']));
    }
}
