<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Organizer extends Model
{
    use HasFactory;

    // table organizer
    protected $table = 'organizers';

    // fillable
    protected $fillable = [
        'user_id',
        'authority_level'
    ];


    // One-to-many relationship with the Event model
    public function events()
    {
        return $this->hasMany(Event::class);
    }

    // One-to-one relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class);
    }

}
