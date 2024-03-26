@foreach($threads as $thread)
<tr>
    <td>{{ $thread->id }}</td>
    <td>{{ $thread->title }}</td>
    <td>{{ $thread->author->author_username }}</td>
    <td>{{ $thread->comments_count }}</td>
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
            <button type="submit" class="btn btn-danger">Delete</button>
        </form>        
    </td>
</tr>
@endforeach
