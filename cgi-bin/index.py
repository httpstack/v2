#!.venv/bin/python3.10
import sys
import cgi
import cgitb

# Enable error reporting
cgitb.enable()

print("Content-Type: text/html\n")
print("""
<html>
<head>
    <title>Python CGI Test</title>
</head>
<body>
    <h1>Hello from Python CGI!</h1>
    <p>This is a test of Python CGI scripting with Apache.</p>
""")