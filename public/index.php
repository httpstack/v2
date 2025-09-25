<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(32767); // E_ALL
require_once("../App/init.php");

use \Core\Http\Request;
use App\App;

$req = new Request();
$app = new App($req);
$app->before("GET", "*", ['App\Controllers\Middleware\View', 'process']);
$app->get('/home', ['ctrl.rte.home', 'index']);
$app->get('/signup', ['App\Controllers\Routes\SignupController', 'index']);
$app->post('/signup', ['App\Controllers\Routes\SignupController', 'index']);
$app->run();
