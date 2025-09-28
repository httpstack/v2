<?php

namespace App\Controllers\Routes;

use Core\Container\Container;
use Core\Http\Request;
use Core\IO\FS\FileLoader;

class SignupController
{

    public function __construct() {}

    public function index(Container $c)
    {
        $req = $c->make(Request::class);
        // dd($c->make(FileLoader::class));
        echo $req->getMethod();
    }

    public function form() {}
    public function signup() {}
}
