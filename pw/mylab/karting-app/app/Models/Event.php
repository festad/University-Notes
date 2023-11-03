<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Event extends Model
{
    use HasFactory;

    // table event
    protected $table = 'events';

    // fillable
    protected $fillable = [
        'name',
        'description',
        'event_date',
        'organizer_id',
    ];


    // Many-to-many relatioship with the Pilot model through
    // the table event_pilot
    public function pilots()
    {
        return $this->belongsToMany(Pilot::class, 'event_pilot');
    }

    // One-to-many relationship with the Organizer model
    public function organizer()
    {
        return $this->belongsTo(Organizer::class);
    }



}
