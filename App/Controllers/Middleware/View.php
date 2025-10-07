<?php
namespace App\Controllers\Middleware;

use Core\Config\Config;
use Core\Container\Container;
use Core\Http\Request;
use Core\Http\Response;
use Core\Template\Template;

class View
{
    public Request $request;
    public Response $response;
    public Template $template;

    protected array $settings = [];
    public function process(Container $c)
    {
        $cfg            = $c->make(Config::class);
        $this->template = $c->make(Template::class, $c);
        $this->response = $c->make(Response::class);
        $this->response->setHeader("Content-Type:", "text/html");
        $c->singleton(View::class, $this);
    }
}
