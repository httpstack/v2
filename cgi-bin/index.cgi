#!.venv/bin/python3.10
import cgitb
import cgi

from urllib.parse import urlparse

from core.container import Container
from core.fs.file import FileLoader
from flask import Flask, request

# Enable error reporting
cgitb.enable()
print("Content-Type: text/html\n")
container = Container()
loader = FileLoader(container)

# Register alias
container.alias("ctrl.routes.home", "app.controllers.routes.home.HomeController")
home_ctrl = loader.include("ctrl.routes.home")
content = home_ctrl.index()
print(content)

# Get form data (if any)

    