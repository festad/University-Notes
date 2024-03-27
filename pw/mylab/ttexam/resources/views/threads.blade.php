@extends('layouts.main')

@section('content')

    <!-- <table class="table" id="threadsTable"> -->


    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>Threads</h1>
                <a href="{{ route('threads.create') }}" class="btn btn-primary">Create Thread</a>
                <input type="text" id="threadSearchByTitle" placeholder="Filter by title" class="form-control" style="width: auto; display: inline-block; margin-left: 10px;">
                <input type="text" id="threadSearchByAuthor" placeholder="Filter by author" class="form-control" style="width: auto; display: inline-block; margin-left: 10px;">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>{{__('messages.title')}}</th>
                            <th>Author</th>
                            <th>{{__('messages.comments')}}</th>
                            <th>Tags</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($threads as $thread)
                            <tr>
                                <td>{{ $thread->id }}</td>
                                <td>{{ $thread->title }}</td>
                                <td>{{ $thread->author->author_username }}</td>
                                <td>{{ $thread->comments->count() }}</td>
                                <td>
                                    @foreach($thread->tags as $tag)
                                        <span>{{ $tag->name }}</span>
                                    @endforeach
                                </td>
                                <td>
                                    <a href="{{ route('threads.show', $thread->id) }}" class="btn btn-primary">View</a>
                                    <a href="{{ route('threads.edit', $thread->id) }}" class="btn btn-warning">Edit</a>
                                    <form action="{{ route('threads.destroy', $thread->id) }}" method="POST">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-danger" style="margin-top: 5px;">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
                <!-- Pagination -->
                {{ $threads->links('vendor.pagination.simple') }}
                <!-- spacing -->
                <div style="margin-bottom: 20px;"></div>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
    <script>
        console.log('Threads view');

        // Ajax action "delete"
        $('button#btn-delete').on('click', function() {
            console.log('Delete button clicked');
            // Route::delete threads.destroy
            $.ajax({
                url: '/threads/' + {{ $thread->id }},
                method: 'DELETE',
                data: {
                    _token: $('meta[name="csrf-token"]').attr('content')
                    // id: {{ $thread->id }}
                },
                success: function(response) {
                    console.log(response);
                    // alert message (display json 'message')
                    alert(response.message);
                },
                error: function(response) {
                    console.log(response);
                }
            });
        });

        // $(document).ready(function() {
        //     $('#threadsTable').DataTable({
        //         processing: true,
        //         serverSide: true,
        //         ajax: '{{ route("threads.index") }}',
        //         columns: [
        //             { data: 'id', name: 'id' },
        //             { data: 'title', name: 'title' },
        //             { data: 'author.name', name: 'author.name' },
        //             { data: 'comments_count', name: 'comments.count', searchable: false },
        //             { data: 'tags', name: 'tags.name', orderable: false, searchable: false },
        //             { data: 'actions', name: 'actions', orderable: false, searchable: false },
        //         ]
        //     });
        // });

        $(document).ready(function() {
            $('#threadSearchByTitle').on('keyup', function() {
                var value = $(this).val();
                $.ajax({
                    url: '{{ route("threads.search.title") }}',
                    type: 'GET',
                    data: {
                        title: value,
                    },
                    success: function(data) {
                        $('tbody').html(data);
                    }
                });
            });
        });

        $(document).ready(function() {
            $('#threadSearchByAuthor').on('keyup', function() {
                var value = $(this).val();
                $.ajax({
                    url: '{{ route("threads.search.author") }}',
                    type: 'GET',
                    data: {
                        author_username: value,
                    },
                    success: function(data) {
                        $('tbody').html(data);
                    }
                });
            });
        });

    </script>
@endpush