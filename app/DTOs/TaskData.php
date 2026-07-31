<?php

declare(strict_types=1);

namespace App\DTOs;

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use Carbon\CarbonImmutable;
use Spatie\LaravelData\Attributes\MapName;
use Spatie\LaravelData\Attributes\WithCast;
use Spatie\LaravelData\Attributes\WithTransformer;
use Spatie\LaravelData\Casts\DateTimeInterfaceCast;
use Spatie\LaravelData\Data;
use Spatie\LaravelData\Mappers\SnakeCaseMapper;
use Spatie\LaravelData\Optional;
use Spatie\LaravelData\Transformers\DateTimeInterfaceTransformer;

/**
 * WHY Spatie Optional: PATCH uses `sometimes` rules. Optional marks omitted fields;
 * they are excluded from toArray(). Explicit null is kept, so partial updates do not
 * wipe columns and nullable clears still work.
 */
#[MapName(SnakeCaseMapper::class)]
class TaskData extends Data
{
    public function __construct(
        public string|null|Optional $title,
        public string|null|Optional $description,
        public TaskPriority|null|Optional $priority,
        public TaskStatus|null|Optional $status,
        #[WithCast(DateTimeInterfaceCast::class, format: 'Y-m-d')]
        #[WithTransformer(DateTimeInterfaceTransformer::class, format: 'Y-m-d')]
        public CarbonImmutable|null|Optional $dueDate,
    ) {}
}
