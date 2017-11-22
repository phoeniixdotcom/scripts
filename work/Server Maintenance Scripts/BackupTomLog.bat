@echo off
REM Created by MXS for CSA Travel Protection 01-31-2005
REM This bat requires the Winzip command line tool wzzip.exe
REM Td7 means dont archive anything newer than 7 days


REM ===== Archive the Tomcat logs =====

REM ===== Set Variables =====
SET WINZIPLOC="c:\program files\winzip\wzzip.exe"
SET TOMCATLOC="c:\logs\tomcat\"

REM ===== Get Date =====
for /f "tokens=1,2,3,4* delims=/ " %%i in ('date /T') do set T=%%i&set M=%%j&set D=%%k&set Y=%%l

REM ===== Archive Files =====
%WINZIPLOC% -m -Td7 %TOMCATLOC%access_log.%Y%.zip %TOMCATLOC%access_log*.txt
%WINZIPLOC% -m -Td7 %TOMCATLOC%localhost_log.%Y%.zip %TOMCATLOC%localhost_log*.txt



REM ===== Backup services logs =====

REM ===== Set Variables =====
SET SERVICENAME="Apache Tomcat"
SET TOMCATERRLOC=c:\logs\tomcat\
SET ORIGINALFILENAME=stdout.log
SET FINALFILENAME=stdout_bak.log

REM ===== Stop Service =====
echo [ Stopping service ]
net stop %SERVICENAME%

REM ===== Check for existing file =====
echo [ Checking for existing file ]
if exist "%TOMCATERRLOC%%ORIGINALFILENAME%" goto backup
echo File does not exist! Please check the files location...
goto end

REM ===== Backup the file =====
:backup
echo [ Backing up %ORIGINALFILENAME% ]
move /Y "%TOMCATERRLOC%%ORIGINALFILENAME%" "%TOMCATERRLOC%%FINALFILENAME%"

REM ===== Start Service =====
echo [ Restarting service ]
net start %SERVICENAME%


REM pause