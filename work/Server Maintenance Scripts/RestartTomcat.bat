@echo off
REM Created by MXS 01-31-2005
REM This bat requires the Winzip command line tool wzzip.exe
REM Td7 means dont archive anything newer than 7 days


REM ===== Restart Tomcat =====

REM ===== Set Variables =====
SET SERVICENAME="Apache Tomcat"


REM ===== Stop Service =====
echo [ Stopping service ]
net stop %SERVICENAME%

ECHO [----- Set a timeout of 5 seconds -----]
ping 1.1.1.1 -n 1 -w 5000 >NUL

REM ===== Start Service =====
echo [ Restarting service ]
net start %SERVICENAME%


REM pause