<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Role extends Model
{
    use HasFactory;

    // table role
    protected $table = 'roles';


    // Many-to-many relationship with the User model
    // through the table role_user
    public function users()
    {
        return $this->belongsToMany(User::class, 'role_user');
    }

}
