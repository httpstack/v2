<?php

namespace App;

use App\Controllers\Middleware\View;
use Core\Config\Config;
use Core\Container\Container;
use Core\Http\Request;
use Core\Http\Response;
use Core\IO\FS\FileLoader;
use Core\Routing\Route;
use Core\Routing\Router;
use Core\Template\Template;

class App
{
    protected bool $debug     = true;
    protected array $settings = [];

    protected Router $router;

    protected Container $container;

    public function __construct(Request $request)
    {
        $this->container = new Container();
        //bind the Request::class to the instance passed in
        $this->container->singleton(Request::class, $request);
        $this->init();
        $this->router   = $this->container->make(Router::class);
        $this->settings = $this->container->make(Config::class, "/config")['app'];
        foreach ($this->settings['aliases'] as $a => $fqn) {
            $this->container->alias($a, $fqn);
        }
        //$this->container->alias();
        $GLOBALS['app'] = $this;
    }

    public function init()
    {
        $this->container->singleton(Container::class, $this->container);
        $this->container->singleton(Router::class, Router::class);
        $this->container->singleton(Request::class, Request::class);
        $this->container->singleton(Response::class, Response::class);
        $this->container->singleton(Config::class, function (Container $c) {
            $cfg = new Config();
            return $cfg->getSettings();
        });

        $this->container->singleton(View::class, View::class);

        $this->container->singleton(FileLoader::class, function () {
            $paths = $this->container->make(Config::class)['app']['paths'];
            //$paths = $this->container->make(Config::class)->getSettings()['app3333paths'];

            $fl = new FileLoader();
            foreach ($paths as $namespace => $path) {
                $fl->mapDirectory($namespace, $path);
            }
            return $fl;
            /* */
        });

        $this->container->singleton(Template::class, function (Container $c) {
            $fl = $c->make(FileLoader::class);
            $p = $fl->findFile("base/index", null, "html");
            $tpl = new Template($c);
            $tpl->loadTemplate("layout", $p);
            $tpl->installTemplate("layout");
            return $tpl;
        });
    }
    public function before($method, $uri, $handle)
    {
        $rte = new Route($method, $uri, $handle, "mw");
        $this->router->before($rte);
    }
    public function get(string $uri, array $handle)
    {
        $this->router->get($uri, $handle);
    }

    public function post($uri, $handle)
    {
        $this->router->post($uri, $handle);
    }

    public function run()
    {
        $this->router->dispatch($this->container);
    }
    public function getContainer()
    {
        return $this->container;
    }
}
