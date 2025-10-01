<?php

namespace Core\Routing;

use Core\Container\Container;
use Core\Http\Request;
use Core\Routing\Route;


class Router
{
    public $after = [];
    private $before = [];
    public function get($uri, $handle): void
    {
        $r = new Route("GET", $uri, $handle, "after");
        $this->after($r);
    }
    public function post($uri, $handle): void
    {
        $r = new Route("POST", $uri, $handle, "after");
        $this->after($r);
    }
    public function mw($method, $uri, $handle): void
    {
        $r = new Route($method, $uri, $handle, "before");
        $this->before($r);
    }
    public function after(Route $route)
    {

        $newRouteUri = $route->getUri();
        $newRouteMethod = $route->getMethod();
        $newRouteHandlers = $route->getHandlers();
        //CHECK TO SEE IF THE ROUTE METHOD AND URI ARE REGISTERED
        if (isset($this->after[$newRouteMethod]) && isset($this->after[$newRouteMethod][$newRouteUri])) {

            $oldRouteHandlers = $this->after[$newRouteMethod][$newRouteUri];
            foreach ($newRouteHandlers as $newHandler) {
                array_push($oldRouteHandlers, $newHandler);
            }
        } else {
            $this->after[$newRouteMethod][$newRouteUri] = $newRouteHandlers;
        }
    }
    public function before(Route $route)
    {
        $newRouteUri = $route->getUri();
        $newRouteMethod = $route->getMethod();
        $newRouteHandlers = $route->getHandlers();
        //CHECK TO SEE IF THE ROUTE METHOD AND URI ARE REGISTERED
        if (isset($this->before[$newRouteMethod]) && isset($this->before[$newRouteMethod][$newRouteUri])) {
            $oldRouteHandlers = $this->after[$newRouteMethod][$newRouteUri];
            foreach ($newRouteHandlers as $newHandler) {
                array_push($oldRouteHandlers, $newHandler);
            }
        } else {
            $this->before[$newRouteMethod][$newRouteUri] = $newRouteHandlers;
        }
    }
    public function route(Route $route)
    {
        $type = $route->getType();
        switch ($type) {
            case "after":
                $this->after($route);
                break;

            case "before":
                $this->before($route);
                break;
        }
    }


    public function dispatch(Container $c)
    {
        $request = $c->make(Request::class);
        $method = $request->getMethod();
        $uri = $request->getUri();
        //dd($this->before);
        /**
         * LOOP MIDDLEWARES
         */
        if (isset($this->before[$method])) {
            foreach ($this->before[$method] as $pattern => $handlers) {
                // Match pattern (supports :param and {param}) and extract named params into $matches
                $matches = $this->matchAndExtract($pattern, $uri);
                if ($matches !== false) {
                    foreach ($handlers as $middleware) {
                        if (is_array($middleware)) {
                            list($className, $methodName) = $middleware;
                            //$instance = new $className();
                            $callable = [$className, $methodName];
                        } else {
                            $callable = $middleware;
                        }
                        //dd($className);
                        call_user_func_array($callable, [$c, $matches]);
                    }
                }
            }
        }
        /**
         * LOOP WARES
         * 
         */
        if (isset($this->after[$method])) {
            foreach ($this->after[$method] as $pattern => $handlers) {
                $matches = $this->matchAndExtract($pattern, $request->getUri());
                if ($matches !== false) {
                    foreach ($handlers as $afterWare) {
                        if (is_array($afterWare)) {
                            list($className, $methodName) = $afterWare;
                            $instance = new $className();
                            $callable = [$instance, $methodName];
                        } else {
                            $callable = $afterWare;
                        }
                        call_user_func_array($callable, [$c, $matches]);
                    }
                    //$container->call($this->after[$method][$key], [$request, $response, $container, $matches]);

                }
            }
        }
    }

    /**
     * Match a route pattern against a URI and extract named parameters.
     * Supports :name and {name} placeholders and wildcard *.
     * Returns false when no match, or the $matches array (numeric + named keys) on success.
     */
    private function matchAndExtract(string $pattern, string $uri)
    {
        $paramNames = [];
        $index = 0;
        // Replace placeholders with temporary tokens and capture names
        $patternWithTokens = preg_replace_callback('/:(\w+)|\{(\w+)\}/', function ($m) use (&$paramNames, &$index) {
            $name = $m[1] ?? $m[2];
            $paramNames[] = $name;
            return '___PARAM' . $index++ . '___';
        }, $pattern);

        // Escape the rest of the pattern for regex safety
        $escaped = preg_quote($patternWithTokens, '#');

        // Replace tokens with capture groups
        for ($i = 0; $i < $index; $i++) {
            $escaped = str_replace('___PARAM' . $i . '___', '([^/]+)', $escaped);
        }

        // Allow wildcard * -> .*
        $escaped = str_replace('\*', '.*', $escaped);

        $regex = '#^' . $escaped . '$#';
        $matches = [];
        if (!preg_match($regex, $uri, $matches)) {
            return false;
        }

        // Add named keys mapping to the captured groups (preserve numeric keys too)
        for ($i = 0; $i < count($paramNames); $i++) {
            $name = $paramNames[$i];
            $matches[$name] = $matches[$i + 1] ?? null;
        }

        return $matches;
    }

    public function getRoutes()
    {
        return $this->after;
    }
    public function getMiddleWares()
    {
        return $this->before;
    }
}
