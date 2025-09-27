<?php
$settings = [
    "template" => [
        "base" => "base.html",
        "data" => "/data",
        "assetTypes" => ["js", "css", "woff", "woff2", "otf", "ttf", "jpg"],
        "basePath" => APP_ROOT . "/Views/templates/bse.html",
    ],
    "paths" => [
        "config" => APP_ROOT . "/config",
        "data" => APP_ROOT . "/data",
        "views" => APP_ROOT . "/Views/routes",
        "templates" => APP_ROOT . "/Views/layouts",
        "assets" => DOC_ROOT . "/public/assets/enabled",
        "vendorAssets" => DOC_ROOT . "/public/assets/enabled/vendor",
        "routes" => APP_ROOT . "/routes",
        "logs" => APP_ROOT . "/logs",
    ],
    "aliases" => [
            "ctrl.mw.session" => App\Controllers\Middleware\SessionController::class,
            "ctrl.mw.initview" => App\Controllers\Middleware\View::class,
            "ctrl.rte.home" => App\Controllers\Routes\HomeController::class,
    ]
];
return $settings;