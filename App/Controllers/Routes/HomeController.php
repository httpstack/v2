<?php

namespace App\Controllers\Routes;

use Core\Http\Request;
use Core\Http\Response;
use Core\Container\Container;
use Core\Model\AbstractModel;
use Core\App\Models\ViewModel;
use Core\App\Views\View;
use Core\IO\FS\FileLoader;
use Core\Test\MyClass;

//use Core\Template\Template;
class HomeController
{
    public function __construct() {}
    public function index(Container $c, $matches)
    {
        //bind the view data to the container so its available
        //within the ViewModel make
        $this->home($c, $matches);
        $res = $c->make(Response::class);
        $fl = $c->make(FileLoader::class);
        print_r($fl);
        $res->setHeader("Content-Type:", "text/html");
        $res->setBody("<div>hello</div>");
        $res->send();
    }
    public function home($c, $matches)
    {
        /* 
        //$v = $container->make(View::class, "public/home");
        $v = $c->make(View::class);
        //$m = $container->make(ViewModel::class, $container, "public/home");
        //$v->model($m);

        $v->render();
        if (!$res->sent) {
            $res->send();
        }
            */
    }
}
