<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pilot extends Model
{
    use HasFactory;

    // table pilot
    protected $table = 'pilots';

    // fillable
    protected $fillable = [
        'user_id',
        'age',
        'weight',
        'category',
    ];


    // Many-to-many relatioship with the Event model through
    // the table event_pilot
    public function events()
    {
        return $this->belongsToMany(Event::class, 'event_pilot');
    }

    // One-to-one relationship with the User model
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function getName()
    {
        return $this->user->name;
    }

    public function getEmail()
    {
        return $this->user->email;
    }

}
