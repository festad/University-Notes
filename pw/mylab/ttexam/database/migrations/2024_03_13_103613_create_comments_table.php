<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('comments', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            // Body, foreign key to author, foreign key to thread, foreign key to parent comment
            $table->text('body');
            $table->foreignId('author_id')->constrained('authors');
            $table->foreignId('thread_id')->constrained('threads');
            $table->foreignId('parent_id')->nullable()->constrained('comments');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('comments');
    }
};
