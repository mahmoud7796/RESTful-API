<?php

declare(strict_types=1);

namespace App\Enums;

enum ProjectStatus: string
{
    case Active = 'active';
    case Completed = 'completed';
    case Archived = 'archived';

    public static function values(): array
    {
        return array_column(self::cases(), 'value');
    }

    public function label(): string
    {
        return match ($this) {
            self::Active => 'Active',
            self::Completed => 'Completed',
            self::Archived => 'Archived',
        };
    }
}
