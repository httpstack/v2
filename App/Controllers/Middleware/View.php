<?php

namespace App\Controllers\Middleware;

use Core\Container\Container;
use Core\Config\Config;
use Core\IO\FS\FileLoader;

class View
{
    public function process(Container $c)
    {
        $cfg = $c->make(Config::class);
        $fl = $c->make(FileLoader::class);
        //print_r($cfg);
        //config for paths
        //fileloader
        //template
        //dbconnection

    }
}