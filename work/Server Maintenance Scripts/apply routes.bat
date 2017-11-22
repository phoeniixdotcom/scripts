@echo off
REM Set the routes of the three new jboss servers
REM Created by MXS 11-02-2012

route -p add 10.14.2.64 mask 255.255.255.255 10.14.2.42

pause