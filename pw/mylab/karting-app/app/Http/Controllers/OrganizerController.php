<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Models\Organizer;

class OrganizerController extends Controller
{
    //

    // Get Organizer's id given the user id, static method
    public static function getOrganizerId($userId)
    {
        $organizer = Organizer::where('user_id', $userId)->first();
        return $organizer->id;
    }

}
