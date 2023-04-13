#!/usr/bin/env python

import cgi
import cgitb; cgitb.enable(format='text')  # for troubleshooting

print "Content-type: text/html"
print

print """
<html>
<head>
  <title>IBL8 Log</title>
  <link rel="stylesheet" href="/style.css" type="text/css">
</head>
<body>

<div class="titleblock">
  <div class="image">
    <img src="/logo.svg" height="75px">
  </div>
  <div class="text">
    IBL8 Log
  </div>
</div>
"""

#Print the menu
menu = open("menu.html", "r")
for line in menu:
  print line

print '<div class="response"><pre>'
log = open("/var/ibl8/ibl8.log", "r").readlines()
for line in reversed(log):
  print line.strip()
print "</pre></div>"

print """
  </body>
  </html>
"""
