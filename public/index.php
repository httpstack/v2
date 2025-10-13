<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(32767); // E_ALL
require_once "../App/init.php";

use App\App;
use \Core\Http\Request;

$req = new Request();
$app = new App($req);
$app->before("GET", "*", ['App\Controllers\Middleware\View', 'process']);
$app->get('/home', ['ctrl.rte.home', 'index']);

$app->get("/home/model", ["ctrl.rte.home", "index"]);
$app->get("/home/elements", ["ctrl.rte.home", "index"]);
/*
$app->get("/home/elements", ["ctrl.rte.home", "elements"]);
$app->get("/home/specify", ["ctrl.rte.home", "specify"]);
$app->get("/home/stacktool", ["ctrl.rte.home", "stacktool"]);
*/
$app->get('/layers', ['ctrl.rte.layers', 'layers']);
$app->get('/layers/:layerID', ['ctrl.rte.layers', 'id']);
$app->run();
