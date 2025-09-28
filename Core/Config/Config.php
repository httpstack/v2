<?php

namespace Core\Config;

use Core\Container\Container;

class Config
{
    public array $settings = [];
    protected string $configDir;
    public function __construct()
    {
        //print_r($c);
        $this->configDir = "/config";
        $this->loadConfigs();
    }
    public function getSettings()
    {
        return $this->settings;     
    }
    public function setConfigDir(string $dir)
    {
        $this->configDir = $dir;
    }
    public function loadConfigs(): void
    {
        $configDir = $this->configDir;
        $configDir = APP_ROOT . $configDir;
        $configs = [];
        foreach (glob($configDir . '/*.php') as $file) {
           // print_r($file);
            $key = basename($file, '.php');
            $configs[$key] = include $file;
        }
        $this->settings = array_merge($this->settings, $configs);
    }
}