#!/usr/bin/env python3

import cgi
import subprocess
import os
import cgitb; cgitb.enable(format='text')  # for troubleshooting

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

    log_dir = '/var/log/messages/'
    for log_file in os.listdir(log_dir):
        if log_file.endswith('.log'):
            log_path = os.path.join(log_dir, log_file)
            log = subprocess.check_output(['tail', '-n', '1000', log_path])
            for line in reversed(log.decode().split('\n')):
                print(line.strip())

print("""
  </body>
  </html>
""")
