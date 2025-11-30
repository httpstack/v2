<?php

namespace Core\Template\Traits;

use DOMXPath;
use DOMElement;
use DOMDocument;
use DOMNode;
use DOMDocumentFragment;

trait DomManipulator
{
    public function make($element, $attrs = [], $text = null)
    {
        $el = $this->createElement($element);
        foreach ($attrs as $k => $v) {
            $el->setAttribute($k, (string) $v);
        }

        if ($text !== null) {
            $el->appendChild($this->createTextNode($text));
        }

        return $el;
    }


    public function byClass($class)
    {
        $list = $this->xp->query("//*[contains(concat(' ', normalize-space(@class), ' '), ' " . $class . " ')]");
        return $list ? $list->item(0) : null;
    }
    public function byID($id)
    {
        return $this->getElementByID($id);
    }
    public function byTag($tag)
    {
        $list = $this->getElementsByTagName($tag);
        return $list ? $list->item(0) : null;
    }

    public function queryAll(string $xpath): ?\DOMNodeList
    {
        $this->setXPath();
        return $this->xp->query($xpath);
    }

    public function queryOne(string $xpath): ?DOMNode
    {
        $list = $this->queryAll($xpath);
        $this->setXPath();
        return $list ? $list->item(0) : null;
    }

    public function setXPath(): void
    {
        $this->xp = new DOMXPath($this);
    }

    public function isXPath(): bool
    {
        return isset($this->xp) && $this->xp instanceof DOMXPath;
    }

    // set single attribute
    public function setAttr(DOMNode | string $target, string $name, string $value): bool
    {
        $node = $this->queryOne($target);
        if (! $node || ! ($node instanceof DOMElement)) {
            return false;
        }

        $node->setAttribute($name, $value);
        $this->setXPath();
        return true;
    }

    // set multiple attributes from assoc array
    public function setAttrs(DOMNode | string $target, array $attrs): bool
    {
        $node = $this->queryOne($target);
        if (! $node || ! ($node instanceof DOMElement)) {
            return false;
        }

        foreach ($attrs as $k => $v) {
            $node->setAttribute($k, (string) $v);
        }
        $this->setXPath();
        return true;
    }

    // set textContent (for elements) or nodeValue (for other nodes)
    public function setText(DOMNode | string $target, string $text): bool
    {
        $node = $this->queryOne($target);
        if (! $node) {
            return false;
        }

        if ($node instanceof DOMElement) {
            // remove children then set text
            while ($node->firstChild) {
                $node->removeChild($node->firstChild);
            }

            $node->appendChild($this->createTextNode($text));
        } else {
            $node->nodeValue = $text;
        }
        $this->setXPath();
        return true;
    }

    // replace inner HTML of an element (fragFrom string)
    public function setHtml(DOMNode | string $target, string $html): bool
    {
        $node = $this->queryOne($target);
        if (! $node || ! ($node instanceof DOMElement)) {
            return false;
        }

        while ($node->firstChild) {
            $node->removeChild($node->firstChild);
        }

        $frag = $this->createDocumentFragment();
        // suppress warnings for malformed fragments
        @$frag->appendXML($html);
        $node->appendChild($frag);
        $this->setXPath();
        return true;
    }

    // append HTML fragment into target
    public function appendHtml(DOMNode | string $target, string $html): bool
    {
        $node = $this->queryOne($target);
        if (! $node || ! ($node instanceof DOMElement)) {
            return false;
        }

        $frag = $this->createDocumentFragment();
        @$frag->appendXML($html);
        $node->appendChild($frag);
        $this->setXPath();
        return true;
    }

    // create and append an element with optional attrs and text
    public function add(DOMNode | string $parent, string $tag, array $attrs = [], ?string $text = null): ?DOMElement
    {
        $p = $this->queryOne($parent);
        if (! $p || ! ($p instanceof DOMElement)) {
            return null;
        }

        $el = $this->createElement($tag);
        foreach ($attrs as $k => $v) {
            $el->setAttribute($k, (string) $v);
        }

        if ($text !== null) {
            $el->appendChild($this->createTextNode($text));
        }

        $p->appendChild($el);
        $this->setXPath();
        return $el;
    }

