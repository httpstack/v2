#!/usr/bin/perl
use strict;
use warnings;
use CGI;

my $cgi = CGI->new;
print $cgi->header('text/html');
print <<END_HTML;
<html>
<head>
    <title>Perl CGI Test</title>
</head>
<body>
    <h1>Hello from Perl CGI!</h1>
    <form method="post">
        <label for="name">Enter your name:</label>
        <input type="text" id="name" name="name">
        <input type="submit" value="Submit">
    </form>
END_HTML

if (my $name = $cgi->param('name')) {
    print "<p>Hello, $name!</p>";
}

print "</body></html>";
