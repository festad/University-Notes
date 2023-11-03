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
        
        <!-- Submit Button -->
        <button type="submit" class="btn btn-primary">Register</button>
    </form>
</div>
@endsection
