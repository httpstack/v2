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
class LayersController
{
    protected array $layers = [
        [
            "layer_id" => 1,
            "layer_name" => "Client Layer",
            "layer_code" => "Cl",
            "layer_color" => '#ef4444',
            "layer_description" => "This is the client layer"
        ],
        [
            "layer_id" => 2,
            "layer_name" => "Markup Layer",
            "layer_code" => "Ht",
            "layer_color" => '#f97316',
            "layer_description" => "This is the HTML layer"
        ],
        [
            "layer_id" => 3,
            "layer_name" => "Application Layer",
            "layer_code" => "App",
            "layer_color" => '#f59e0b',
            "layer_description" => "Business logic / controllers / services"
        ],
        [
            "layer_id" => 4,
            "layer_name" => "Data Layer",
            "layer_code" => "Db",
            "layer_color" => '#10b981',
            "layer_description" => "Models, persistence and data access"
        ],
        [
            "layer_id" => 5,
            "layer_name" => "Presentation Layer",
            "layer_code" => "Ui",
            "layer_color" => '#3b82f6',
            "layer_description" => "Views, templates and UI components"
        ],
        [
            "layer_id" => 6,
            "layer_name" => "Integration Layer",
            "layer_code" => "Int",
            "layer_color" => '#8b5cf6',
            "layer_description" => "External APIs, adapters and gateways"
        ],
        [
            "layer_id" => 7,
            "layer_name" => "Security Layer",
            "layer_code" => "Sec",
            "layer_color" => '#ef4444',
            "layer_description" => "Authentication, authorization and validation"
        ],
    ];
    public function __construct() {}
    public function index(Container $c, $matches)
    {
        //bind the view data to the container so its available
        //within the ViewModel make

        /*
        $v = $c->make(View::class);
        $fl = $c->make(FileLoader::class);
        $p = $fl->findFile("layers", null, "html");
        $v->template->loadTemplate('view', $p);
        $v->template->installView('view', '//*[@id="content"]');
        $v->response->setBody($v->template->saveHTML());
        $v->response->send();
        */
    }
    public function layers($c, $matches)
    {
        $req = $c->make(Request::class);

        if ($req->getMethod() === 'GET') {
            $response = $c->make(Response::class);
            $response->setHeader("Content-Type:", "application/json");
            $response->setBody(json_encode($this->layers));
            $response->send();
        } else {
            $response = $c->make(Response::class);
            $response->setHeader("Content-Type:", "application/json");
            $response->setBody($req->getBody());
            $response->send();
        }
    }
    public function id($c, $matches)
    {
        $id = $matches['layerID'];
        //var_dump($matches);
        $response = $c->make(Response::class);
        $response->setHeader("Content-Type:", "application/json");
        $response->setBody(json_encode($this->layers[$id]));
        $response->send();
    }

    public function add() {}
}
