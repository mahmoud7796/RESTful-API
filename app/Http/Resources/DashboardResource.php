<?php

declare(strict_types=1);

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class DashboardResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'total_projects' => $this->resource['total_projects'],
            'active_projects' => $this->resource['active_projects'],
            'total_tasks' => $this->resource['total_tasks'],
            'completed_tasks' => $this->resource['completed_tasks'],
            'pending_tasks' => $this->resource['pending_tasks'],
            'overdue_tasks' => $this->resource['overdue_tasks'],
        ];
    }
}
