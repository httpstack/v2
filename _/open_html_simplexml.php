<?php
// Example: open/parse HTML using SimpleXML
// Two approaches:
// 1) Parse well-formed XHTML (XML) directly with SimpleXML
// 2) For arbitrary HTML, use DOMDocument to tidy/convert to XML then simplexml_import_dom

function parse_xhtml_with_simplexml(string $xhtml)
{
    // SimpleXML expects well-formed XML (e.g., XHTML with closing tags, proper namespaces)
    libxml_use_internal_errors(true);
    $sxe = simplexml_load_string($xhtml);
    if ($sxe === false) {
        $errs = libxml_get_errors();
        foreach ($errs as $err) {
            echo "XML error: ", trim($err->message), "\n";
        }
        libxml_clear_errors();
        return null;
    }
    return $sxe;
}

function parse_html_with_dom_and_simplexml(string $html)
{
    // Use DOMDocument to parse HTML and convert to XML for SimpleXML consumption
    libxml_use_internal_errors(true);
    $dom = new DOMDocument();
    // Suppress warnings and allow recovery from malformed HTML
    $dom->loadHTML('<?xml encoding="utf-8" ?>' . $html, LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
    // Normalize and convert
    $dom->preserveWhiteSpace = false;
    $sxe = simplexml_import_dom($dom);
    if ($sxe === false) {
        $errs = libxml_get_errors();
        foreach ($errs as $err) {
            echo "DOM->SimpleXML error: ", trim($err->message), "\n";
        }
        libxml_clear_errors();
        return null;
    }
    return $sxe;
}

// Demo XHTML string (well-formed)
$xhtml = <<<XHTML
<?xml version="1.0" encoding="utf-8"?>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Example</title>
  </head>
  <body>
    <div id="main">
      <h1>Hello</h1>
      <p class="lead">This is well-formed XHTML.</p>
    </div>
  </body>
</html>
XHTML;

// Demo HTML string (possibly not well-formed)
$html = '<html><head><title>Test</title></head><body><div id="main"><h1>Hi</h1><p>Paragraph without closing tag';

echo "--- Parse XHTML with SimpleXML ---\n";
$sxe = parse_xhtml_with_simplexml($xhtml);
if ($sxe) {
    echo "Title: ", (string) $sxe->head->title, "\n";
    echo "H1: ", (string) $sxe->body->div->h1, "\n";
}

echo "\n--- Parse HTML with DOM + SimpleXML ---\n";
$sxe2 = parse_html_with_dom_and_simplexml($html);
if ($sxe2) {
    // Note: when parsed via DOM->SimpleXML, elements may be under html->body
    $title = $sxe2->xpath('//title');
    $h1 = $sxe2->xpath('//h1');
    if ($title) echo "Title: ", (string) $title[0], "\n";
    if ($h1) echo "H1: ", (string) $h1[0], "\n";
}

// Usage hint printed when run
echo "\nRun: php _/open_html_simplexml.php\n";

// -----------------------------------------------------------------------------
// Handlebars-style rendering helpers (server-side)
// Supports simple {{var}} and dotted paths like {{user.name}}
// -----------------------------------------------------------------------------

/**
 * Render handlebars-style tokens in a string using a context array.
 * Supports dotted paths (e.g. user.name).
 */
function render_handlebars_in_string(string $template, array $context): string
{
    return preg_replace_callback('/{{\s*([a-zA-Z0-9_\.]+)\s*}}/', function ($m) use ($context) {
        $keys = explode('.', $m[1]);
        $val = $context;
        foreach ($keys as $k) {
            if (is_array($val) && array_key_exists($k, $val)) {
                $val = $val[$k];
            } elseif (is_object($val) && isset($val->{$k})) {
                $val = $val->{$k};
            } else {
                return ''; // missing -> empty string (could also return original token)
            }
        }
        return is_scalar($val) ? (string) $val : '';
    }, $template);
}

/**
 * Walk a DOMNode tree and replace handlebars tokens in text nodes and attributes.
 */
function render_handlebars_in_dom(
    DOMNode $node,
    array $context
) {
    // Replace in attributes
    if ($node instanceof DOMElement && $node->hasAttributes()) {
        foreach ($node->attributes as $attr) {
            // DOMAttr stores the attribute text in nodeValue
            $old = $attr->nodeValue;
            $new = render_handlebars_in_string($old, $context);
            if ($new !== $old) $attr->nodeValue = $new;
        }
    }

    // Replace in text nodes
    if ($node instanceof DOMText) {
        $new = render_handlebars_in_string($node->nodeValue, $context);
        if ($new !== $node->nodeValue) $node->nodeValue = $new;
    }

    // Recurse
    if ($node->hasChildNodes()) {
        foreach ($node->childNodes as $child) {
            render_handlebars_in_dom($child, $context);
        }
    }
}

// Demo: render handlebars tokens in plain string
$template = 'Hello, {{user.first}} {{user.last}}!';
$ctx = ['user' => ['first' => 'Alice', 'last' => 'Cooper']];
echo "\n--- Handlebars string rendering ---\n";
echo render_handlebars_in_string($template, $ctx), "\n";

// Demo: render handlebars into HTML via DOMDocument
$htmlWithTpl = '<div><h2>{{title}}</h2><p data-note="{{note}}">Hi {{user.first}}</p></div>';
$context = ['title' => 'Welcome', 'note' => 'meta value', 'user' => ['first' => 'Zoe']];

$dom = new DOMDocument();
libxml_use_internal_errors(true);
$dom->loadHTML('<?xml encoding="utf-8" ?>' . $htmlWithTpl, LIBXML_HTML_NOIMPLIED | LIBXML_HTML_NODEFDTD);
render_handlebars_in_dom($dom->documentElement, $context);

echo "\n--- Handlebars rendered DOM ---\n";
echo $dom->saveHTML(), "\n";

echo "\n(Notes: server-side rendering replaces tokens before sending HTML. For advanced features use a proper templating engine like Mustache/Handlebars PHP implementations.)\n";
