<?php

namespace Core\Template;

use Core\Config\Config;
use DOMDocument;
use DOMDocumentFragment;
use DOMElement;
use DOMNode;
use DOMXPath;
use Core\Template\Traits\RenderTemplate;
use Core\Template\Traits\DomManipulator;

class Template extends DOMDocument
{
    use RenderTemplate;
    use DomManipulator;
    protected array $settings  = [];
    protected array $templates = [];
    protected ?DOMXPath $xp    = null;
    protected array $assets    = [];
    protected array $vars      = [];
    protected array $funcs     = [];

    protected function addFunction($nameSpace, $func)
    {
        $this->funcs[$nameSpace] = $func;
    }
    protected function addVar($key, $val)
    {
        $this->vars[$key] = $val;
    }

    public function var(string|array $key, mixed $val = ''): mixed
    {
        if (is_array($key)) {
            foreach ($key as $k => $v) {
                $this->vars[$k] = $v;
            }
            //after adding the var, return the variable count
            return  count($this->vars) - 1;
        }
        if (is_string($key) && $val) {
            $this->vars[$key] = $val;
            //after adding the var, return the variable count
            return  count($this->vars) - 1;
        } else {
            //if there is a key , thats a string, with no value, then returnthe key
            return $this->vars[$key];
        }
    }
    public function define(string $key, callable $func)
    {
        $this->funcs[$key] = $func;
    }
    public function remVar(string $key = '')
    {
        if ($key) {
            unset($this->vars[$key]);
        } else {
            $this->vars = [];
        }
    }
    public function getVars()
    {
        return $this->vars;
    }
    public function __construct($c, $version = '1.0', $encoding = 'UTF-8')
    {
        parent::__construct($version, $encoding);
        $this->formatOutput = true; // Optional: makes the output more readable
        $this->settings[]   = $c->make(Config::class);
    }
    public function setAssets($assets)
    {
        $this->assets = $assets;
    }
    public function loadAssets()
    {
        $head    = $this->queryOne('//head');
        $preload = [];
        foreach ($this->assets as $asset) {
            $asset = str_replace(DOC_ROOT, '', $asset);

            $assetType = pathinfo($asset, PATHINFO_EXTENSION);
            switch ($assetType) {
                case "css":
                    $element = $this->createElement("link");
                    $element->setAttribute("rel", "stylesheet");
                    $element->setAttribute("href", $asset);
                    //$head->appendChild($element);
                    break;
                case "js":
                    $element = $this->createElement("script");
                    $baseName = basename($asset);
                    if (!str_ends_with($baseName, ".cmp.js")) {
                        $element->setAttribute("defer", "defer");
                    }
                    $element->setAttribute("src", $asset);
                    $element->setAttribute("type", "text/javascript");
                    //$head->appendChild($element);
                    break;

                case "svg":
                case "png":
                case "jpg":
                case "jpeg":
                case "gif":
                    $preload[] = $asset;
                    //make javascript image preloader
                    break;

                case 'woff':
                case 'woff2':
                case 'ttf':
                case 'otf':
                case 'eot':
                    // collect fonts and add preload hint
                    $fontAssets[] = $asset;
                    $element      = $this->createElement('link');
                    $element->setAttribute('rel', 'preload');
                    $element->setAttribute('as', 'font');
                    $element->setAttribute('href', $asset);
                    $element->setAttribute('crossorigin', 'anonymous');
                    //$head->appendChild($element);
                    break;
            }
        }
        $this->setXPath();
    }
    public function readTemplate($nameSpace, $template)
    {
        $this->templates[$nameSpace] = $template;
    }
    public function loadTemplate($nameSpace)
    {
        if (isset($this->templates[$nameSpace])) {
            @$this->loadHTML(file_get_contents($this->templates[$nameSpace]), LIBXML_NOWARNING | LIBXML_NOERROR);
            $this->setXPath();
        }
    }
    public function loadView($namespace, $xpath)
    {
        if (isset($this->templates[$namespace])) {
            $xp        = new DOMXPath($this);
            $container = $xp->query($xpath)->item(0);
            if ($container) {
                $view = $this->createDocumentFragment();
                $view->appendXML(file_get_contents($this->templates[$namespace]));
                $container->appendChild($view);
            }
        }
    }
    protected function init()
    {
        $this->load($this->templates['layout']);
    }
}
