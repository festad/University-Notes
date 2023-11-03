<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

use App\Models\Pilot;
use App\Models\User;
use App\Models\Role;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Pilot>
 */
class PilotFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        // create a variable new_user since it will be used for
        // the foreign key user_id
        $new_user = User::factory()->create();

        // add a role "Pilot" to new_user (pivot table role_user)
        // by attach(id) where id is the id of the role with name "Pilot"
        $new_user->roles()->attach(Role::where('name', 'Pilot')->first()->id);

        return [
            'user_id' => $new_user->id,
            'age' => $this->faker->numberBetween(18, 60),
            'weight' => $this->faker->numberBetween(50, 100),
            'category' => $this->faker->randomElement(['newbie', 'medium', 'advanced']),
        ];
    }
}
