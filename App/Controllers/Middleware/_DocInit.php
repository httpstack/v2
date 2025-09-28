<?php

namespace App\Controllers\Middleware;

use Core\Container\Container;
use Core\Config\Config;
use Core\IO\FS\FileLoader;

class DocInit
{
    public function __construct() {}
    public function process(Container $c)
    {
        $cfg = $c->make(Config::class);
        $fl = $c->make(FileLoader::class);
        //config for paths
        //fileloader
        //template
        //dbconnection

    }
}
