<?php

namespace App\Controllers\Routes;

use Core\Http\Request;
use Core\Http\Response;
use Core\Container\Container;
use Core\Model\AbstractModel;
use Core\App\Models\ViewModel;

use App\Controllers\Middleware\View;
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

        $v = $c->make(View::class);
        $fl = $c->make(FileLoader::class);
        $p = $fl->findFile("home", null, "html");
        $v->template->readTemplate('view', $p);
        $v->template->loadView('view', '//*[@id="content"]');
        $v->response->setBody($v->template->saveHTML());
        $v->response->send();
    }
    public function home($c, $matches) {}
}
