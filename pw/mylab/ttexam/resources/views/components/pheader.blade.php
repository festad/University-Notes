<div>
    <!-- An unexamined life is not worth living. - Socrates -->
    <header class="p-3 text-bg-dark">
        <div class="container">
            <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">

                <div class="dropdown">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/2/2a/Y%C5%8Dkoso_Jitsuryoku_Shij%C5%8D_Shugi_no_Ky%C5%8Dshitsu_e_logo.png" alt="Bootstrap" width="90">
                    </a>

                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                        @auth
                            <!-- route: users/{user_id} -->
                            <li><a class="dropdown-item" href="{{ route('users.show', Auth::user()->id) }}">{{ Auth::user()->name }}</a></li>
                        @endauth
                        <li><a class="dropdown-item" href="{{ route('home') }}">Home</a></li>
                        <li><a class="dropdown-item" href="{{ route('threads.index') }}">{{__('messages.threads')}}</a></li>
                        <li><a class="dropdown-item" href="#">Option 3</a></li>
                    </ul>
                </div>                        

                <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                    <!-- <li><a href="#" class="nav-link px-2 text-secondary">Home</a></li> -->
                    <li><a href="{{ route('home') }}" class="nav-link px-2 text-white">Home</a></li>
                    <li><a href="{{ route('threads.index') }}" class="nav-link px-2 text-white">{{__('messages.threads')}}</a></li>
                    <li><a href="#" class="nav-link px-2 text-white">Pricing</a></li>
                    <li><a href="#" class="nav-link px-2 text-white">FAQs</a></li>
                    <li><a href="#" class="nav-link px-2 text-white">About</a></li>
                </ul>

                <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3" role="search">
                    <input type="search" class="form-control form-control-dark text-bg-dark" placeholder="Search..." aria-label="Search">
                </form>

                <div class="text-end">
                    @guest
                        <button type="button" class="btn btn-outline-light me-2">Login</button>
                        <button type="button" class="btn btn-warning">Sign-up</button>
                    @endguest
                </div>
                <!-- <div class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownLang" role="button" data-toggle="dropdown" aria-expanded="false">
                            <img src="{{ asset('flags/' . App::getLocale() . '.svg') }}" width="30" height="20" alt="{{ App::getLocale() }}">
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdownLang">
                            @foreach(config('app.locales') as $lang => $language)
                            <li>
                                <a class="dropdown-item" href="{{ route('language.switch', $lang) }}">
                                    <img src="{{ asset('flags/' . $lang . '.svg') }}" width="30" height="20" alt="{{ $language }}"> {{ $language }}
                                </a>
                            </li>
                            @endforeach
                        </ul>
                    </li>
                </div>                 -->
                <!-- Language dropdown menu -->
                <div class="dropdown" style="margin-left: 10px;">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="{{ asset('flags/' . App::getLocale() . '.svg') }}" width="30" height="20" alt="{{ App::getLocale() }}">
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                        @foreach(config('app.locales') as $lang => $language)
                            <li>
                                <a class="dropdown-item" href="{{ route('language.switch', $lang) }}">
                                    <img src="{{ asset('flags/' . $lang . '.svg') }}" width="30" height="20" alt="{{ $language }}"> {{ $language }}
                                </a>
                            </li>
                        @endforeach
                    </ul>
                </div>
            </div>
        </div>
    </header>
</div>