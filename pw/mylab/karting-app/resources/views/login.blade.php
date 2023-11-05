<!-- resources/views/login.blade.php -->

@extends('layouts.app')

@section('title', 'Login')

@section('content')
<div class="container">
    <h2>Register</h2>
    <form method="POST" action="{{ route('login.submit') }}">
        @csrf
        
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

        <!-- Submit Button -->
        <button type="submit" class="btn btn-primary">Login</button>

    </form>
</div>
@endsection

@push('scripts')
<script>
    // If needed, add scripts here
</script>
@endpush

