#!/usr/bin/python
import re, os
import sys

# would be nice to 'cache' the result somewhere
# perhaps not necessary if we run as daemon... then only needed on startup
def get_authinfo_password(machine, login, port):
    #s = "machine %s login %s password ([^ ]*) port %s" % (machine, login, port)
    #s = "machine\s+%s\s+(?:port\s+%s\s+login\s+)?%s\s+password\s+(\S*)" % (machine, port, login)
    s = "machine\s+%s\s+(?:port\s+%s\s+)?login\s+%s\s+password\s+(\S*)" % (machine, port, login)
    p = re.compile(s)
    #gnome-gpg has a popup and save passphrase for a bit
    # but probably isn't available on osx
    #authinfo = os.popen("gnome-gpg -q -d ~/.authinfo.gpg").read()
    #authinfo = os.popen("gpg -q --no-tty -d ~/.authinfo.gpg").read()
    authinfo = os.popen("gpg -q -d ~/.authinfo.asc").read()
    return p.search(authinfo).group(1)

## TODO: add main so you can request info from command line
