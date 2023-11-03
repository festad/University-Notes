<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use App\Models\User;
use App\Models\Pilot;
use App\Models\Administrator;
use App\Models\Organizer;
use App\Models\Role;
use App\Models\Event;


class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // \App\Models\User::factory(10)->create();

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);

        // Create the roles Pilot, Administrator, Organizer
        $pilot_role = Role::create([
            'name' => 'Pilot',
        ]);
        $admin_role = Role::create([
            'name' => 'Administrator',
        ]);
        $organizer_role = Role::create([
            'name' => 'Organizer',
        ]);

        // Create God with all roles
        $god = User::factory()->create([
            'name' => 'God',
            'email' => 'god@universe.unibs.it',
            'password' => bcrypt('god'),
        ]);

        $god->roles()->attach($pilot_role->id);
        $god->roles()->attach($admin_role->id);
        $god->roles()->attach($organizer_role->id);

        // Create pilots
        $pilots = Pilot::factory()->count(10)->create();

        // Create administrators
        $administrators = Administrator::factory()->count(2)->create();

        // Create 3 organizers
        $organizers = Organizer::factory()->count(5)->create();

        // Create 3 events
        // Assigning to each event a random organizer
        // is already done in the EventFactory
        $events = Event::factory()->count(5)->create();

        // Assign to each pilot random events
        // Careful to not assign the same event twice.
        // Cycle over all the events and toss a coin to
        // decide if the pilot will participate or not.
        foreach ($pilots as $pilot) {
            foreach ($events as $event) {
                if (rand(0, 1) == 1) {
                    $pilot->events()->attach($event->id);
                }
            }
            // Why not pilot->save()?
            // Because the attach() method already saves the pivot table
        }

    }
}
