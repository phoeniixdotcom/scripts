@echo off
REM Created by MXS 0052605
REM This bat requires the dos command rd


REM ===== Backup services logs =====

REM ===== Set Variables =====
SET SERVICENAME="Apache Tomcat"
SET TOMCATERRLOC=c:\jakarta-tomcat-5.5.12\webapps
SET ORIGINALFILENAME=\csa\

REM ===== Stop Service =====
echo [ Stopping service ]
net stop %SERVICENAME%

REM ===== Check for existing file =====
echo [ Checking for existing file ]
if exist "%TOMCATERRLOC%%ORIGINALFILENAME%" goto backup
echo Folder does not exist! Please check the files location...
goto end

REM ===== Remove directory =====
:backup
echo [ Removing %ORIGINALFILENAME% ]
rd /s /q "%TOMCATERRLOC%%ORIGINALFILENAME%"

:end
REM ===== Start Service =====
echo [ Restarting service ]
net start %SERVICENAME%

REM pause