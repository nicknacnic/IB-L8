#!/usr/bin/env python3

import os
import cgi
import cgitb; cgitb.enable(format='text')  # for troubleshooting

print("Content-type: text/html")
print()

print("""
<html>
<head>
  <title>Syslog</title>
  <link rel="stylesheet" href="/style.css" type="text/css">
</head>
<body>

<div class="titleblock">
  <div class="image">
    <img src="/logo.svg" height="75px">
  </div>
  <div class="text">
    Syslog
  </div>
</div>
""")

#Print the menu
menu = open("menu.html", "r")
for line in menu:
  print(line)

print('<div class="response"><pre>')

# Recursively read all files in subdirectories of /var/log/syslog
for dirpath, dirnames, filenames in os.walk('/var/log/syslog'):
    for filename in filenames:
        path = os.path.join(dirpath, filename)
        with open(path, 'r') as f:
            for line in reversed(f.readlines()):
                print(line.strip())

print("</pre></div>")

print("""
  </body>
  </html>
""")
