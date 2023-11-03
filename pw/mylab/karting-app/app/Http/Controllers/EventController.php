<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Event;

class EventController extends Controller
{
    // Given an event id, return
    // the pilots in that event.
    // The name, weight, age and category will be returned.
    public function getPilots($eventId)
    {
        $pilots = Event::find($eventId)->pilots;
    
        if (!$pilots) {
            return response()->json(['error' => 'Event not found'], 404);
        }
    
        $pilotsData = $pilots->map(function ($pilot) {
            return [
                'name' => $pilot->user->name, // This is where you get the pilot's name from the related User model
                'weight' => $pilot->weight,
                'age' => $pilot->age,
                'category' => $pilot->category,
            ];
        });
    
        return response()->json($pilotsData);
    }
    
}
