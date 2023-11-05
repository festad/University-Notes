<?php

use Illuminate\Support\Facades\Route;


use App\Http\Controllers\UserController;
use App\Http\Controllers\PilotController;

use App\Http\Controllers\EventController;

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
})->name('welcome');

Route::get('/register', function() {
    return view('register');
})->name('register');

Route::post('/register', [UserController::class, 'register'])->name('register.submit');

Route::post('/register/check-email', [UserController::class, 'checkEmail'])->name('register.check-email');

Route::get('/events', function() {
    return view('events');
})->name('events');

Route::post('/events/pilots', [EventController::class, 'getPilots'])->name('events.pilots');

Route::get('/login', function() {
    return view('login');
})->name('login');

Route::post('/login', [UserController::class, 'login'])->name('login.submit');

Route::get('/logout', [UserController::class, 'logout'])->name('logout');



