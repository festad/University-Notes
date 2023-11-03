<?php

use Illuminate\Support\Facades\Route;


use App\Http\Controllers\EventController;
use App\Http\Controllers\PilotController;

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

Route::get('/', function () {
    return view('welcome');
});

Route::get('/register', function() {
    return view('register');
})->name('register');

Route::post('/register', function() {
    return "register";
})->name('register.submit');

Route::get('/events', function() {
    return view('events');
})->name('events');

Route::get('/events/{eventId}/pilots', [EventController::class, 'getPilots'])->name('events.pilots');


