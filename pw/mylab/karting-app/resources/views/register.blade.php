<!-- resources/views/register.blade.php -->

@extends('layouts.app')

@section('title', 'Register')

@section('content')
<div class="container">
    <h2>Register</h2>
    <form method="POST" action="{{ route('register.submit') }}">
        @csrf
        
        <!-- Select Role -->
        <div class="form-group">
            <label for="role">Register As:</label>
            <select name="role" id="role" class="form-control" required>
                <option value="">Choose...</option>
                <option value="pilot">Pilot</option>
                <option value="organizer">Organizer</option>
            </select>
        </div>

        <!-- Name -->
        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" class="form-control" name="name" id="name" required>
        </div>
        
        <!-- Email -->
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" name="email" id="email" required>
        </div>
        
        <!-- Password -->
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" class="form-control" name="password" id="password" required>
        </div>
        
        <!-- Confirm Password -->
        <div class="form-group">
            <label for="password_confirmation">Confirm Password:</label>
            <input type="password" class="form-control" name="password_confirmation" id="password_confirmation" required>
        </div>
        
        
        <!-- Placeholder for Pilot-specific Fields -->
        <div id="pilotFields" style="display: none;">
            <!-- Age -->
            <div class="form-group">
                <label for="age">Age:</label>
                <input type="number" class="form-control" name="age" id="age">
            </div>
            
            <!-- Weight -->
            <div class="form-group">
                <label for="weight">Weight:</label>
                <input type="number" class="form-control" name="weight" id="weight">
            </div>
            
            <!-- Category -->
            <div class="form-group">
                <label for="category">Category:</label>
                <select name="category" id="category" class="form-control">
                    <option value="">Choose...</option>
                    <option value="Newbie">Newbie</option>
                    <option value="Amateur">Amateur</option>
                    <option value="Pro">Pro</option>
                    <option value="Legend">Legend</option>
                </select>
            </div>
        </div>

        <!-- Placeholder for Organizer-specific Fields -->
        <div id="organizerFields" style="display: none;">
            <!-- Authority Level -->
            <div class="form-group">
                <label for="authority_level">Authority Level:</label>
                <input type="number" class="form-control" name="authority_level" id="authority_level">
            </div>
        </div>

        <!-- Submit Button -->
        <button type="submit" class="btn btn-primary">Register</button>

    </form>
</div>
@endsection

@push('scripts')
<script>
    $(document).ready(function() {
        // Function to show/hide fields based on the selected role
        function toggleRoleFields() {
            var selectedRole = $('#role').val();
            if(selectedRole === 'pilot') {
                $('#pilotFields').show();
                $('#organizerFields').hide();
            } else if(selectedRole === 'organizer') {
                $('#pilotFields').hide();
                $('#organizerFields').show();
            } else {
                $('#pilotFields').hide();
                $('#organizerFields').hide();
            }
        }

        // Event handler for the role selection change
        $('#role').change(toggleRoleFields);

        // Initialize on page load in case the role is pre-selected
        toggleRoleFields();
    });
</script>
@endpush

