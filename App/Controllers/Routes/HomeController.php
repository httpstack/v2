<?php
namespace App\Controllers\Routes;

use App\Controllers\Middleware\View;
use Core\Container\Container;
use Core\Http\Request;
use Core\Http\Response;
use Core\IO\FS\FileLoader;

//use Core\Template\Template;
class HomeController
{
    protected Container $c;
    public function __construct()
    {}
    public function index(Container $c, $matches)
    {
        $this->c = $c;
        $request = $c->make(Request::class);
        $r       = $request->getUriParts()[count($request->getUriParts()) - 1];
        //echo method_exists($this, $r);
        $this->$r($c, $matches);
        //$this->$route($c, $matches);
        //bind the view data to the container so its available
        //within the ViewModel make

    }
    public function home($c, $matches)
    {
        $v  = $c->make(View::class);
        $fl = $c->make(FileLoader::class);
        $p  = $fl->findFile("home", null, "html");
        $v->template->readTemplate('view', $p);
        $v->template->loadView('view', '//*[@data-template="view"]');
        $v->response->setBody($v->template->saveHTML());
        $v->response->send();
    }
    protected function model($c, $matches)
    {
        $v  = $c->make(View::class);
        $fl = $c->make(FileLoader::class);
        $p  = $fl->findFile("home/model", null, "html");
        $v->template->readTemplate('view', $p);
        $v->template->loadView('view', '//*[@data-template="view"]');
        $v->response->setBody($v->template->saveHTML());
        $v->response->send();
    }
}
