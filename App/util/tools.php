<?php
function dd($data)
{
    echo "<pre>";
    echo json_decode($data);
    echo "</pre>";
}


if (function_exists('normalize_path') === false) {
    function normalize_path($path)
    {
        $parts = [];
        $path = str_replace('\\', '/', $path);
        $segments = explode('/', $path);
        foreach ($segments as $segment) {
            if ($segment === '' || $segment === '.') {
                continue;
            }
            if ($segment === '..') {
                array_pop($parts);
            } else {
                $parts[] = $segment;
            }
        }
        return implode('/', $parts);
    }
}
if (function_exists('app') === false) {
    function app()
    {
        return $GLOBALS['app'];
    }
}
if (function_exists('box') === false) {
    function box()
    {
        return $GLOBALS['app']->getContainer();
    }
}
