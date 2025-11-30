#!.venv/bin/python3.10
import cgi
import cgitb
import css
import html

thedis = css.grammar.parse("""
body {
    background-color: #f0f0f0;
    font-family: Arial, sans-serif;
    margin: 20px;
}
""")

# Enable error reporting
cgitb.enable()

print("Content-Type: text/html\n")
print(f"""
<html>
<head>
    <title>Python CGI Test</title>
</head>
<body>
    <h1>H{thedis}from Python CGI!</h1>
    <p>This is a test of Python CGI scripting with Apache.</p>
""")

# Get form data (if any)
form = cgi.FieldStorage()
if "name" in form:
    print(f"<p>Hello, {form['name'].value}!</p>")

print("""
    <form method="post">
        <label for="name">Enter your name:</label>
        <input type="text" id="name" name="name">
        <input type="submit" value="Submit">
    </form>
</body>
</html>
""")