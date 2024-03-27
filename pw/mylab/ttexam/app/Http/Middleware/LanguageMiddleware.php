<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cookie;

class LanguageMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // return $next($request);
        // Default to English
        $locale = 'en';

        // Check for user-specific cookie if user is logged in
        if (Auth::check()) {
            $cookieName = 'lang_pref_user_' . Auth::user()->id;
            $locale = Cookie::get($cookieName, $locale);
        } else {
            // For guests, check the generic applocale cookie
            $locale = Cookie::get('applocale', $locale);
        }

        if (array_key_exists($locale, config('app.locales'))) {
            App::setLocale($locale);
        }

        return $next($request);        
    }
}
