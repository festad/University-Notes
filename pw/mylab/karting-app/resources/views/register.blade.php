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
            <div id="emailFeedback"></div> <!-- Add this line -->
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

        <!-- Submit Button disabled by default-->
        <button type="submit" class="btn btn-primary" disabled>Submit</button>
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

    // AJAX call to check if email exists
    $('#email').on('input', function() {
        var email = $(this).val();
        // if the email satisfies a basic regex
        // such as 'example@example.eg'
        if (email.match(/.+@.+\..+.+/)) {

            // POST method (parameter 'email' is passed in the request body)
            $.ajax({
                url: '{{ route('register.check-email') }}',
                type: 'POST',
                data: { 
                    // Include the CSRF token
                    _token: $('meta[name="csrf-token"]').attr('content'),
                    email: email 
                },
                success: function(response) {
                    if (response.message === 'Email already exists.') {
                        $('#emailFeedback').text(response.message).css('color', 'red');
                        $('button[type="submit"]').prop('disabled', true);
                    } else {
                        $('#emailFeedback').text(response.message).css('color', 'green');
                        $('button[type="submit"]').prop('disabled', false);
                    }
                },
                error: function(xhr, textStatus, errorThrown) {
                    console.error(errorThrown);
                }
            });
        } else {
            $('#emailFeedback').text('example@example.eg').css('color', 'grey');
            $('button[type="submit"]').prop('disabled', true);
        }
    });    
</script>
@endpush

