<?php
define("DOC_ROOT", "/var/www/html");
define("APP_ROOT", DOC_ROOT . "/App");
define("BASE_URI", "http://localhost/");
define("CONFIG_DIR", APP_ROOT . "/config");


//make this into a directroy loop so it get gets all libs from 
//an array of folders in the file loadder or something
require_once(DOC_ROOT . "/App/util/tools.php");

$paths = [
    "App" => DOC_ROOT,
    "Core" => DOC_ROOT . "/Core",
];
spl_autoload_register(function ($className) use ($paths) {
    foreach ($paths as $namespace => $path) {
        $classPath = $path . "/" . str_replace("\\", "/", $className) . ".php";
        $classPath = normalize_path($classPath);
        $classPath = "/" . $classPath;
        //echo $classPath;
        if (file_exists($classPath)) {
            require_once $classPath;
        }
    }
});