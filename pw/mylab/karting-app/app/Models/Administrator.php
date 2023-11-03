<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Administrator extends Model
{
    use HasFactory;

    // table administrator
    protected $table = 'administrators';

    // One-to-one relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    
}
