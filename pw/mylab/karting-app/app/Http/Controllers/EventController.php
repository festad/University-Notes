<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

use App\Models\Event;
use App\Models\Organizer;

use App\Http\Controllers\OrganizerController;

class EventController extends Controller
{
    // Given an event id, return
    // the pilots in that event.
    // The name, weight, age and category will be returned.
    public function getPilots(Request $request)
    {
        $eventId = $request->input('eventId');
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

    public function getEventsFromOrganizer(Request $request)
    {
        $userId = $request->input('organizer_id');
        $organizerId = OrganizerController::getOrganizerId($userId);

        $events = Organizer::find($organizerId)->events;
    
        if (!$events) {
            return response()->json(['error' => 'Organizer not found'], 404);
        }
    
        $eventsData = $events->map(function ($event) {
            return [
                'name' => $event->name,
                'description' => $event->description,
                'event_date' => $event->event_date,
            ];
        });
    
        return response()->json($eventsData);
    }

    public function store(Request $request)
    {
        $event = new Event();

        // Organizer of the event is the logged in user
        // Get Organizer's id given the user id
        $organizer_id = OrganizerController::getOrganizerId(Auth::user()->id);
        $event->organizer_id = $organizer_id;

        $event->name = $request->input('name');
        $event->description = $request->input('description');
        $event->event_date = $request->input('date');
        // Created_at and updated_at will be automatically set
        // when the event is saved
        $event->created_at = now();
        $event->updated_at = now();

        $event->save();
        return redirect()->route('organizer');
    }
    
}
