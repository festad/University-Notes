<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

use App\Models\Event;
use App\Models\Organizer;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Event>
 */
class EventFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {

        return [
            // randomly choose an organizer_id from the organizers table
            'organizer_id' => Organizer::all()->random()->id,
            'name' => $this->faker->company(),
            'description' => $this->faker->text(),
            'event_date' => $this->faker->dateTimeBetween('now', '+1 year'),
        ];
    }
}
