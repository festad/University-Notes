<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DataLayer\PilotDataLayer;

use App\Models\Pilot;


class PilotController extends Controller
{
    public function getPilotName($pilotId)
    {
        return Pilot::find($pilotId)->getName();
    }
}
