@extends('layouts.main')

@section('content')

    <!-- A text box with the content of $thread -->
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>{{ $thread->title }}</h1>
                <p>{{ $thread->content }}</p>
                <p>Author: {{ $thread->author->author_username }}</p>
                <p>Tags:
                    @foreach($thread->tags as $tag)
                        <span>{{ $tag->name }}</span>
                    @endforeach
                </p>
                <a href="{{ route('threads.index') }}" class="btn btn-primary">Back</a>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <h2>Comments</h2>
                @include('partials.comments', ['comments' => $thread->comments, 'depth' => 0])
            </div>
        </div>
    </div>
@endsection
