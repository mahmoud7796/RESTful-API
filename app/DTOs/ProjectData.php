<?php

declare(strict_types=1);

namespace App\DTOs;

use App\Enums\ProjectStatus;
use Spatie\LaravelData\Attributes\MapName;
use Spatie\LaravelData\Data;
use Spatie\LaravelData\Mappers\SnakeCaseMapper;
use Spatie\LaravelData\Optional;

/**
 * WHY Spatie Optional: PATCH uses `sometimes` rules. Optional marks omitted fields;
 * they are excluded from toArray(). Explicit null is kept, so partial updates do not
 * wipe columns and nullable clears still work.
 */
#[MapName(SnakeCaseMapper::class)]
class ProjectData extends Data
{
    public function __construct(
        public string|null|Optional $name,
        public string|null|Optional $description,
        public ProjectStatus|null|Optional $status,
    ) {}
}
