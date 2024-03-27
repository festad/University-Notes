<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LanguageController extends Controller
{
    //

    public function switch($lang)
    {
        if (!array_key_exists($lang, config('app.locales'))) {
            return back();
        }
        
        $cookie = cookie()->forever('applocale', $lang);
    
        if (Auth::check()) {
            $cookieName = 'lang_pref_user_' . Auth::user()->id;
            $cookie = cookie()->forever($cookieName, $lang);
        }
    
        return back()->withCookie($cookie);        
    }

}
