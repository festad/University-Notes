@foreach($comments as $comment)
    <div style="margin-left: {{ $depth * 50 }}px;"> <!-- Increase margin for nested comments -->
        <p>{{ $comment->body }}</p>
        <!-- Display author, date, or other comment details here -->
        @if($comment->replies->count())
            @include('partials.comments', ['comments' => $comment->replies, 'depth' => $depth + 1])
        @endif
    </div>
@endforeach
