<?php

namespace App;

use Core\Routing\Router;
use Core\Http\Request;
use Core\Http\Response;
use Core\Container\Container;
use Core\IO\FS\FileLoader;
use Core\Config\Config;
use Core\Routing\Route;


class App
{
    protected bool $debug = true;
    protected array $settings = [];

    protected Router $router;

    protected Container $container;

    public function __construct(Request $request)
    {
        $this->container = new Container();
        $this->init();
        $this->router = $this->container->make(Router::class);
        $GLOBALS['app'] = $this;
    }

    public function init()
    {
        $this->container->singleton(Container::class, $this->container);
        $this->container->singleton(Request::class, function ($c) {
            return new Request();
        });
        $this->container->singleton(Config::class, function (Container $c, string $dir) {
            $cfg = new Config("/config");
            return $cfg->getSettings();
        });
        $this->container->singleton('config', function () {
            $configDir = APP_ROOT . "/config";
            $configs = [];
            foreach (glob($configDir . '/*.php') as $file) {
                $key = basename($file, '.php');
                $configs[$key] = include $file;
            }
            return $configs;
        });
        $this->container->singleton(Router::class, Router::class);
        $this->container->singleton(Response::class, function () {
            return new Response();
        });


        $this->container->singleton(FileLoader::class, function () {
            $paths = $this->container->make(Config::class, "/config");
            print_r($paths);
            //$paths = $this->container->make(Config::class)->getSettings()['app3333paths'];

            $fl = new FileLoader();
            foreach ($paths as $namespace => $path) {
                $fl->mapDirectory($namespace, $path);
            }
            return $fl;
            /* */
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