    // create fragment from file and append to target
    public function appendFromFile(DOMNode | string $target, string $path): bool
    {
        if (! is_readable($path)) {
            return false;
        }

        $frag = $this->createDocumentFragment();
        @$frag->appendXML(file_get_contents($path));
        $this->setXPath();
        return $this->appendFragTo($target, $frag);
    }

    // append a fragment to target node
    public function appendFragTo(DOMNode | string $target, DOMDocumentFragment $frag): bool
    {
        $node = $this->queryOne($target);
        if (! $node) {
            return false;
        }

        $node->appendChild($frag);
        $this->setXPath();
        return true;
    }

    // remove node(s) by DOMNode or XPath selector
    public function remove(DOMNode | string $target): int
    {
        if ($target instanceof DOMNode) {
            $parent = $target->parentNode;
            if ($parent) {
                $parent->removeChild($target);
                return 1;
            }
            $this->setXPath();
            return 0;
        }
        // treat string as xpath and remove all matches
        $list  = $this->queryAll($target);
        $count = 0;
        if ($list) {
            foreach (iterator_to_array($list) as $n) {
                if ($n->parentNode) {
                    $n->parentNode->removeChild($n);
                    $count++;
                }
            }
        }
        $this->setXPath();
        return $count;
    }

    // quick check whether a string contains HTML markup
    public function isHTML(string $str): bool
    {
        return (bool) preg_match('/<[^>]+>/', $str);
    }

    // Convert simple/typical XPath -> CSS selector (common cases)
    public function xpath2css(string $xpath): string
    {
        $xpath = trim($xpath);
        if ($xpath === '') {
            return '';
        }

        preg_match_all('#(//?)([^/]+)#', $xpath, $matches, PREG_SET_ORDER);
        $parts = [];
        foreach ($matches as $i => $m) {
            $sep     = $m[1] === '//' ? ' ' : ' > ';
            $segment = $m[2];
            if (preg_match('#^([a-zA-Z0-9_\*\-:]+)#', $segment, $pm)) {
                $tag = $pm[1];
            } else {
                $tag = '*';
            }
            preg_match_all('#\[(.*?)\]#', $segment, $preds);
            $selector = ($tag === '*' ? '' : $tag);
            foreach ($preds[1] as $pred) {
                $pred = trim($pred);
                if (preg_match('#^\d+$#', $pred, $pnum)) {
                    $selector .= ':nth-of-type(' . $pnum[0] . ')';
                    continue;
                }
                if (preg_match('#^@([a-zA-Z0-9_\-:]+)\s*=\s*\'([^\']*)\'$#', $pred, $pm2)) {
                    $attr = $pm2[1];
                    $val  = $pm2[2];
                    if ($attr === 'id') {
                        $selector .= '#' . $val;
                    } elseif ($attr === 'class') {
                        foreach (preg_split('/\s+/', trim($val)) as $c) {
                            if ($c !== '') {
                                $selector .= '.' . $c;
                            }
                        }
                    } else {
                        $selector .= '[' . $attr . '="' . addcslashes($val, '"') . '"]';
                    }
                    continue;
                }
                if (preg_match("#contains\\(concat\\(' ',\\s*normalize-space\\(@class\\),\\s*' '\\),\\s*'([^']+)'\\)#", $pred, $pm3)) {
                    $cls = trim($pm3[1]);
                    if ($cls !== '') {
                        $selector .= '.' . $cls;
                    }

                    continue;
                }
                if (preg_match("#contains\\(@([a-zA-Z0-9_\-:]+),\\s*'([^']+)'\\)#", $pred, $pm4)) {
                    $attr = $pm4[1];
                    $val  = $pm4[2];
                    if ($attr === 'class') {
                        $selector .= '.' . trim($val);
                    } else {
                        $selector .= '[' . $attr . '*="' . addcslashes($val, '"') . '"]';
                    }

                    continue;
                }
                if (preg_match('#^@([a-zA-Z0-9_\-:]+)$#', $pred, $pm5)) {
                    $selector .= '[' . $pm5[1] . ']';
                    continue;
                }
                if (preg_match("#^([a-zA-Z0-9_\-:]+)\s*=\s*'([^']*)'$#", $pred, $pm6)) {
                    $selector .= '[' . $pm6[1] . '="' . addcslashes($pm6[2], '"') . '"]';
                    continue;
                }
            }
            if ($i === 0) {
                $parts[] = $selector;
            } else {
                $parts[] = $sep . $selector;
            }
        }
        $css = trim(implode('', $parts));
        return preg_replace('/\s+/', ' ', $css);
    }

