<!-- resources/views/events.blade.php -->

@extends('layouts.app')

@section('title', 'Events')

@section('content')
<div class="container mt-4">
    <h1>Select an Event</h1>
    <select id="eventSelector" class="form-select">

        <!-- Load events from the database -->
        @php
            $events = App\Models\Event::all();
        @endphp

        @foreach ($events as $event)
            <option value="{{ $event->id }}">{{ $event->name }}</option>
        @endforeach
    </select>

    <h2 class="mt-4">Pilots in Event</h2>
    <table id="pilotsTable" class="table">
        <thead>
            <tr>
                <th>Name</th>
                <th>Weight</th>
                <th>Age</th>
                <th>Category</th>
            </tr>
        </thead>
        <tbody>
            <!-- Pilots will be loaded here via AJAX -->
        </tbody>
    </table>
</div>
@endsection

@push('scripts')
<script>
    $(document).ready(function() {
        // Load pilots for the selected event on page load
        loadPilots($('#eventSelector').val());

        // Event handler for changing the selected event
        $('#eventSelector').change(function() {
            loadPilots($(this).val());
        });

        // Function to load pilots via AJAX
        function loadPilots(eventId) {
            $.ajax({
                // passing eventId to the route
                url: '{{ route('events.pilots') }}',
                type: 'POST',
                data: {
                    _token: $('meta[name="csrf-token"]').attr('content'),
                    eventId: eventId
                },
                success: function(pilots) {

                    // Clear the existing table
                    $('#pilotsTable tbody').empty();

                    // Iterate over the pilots:

                    pilots.forEach(function(pilot) {
                        // Create a table row
                        var row = $('<tr></tr>');
                        
                        // Add table data for each detail you want to display
                        row.append($('<td></td>').text(pilot.name));
                        row.append($('<td></td>').text(pilot.weight));
                        row.append($('<td></td>').text(pilot.age));
                        row.append($('<td></td>').text(pilot.category));

                        // Append the row to the table body
                        $('#pilotsTable tbody').append(row);
                    });
                    
                    // print pilots json to console
                    console.log(pilots);
                },
                error: function() {
                    alert('Unable to load data.');
                }
            });
        }
    });
</script>
@endpush