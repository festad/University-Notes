<?php 

namespace App\DataLayer;

use App\Models\Thread;
use App\Models\Author;

use App\DataLayer\CommentDataLayer;

// use DB facade
use Illuminate\Support\Facades\DB;

class ThreadDataLayer
{
    public function getAllThreads()
    {
        return Thread::all();
    }

    public function getThreadById($id)
    {
        return Thread::find($id);
    }

    public function createThread($data)
    {
        return Thread::create($data);
    }

    public function updateThread($id, $data)
    {
        return Thread::find($id)->update($data);
    }

    public function deleteThread($id)
    {

        // Deleting N to N relationships with tags
        DB::table('tag_thread')->where('thread_id', $id)->delete();

        $dl_comment = new CommentDataLayer();
        $dl_comment->deleteCommentsFromThread($id);

        Thread::destroy($id);
    }

    public function getThreadWithParentComments($id)
    {
        return Thread::with('author', 'tags')
                        ->with(['comments' => function($query) {
                            $query->whereNull('parent_id');
                        }])
                        ->find($id);

    }

    public function getThreadsByTitle($title)
    {
        return Thread::where('title', 'LIKE', '%' . $title . '%')
                        ->with('author', 'tags')
                        ->withCount('comments')
                        ->get();
    }

    public function getThreadsByAuthor($author_username)
    {
        $authors = Author::where('author_username' , 'LIKE', '%' . $author_username . '%')->get();
        // Get threads that are related to the authors
        $threads_ids = [];
        foreach ($authors as $author) {
            $threads_ids = array_merge($threads_ids, $author->threads->pluck('id')->toArray());
        }
        return Thread::whereIn('id', $threads_ids)
                        ->with('author', 'tags')
                        ->withCount('comments')
                        ->get();
    }
}