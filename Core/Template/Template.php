<?php

namespace Core\Template;

use DOMDocument;
use Core\IO\FS\FileLoader;

class Template extends DOMDocument
{

    protected array $templates = [];
    public function __construct($c, $version = '1.0', $encoding = 'UTF-8')
    {
        parent::__construct($version, $encoding);
        $this->formatOutput = true; // Optional: makes the output more readable
    }
    public function loadTemplate($nameSpace, $template)
    {
        $this->templates[$nameSpace] = $template;
    }
    public function installTemplate($nameSpace)
    {
        if (isset($this->templates[$nameSpace])) {
            @$this->loadHTML(file_get_contents($this->templates[$nameSpace]), LIBXML_NOWARNING | LIBXML_NOERROR);
        }
    }
    public function installView($namespace, $xpath)
    {
        if (isset($this->templates[$namespace])) {
            $xp = new \DOMXPath($this);
            $container = $xp->query($xpath)->item(0);
            $view = $this->createDocumentFragment();
            $view->appendXML(file_get_contents($this->templates[$namespace]));
            $container->appendChild($view);
        }
    }
    protected function init()
    {

        $this->load($this->templates['layout']);
    }
}
