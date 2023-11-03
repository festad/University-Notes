<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

use App\Models\Administrator;
use App\Models\User;
use App\Models\Role;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Administrator>
 */
class AdministratorFactory extends Factory
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

        // add a role "Administrator" to new_user (pivot table role_user)
        // by attach(id) where id is the id of the role with name "Administrator"
        $new_user->roles()->attach(Role::where('name', 'Administrator')->first()->id);

        return [
            'user_id' => $new_user->id,
        ];
    }
}
