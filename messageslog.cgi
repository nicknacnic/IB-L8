#!/usr/bin/env python3

import cgi
import cgitb
import os

cgitb.enable(format='text')  # for troubleshooting

print("Content-type: text/html")
print()

print("""
<html>
<head>
  <title>Messages</title>
  <link rel="stylesheet" href="/style.css" type="text/css">
</head>
<body>

<div class="titleblock">
  <div class="image">
    <img src="/logo.svg" height="75px">
  </div>
  <div class="text">
    Messages
  </div>
</div>
""")

# Print the menu
menu = open("menu.html", "r")
for line in menu:
    print(line)

print('<div class="response"><pre>')

# List all the files in /var/log/
log_dir = "/var/log/"
log_files = os.listdir(log_dir)
all_logs = []

for filename in sorted(log_files):
    if os.path.isfile(os.path.join(log_dir, filename)):
        try:
            with open(os.path.join(log_dir, filename), "r") as log_file:
                all_logs.append("<h3>{}</h3>".format(filename))
                all_logs.extend(reversed(log_file.readlines()))
                all_logs.append("<br/>")
        except PermissionError:
            print("<p>Cannot read file {} due to insufficient permissions.</p>".format(filename))

print("".join(all_logs))

print("</pre></div>")

print("""
  </body>
  </html>
""")
