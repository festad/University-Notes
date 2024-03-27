<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\ThreadController;
use App\Http\Controllers\LanguageController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

// No need to use the language middleware, it has been set
// to globally run on every request in the 'web' group, cfr App\Http\Kernel.php
// Route::middleware(['language'])->group(function () {
//     Route::get('/', function () {return view('home');})->name('home');
// });

// Restful routes for thread

// view all threads
Route::get('/threads', [ThreadController::class, 'index'])->name('threads.index');

// view a single thread
Route::get('/threads/{thread}', [ThreadController::class, 'show'])->name('threads.show');

// create a thread
Route::get('/threads/create', [ThreadController::class, 'create'])->name('threads.create');

// edit a thread
Route::get('/threads/{thread}/edit', [ThreadController::class, 'edit'])->name('threads.edit');

// delete a thread
Route::delete('/threads/{id}', [ThreadController::class, 'delete'])->name('threads.destroy');

// search a thread by title
Route::get('/threads/search/title', [ThreadController::class, 'search_title'])->name('threads.search.title');

// search a thread by author
Route::get('/threads/search/author', [ThreadController::class, 'search_author'])->name('threads.search.author');

// change language
Route::get('/language/{lang}',
           [LanguageController::class, 'switch']
)->name('language.switch');