    // Convert simple CSS -> XPath
    public function css2xpath(string $css): string
    {
        $css = trim($css);
        if ($css === '') {
            return '';
        }

        $tokens     = preg_split('/(\s*>\s*|\s+)/', $css, -1, PREG_SPLIT_DELIM_CAPTURE | PREG_SPLIT_NO_EMPTY);
        $xpathParts = [];
        foreach ($tokens as $tok) {
            $tok = trim($tok);
            if ($tok === '') {
                continue;
            }

            if ($tok === '>') {
                $xpathParts[] = '/';
                continue;
            }
            if (preg_match('/^\s+$/', $tok)) {
                $xpathParts[] = '//';
                continue;
            }
            preg_match_all('#([a-zA-Z0-9\*_\-:]+|#[a-zA-Z0-9_\-]+|\.[a-zA-Z0-9_\-]+|\[[^\]]+\]|:[a-zA-Z0-9\-\(\)]+)#', $tok, $m);
            $segments = $m[0];
            $tag      = '*';
            $conds    = [];
            foreach ($segments as $s) {
                if ($s === '*') {
                    $tag = '*';
                    continue;
                }
                if (preg_match('#^[a-zA-Z][a-zA-Z0-9_\-:]*$#', $s)) {
                    $tag = $s;
                    continue;
                }
                if ($s[0] === '#') {
                    $conds[] = "@id='" . addcslashes(substr($s, 1), "'") . "'";
                    continue;
                }
                if ($s[0] === '.') {
                    $conds[] = "contains(concat(' ', normalize-space(@class), ' '), ' " . addcslashes(substr($s, 1), "'") . " ')";
                    continue;
                }
                if ($s[0] === '[') {
                    $attr = trim(substr($s, 1, -1));
                    if (preg_match('#^([a-zA-Z0-9_\-:]+)\s*=\s*"(.*)"$#', $attr, $pm)) {
                        $conds[] = "@" . $pm[1] . "='" . addcslashes($pm[2], "'") . "'";
                        continue;
                    }
                    if (preg_match('#^([a-zA-Z0-9_\-:]+)\s*\*\=\s*"(.*)"$#', $attr, $pm2)) {
                        $conds[] = "contains(@" . $pm2[1] . ",'" . addcslashes($pm2[2], "'") . "')";
                        continue;
                    }
                    if (preg_match('#^([a-zA-Z0-9_\-:]+)$#', $attr, $pm3)) {
                        $conds[] = "@" . $pm3[1];
                        continue;
                    }
                }
                if (strpos($s, ':nth-of-type(') === 0) {
                    if (preg_match('#:nth-of-type\((\d+)\)#', $s, $pn)) {
                        $conds[] = "position()=" . $pn[1];
                        continue;
                    }
                }
            }
            $condStr      = count($conds) ? '[' . implode(' and ', $conds) . ']' : '';
            $xpathParts[] = ($tag ?: '*') . $condStr;
        }
        $xpath = '';
        for ($i = 0; $i < count($xpathParts); $i++) {
            $part = $xpathParts[$i];
            if ($i === 0) {
                $xpath .= '//' . $part;
                continue;
            }
            $prev = $xpathParts[$i - 1];
            if ($prev === '/') {
                $xpath .= '/' . $part;
            } elseif ($prev === '//') {
                $xpath .= '//' . $part;
            } else {
                $xpath .= '//' . $part;
            }
        }
        return preg_replace('#//+#', '//', $xpath);
    }
}
