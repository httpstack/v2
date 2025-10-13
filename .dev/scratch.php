<?php
$body = $this->getElementsByTagName("body")->item(0);
$head = $this->getElementsByTagName("head")->item(0);

foreach ($assets as $index => $path) {
    $path = str_replace(DOC_ROOT, "", $path);
    $ext = pathinfo($path, PATHINFO_EXTENSION);
    switch ($ext) {
        case "css":
            $element = $this->createElement("link");
            $element->setAttribute("rel", "stylesheet");
            $element->setAttribute("href", $path);
            break;

        case "js":
            $element = $this->createElement("script");
            $element->setAttribute("src", $path);
            $element->setAttribute("defer", "defer");
            $element->setAttribute("type", "text/javascript");
            break;

        case "svg":
        case "png":
        case "jpg":
        case "jpeg":
        case  "gif":
            //make javascript image preloader
            break;

        case "woff":
        case "woff2":
        case "ttf":
        case "otf":
        case "eot":
            $element = $this->createElement("link");
            $element->setAttribute("rel", "preload");
            $element->setAttribute("href", $)

            //make javascript font preloader
            break;
    }
    $head->appendChild($script);
}


        $db = $c->make(DBConnect::class);
        $records = $db->fetchAll("SELECT * FROM layers");
        //print_r($records);