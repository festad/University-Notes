<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use App\Models\User;
use App\Models\Author;
use App\Models\Comment;
use App\Models\Thread;
use App\Models\Tag;


class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {

        // Create 10 users, then for each user create an author,
        // then for each author create 3 threads, then for each thread create 
        // 5 comments, and for each comment create 2 replies,
        // then create 10 tags,
        // to each thread attach 2 random tags and to each tag attach 2 random threads

        $n_users = 10;
        $n_threads = 3;
        $n_comments = 5;
        $n_replies = 2;
        $n_tags = 10;
        $n_threads_per_tag = 3;
        $n_tags_per_thread = 3;

        User::factory($n_users)->create();

        User::all()->each(function ($user) {
            $author = Author::factory()->create([
                'user_id' => $user->id,
            ]);
        });

        Author::all()->each(function ($author) use ($n_threads, $n_comments, $n_replies) {
            Thread::factory($n_threads)->create([
                'author_id' => $author->id,
            ])->each(function ($thread) use ($n_comments, $n_replies) {
                $replier_id = Author::inRandomOrder()->where('id', '!=', $thread->author_id)->first()->id;
                Comment::factory($n_comments)->create([
                    'thread_id' => $thread->id,
                    // randomly pick an author
                    // different than the thread's author
                    'author_id' => $replier_id,
                ])->each(function ($comment) use ($n_replies, $replier_id) {
                    $nd_replier_id = Author::inRandomOrder()->where('id', '!=', $replier_id)->first()->id;
                    Comment::factory($n_replies)->create([
                        'author_id' => $nd_replier_id,
                        'thread_id' => $comment->thread_id,
                        'parent_id' => $comment->id,
                    ]);
                });
            });
        });


        Tag::factory($n_tags)->create();

        // Correct way to attach tags to threads
        Thread::all()->each(function ($thread) use ($n_tags_per_thread) {
            $tagIds = Tag::inRandomOrder()->limit($n_tags_per_thread)->pluck('id');
            $thread->tags()->attach($tagIds);
        });

        // Correct way to attach threads to tags
        Tag::all()->each(function ($tag) use ($n_threads_per_tag) {
            $threadIds = Thread::inRandomOrder()->limit($n_threads_per_tag)->pluck('id');
            $tag->threads()->attach($threadIds);
        });


    }
}
