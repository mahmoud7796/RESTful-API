<?php

declare(strict_types=1);

namespace App\Models;

use App\Enums\TaskPriority;
use App\Enums\TaskStatus;
use Database\Factories\TaskFactory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\SoftDeletes;

class Task extends Model
{
    /** @use HasFactory<TaskFactory> */
    use HasFactory, SoftDeletes;

    protected $fillable = [
        'title',
        'description',
        'priority',
        'status',
        'due_date',
    ];

    protected function casts(): array
    {
        return [
            'status' => TaskStatus::class,
            'priority' => TaskPriority::class,
            'due_date' => 'date',
            'overdue_notified_at' => 'datetime',
        ];
    }

    public function project(): BelongsTo
    {
        return $this->belongsTo(Project::class);
    }

    protected function isOverdue(): Attribute
    {
        return Attribute::get(function (): bool {
            if ($this->due_date === null) {
                return false;
            }

            return $this->due_date->toDateString() < now()->toDateString()
                && $this->status !== TaskStatus::Done;
        });
    }

    public function scopeWithStatus(Builder $query, ?TaskStatus $status): void
    {
        $query->when($status, fn (Builder $q) => $q->where('status', $status->value));
    }

    public function scopeWithPriority(Builder $query, ?TaskPriority $priority): void
    {
        $query->when($priority, fn (Builder $q) => $q->where('priority', $priority->value));
    }

    public function scopeSearchTitle(Builder $query, ?string $term): void
    {
        $query->when($term, fn (Builder $q) => $q->where('title', 'like', '%'.$term.'%'));
    }

    public function scopeOverdue(Builder $query): void
    {
        $query->whereNotNull('due_date')
            ->whereDate('due_date', '<', now())
            ->where('status', '!=', TaskStatus::Done->value);
    }
}
