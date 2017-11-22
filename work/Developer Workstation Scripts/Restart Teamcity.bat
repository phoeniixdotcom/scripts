@echo off
REM Created by zig 1/25/07

REM ===== Restart agentd =====

REM ===== Set Variables =====
SET SERVICENAME="agentd"


REM ===== Stop Service =====
echo [ Stopping service ]
net stop %SERVICENAME%

REM ===== Start Service =====
echo [ Restarting service ]
net start %SERVICENAME%


REM pause