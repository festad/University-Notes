@extends('layouts.app')

@section('title', 'Organizer Dashboard')

@section('content')
<div class="container mt-4">
    <h1>Organizer Dashboard</h1>
    <div class="btn-group" role="group" aria-label="Basic example">
        <button type="button" class="btn btn-secondary" id="showCreateEventForm">Create Event</button>
        <button type="button" class="btn btn-secondary" id="showDashboard">Dashboard</button>
    </div>

    <!-- Section to Create New Event -->
    <div id="createEventSection" style="display: none;">
        <h2 class="mt-4">Create New Event</h2>
        <!-- Form to create a new event -->
        <form id="createEventForm">
            <div class="form-group">
                <label for="eventName">Event Name</label>
                <input type="text" class="form-control" id="eventName" name="eventName" placeholder="Enter event name">
            </div>
            <div class="form-group">
                <label for="eventDescription">Event Description</label>
                <input type="text" class="form-control" id="eventDescription" name="eventDescription" placeholder="Enter event description">
            </div>
            <div class="form-group">
                <label for="eventDate">Event Date</label>
                <input type="date" class="form-control" id="eventDate" name="eventDate">
            </div>
            <!-- Add other fields as necessary -->
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>

    <!-- Dashboard Section -->
    <div id="dashboardSection">
        <h2 class="mt-4">Your Events</h2>
        <!-- Placeholder for dynamically loaded event data -->
        <div id="eventsList">
            <!-- Event data will be loaded here -->
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script>
$(document).ready(function() {
    // Toggle visibility for create event form
    $('#showCreateEventForm').click(function() {
        $('#createEventSection').show();
        $('#dashboardSection').hide();
    });

    // Toggle visibility for dashboard
    $('#showDashboard').click(function() {
        $('#createEventSection').hide();
        $('#dashboardSection').show();
        loadEvents(); // Load events when switching back to dashboard
    });

    // Handle new event creation
    $('#createEventForm').submit(function(e) {
        e.preventDefault(); 
        $.ajax({
            url: '{{ route('events.store') }}', // Adjust this to your route for creating an event
            type: 'POST',
            data: {
                _token: $('meta[name="csrf-token"]').attr('content'),
                name: $('#eventName').val(),
                description: $('#eventDescription').val(),
                date: $('#eventDate').val()
                // Add other fields as necessary
            },
            success: function(response) {
                alert('Event created successfully!');
                $('#createEventSection').find('input[type=text], input[type=date]').val(''); // Clear the form
                loadEvents(); // Reload events to include the new one
                $('#dashboardSection').show();
                $('#createEventSection').hide();
            },
            // error: function() {
            //     alert('Error creating event.');
            // }
        });
    });

    // Function to load events
    function loadEvents() {
        $.ajax({
            url: '{{ route('organizer.events') }}', // Adjust this to your route for listing events
            type: 'GET',
            data: {
                organizer_id: {{ Auth::user()->id }} // Pass the organizer ID to the route
            },
            success: function(events) {
                // Clear existing events
                $('#eventsList').empty();

                // Check if there are events
                if(events.length > 0) {
                    events.forEach(function(event) {
                        var eventElement = $('<div></div>').addClass('event').text(event.name + ' - ' + event.description + ' - ' + event.event_date);
                        // Add more details as needed
                        $('#eventsList').append(eventElement);
                    });
                } else {
                    $('#eventsList').append($('<p>No events found.</p>'));
                }
            },
            error: function() {
                alert('Error loading events.');
            }
        });
    }

    // Initially load events
    loadEvents();
});
</script>
@endpush
