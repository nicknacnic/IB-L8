#!/usr/bin/env python

import cgi
import cgitb; cgitb.enable(format='text')  # for troubleshooting

print "Content-type: text/html"
print

print """
<html>
<head>
  <title>Apache2 Error Log</title>
  <link rel="stylesheet" href="/style.css" type="text/css">
</head>
<body>

<div class="titleblock">
  <div class="image">
    <img src="/logo.svg" height="75px">
  </div>
  <div class="text">
    Apache2 Error Log
  </div>
</div>
"""

#Print the menu
menu = open("menu.html", "r")
for line in menu:
  print line

print '<div class="response"><pre>'
log = open("/var/log/apache2/error.log", "r").readlines()
for line in reversed(log):
  print line.strip()
print "</pre></div>"

print """
  </body>
  </html>
"""
