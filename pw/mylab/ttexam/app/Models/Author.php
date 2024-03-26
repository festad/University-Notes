<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

use App\Models\User;
use App\Models\Thread;
use App\Models\Comment;

class Author extends Model
{
    use HasFactory;

    protected $table = 'authors';

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function threads()
    {
        return $this->hasMany(Thread::class);
    }

    public function comments()
    {
        return $this->hasMany(Comment::class);
    }
}
