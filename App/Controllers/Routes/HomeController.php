<?php

namespace App\Controllers\Routes;

use App\Controllers\Middleware\View;
use Core\Container\Container;
use Core\Http\Request;
use Core\Http\Response;
use Core\IO\FS\FileLoader;
use Core\Database\DBConnect\DBConnect;
//use Core\Template\Template;
class HomeController
{
    protected Container $c;
    protected View $view;
    protected FileLoader $files;
    //protected Model $model;
    public function __construct() {}
    public function index(Container $c, $matches)
    {
        $this->view  = $c->make(View::class);
        $this->files = $c->make(FileLoader::class);
        $request = $c->make(Request::class);
        $route       = $request->getUriParts()[count($request->getUriParts()) - 1];
        $this->$route($matches);
    }
    public function home($matches)
    {
        //print_r($this->view->template->getVars());
        $p  = $this->files->findFile("home", null, "html");
        $this->view->template->readTemplate('view', $p);
        $this->view->template->loadView('view', '//*[@data-template="view"]');
        $this->view->response->setBody($this->view->template->render());
        $this->view->response->send();
    }
    protected function elements($matches)
    {
        $p  = $this->files->findFile("home/elements", null, "html");
        $this->view->template->readTemplate('view', $p);
        $this->view->template->loadView('view', '//*[@data-template="view"]');
        $this->view->response->setBody($this->view->template->saveHTML());
        $this->view->response->send();
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
