<?php 

namespace App\DataLayer;

use App\Models\Thread;

use App\DataLayer\ThreadDataLayer;
use App\Models\Comment;
use App\Models\Tag;

class CommentDataLayer
{
    public function deleteCommentsFromThread($thread_id)
    {
        $thread = Thread::find($thread_id);
        $comments = $thread->comments;
        foreach ($comments as $comment) {
            $this->deleteCommentAndChildren($comment->id);
            $comment->delete();
        }
    }

    public function deleteCommentAndChildren($id)
    {
        $comment = Comment::find($id);
        if ($comment == null) {
            return;
        }
        
        $children = $comment->replies;
        foreach ($children as $child) {
            $this->deleteCommentAndChildren($child->id);
            // $child->delete();
        }
        $comment->delete();
    }

    public function unlinkChildren($id)
    {
        $comment = Comment::find($id);
        $children = Comment::where('parent_id', $id)->get();
        foreach ($children as $child) {
            $this->unlinkChildren($child->id);
        }
        $comment->parent_id = null;
        $comment->save();
    }
}