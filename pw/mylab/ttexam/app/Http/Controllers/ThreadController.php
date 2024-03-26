<?php

namespace App\Http\Controllers;

use App\Models\Thread;
use Illuminate\Http\Request;

use App\DataLayer\ThreadDataLayer;

use Datatables;

class ThreadController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        $threads = Thread::with('author', 'tags') // Eager load relationships
                            ->withCount('comments') // Count the comments
                            ->paginate(10); // Specify the number of items per page        
    
        return view('threads',
            [ 'threads' => $threads->withQueryString() ]
        );
    }

    public function show($id)
    {
        $dl_thread = new ThreadDataLayer();
        $thread = $dl_thread->getThreadWithParentComments($id);

        return view('thread', compact('thread'));
    }
    

    public function delete($id)
    {
        $dl_thread = new ThreadDataLayer();
        $dl_thread->deleteThread($id);

        return response()->json(['message' => 'Thread deleted successfully']);
    }

    public function search_title(Request $request)
    {
        $title = $request->input('title');
        $dl_thread = new ThreadDataLayer();
        $threads = $dl_thread->getThreadsByTitle($title);

        return view('partials.threadsTableBody', compact('threads'));
    }

    public function search_author(Request $request)
    {
        $author_username = $request->input('author_username');
        $dl_thread = new ThreadDataLayer();
        $threads = $dl_thread->getThreadsByAuthor($author_username);

        return view('partials.threadsTableBody', compact('threads'));
    }
}
