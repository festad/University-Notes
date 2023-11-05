<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\DB;

// Import auth
use Illuminate\Support\Facades\Auth;

use App\Models\User;
use App\Models\Organizer;
use App\Models\Pilot;
use App\Models\Role;

use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;


class UserController extends Controller
{

    public function checkEmail(Request $request)
    {
        $email = $request->input('email');
        $user = User::where('email', $email)->first();
        if ($user) {
            return response()->json(['message' => 'Email already exists.'], 200);
        } else {
            return response()->json(['message' => 'Email is available.'], 200);
        }
    }

    public function register(Request $request)
    {
        // $validator = Validator::make($request->all(), [
        //     'name' => ['required', 'max:255'],
        //     'email' => ['required', 'email', 'unique:users', 'max:255'],
        //     'password' => ['required', 'confirmed', 'min:8', 'max:255'],
        // ]);

        // if ($validator->fails()) {
        //     return redirect()->route('register')
        //         ->withErrors($validator)
        //         ->withInput();
        // }


        DB::beginTransaction();

        try {
            $user = new User();
            $user->name = $request->input('name');
            $user->email = $request->input('email');
            $user->password = Hash::make($request->input('password'));

            // If the email is already taken, throw an exception
            if (User::where('email', $user->email)->first()) {
                throw new \Exception('Email already exists.');
            }

            $user->save(); // Save the user to get the ID for the role record.

            if ($request->input('role') == 'organizer') {
                // Create an organizer record
                $organizer = new Organizer();
                $organizer->user_id = $user->id; // Make sure to assign the user's ID after saving the user
                $organizer->authority_level = $request->input('authority_level');
                $organizer->save();
                // Role assignment
                $role = Role::where('name', 'Organizer')->first();
                $user->roles()->attach($role->id);
            } elseif ($request->input('role') == 'pilot') {
                // Create a pilot record
                $pilot = new Pilot();
                $pilot->user_id = $user->id;
                $pilot->age = $request->input('age');
                $pilot->weight = $request->input('weight');
                $pilot->category = $request->input('category');
                $pilot->save();
                // Role assignment
                $role = Role::where('name', 'Pilot')->first();
                $user->roles()->attach($role->id);
            }

            DB::commit(); // Commit the transaction
            return redirect()->route('events');
        } catch (\Exception $e) {
            DB::rollBack(); // An error occurred; cancel the transaction
            return redirect()->route('register')->withErrors($e->getMessage())->withInput();
        }
    }

    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        // Attempt to authenticate the user
        if (Auth::attempt($credentials)) {
            // Authentication passed...
            return redirect()->route('events');
        } else {
            return redirect()->route('login')->withErrors('Invalid credentials.');
        }
    }

    public function logout()
    {
        Auth::logout();
        return redirect()->route('welcome'); // Redirect to the welcome page after logout
    }

}
