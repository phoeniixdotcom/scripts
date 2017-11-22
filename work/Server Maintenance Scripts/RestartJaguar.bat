@echo off
REM Created by MXS 01-31-2005
REM This bat restarts Jaguar


REM ===== Restart Jaguar =====

REM ===== Set Variables =====
SET SERVICENAME="Jaguar"


REM ===== Stop Service =====
echo [ Stopping service ]
net stop %SERVICENAME%

ECHO [----- Set a timeout of 5 seconds -----]
ping 1.1.1.1 -n 1 -w 5000 >NUL

REM ===== Start Service =====
echo [ Restarting service ]
net start %SERVICENAME%


REM pause