<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\Thread;

class Tag extends Model
{
    use HasFactory;

    protected $table = 'tags';

    public function threads()
    {
        return $this->belongsToMany(Thread::class, 'tag_thread', 'tag_id', 'thread_id')->distinct();
    }

}
