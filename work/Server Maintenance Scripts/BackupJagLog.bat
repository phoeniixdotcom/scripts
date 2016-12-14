@echo off
REM Created by MXS 01-17-2005
REM This file makes a back up of the Jaguar server log and lables by YYMMDD
REM To use: Place this file in c:\scripts\ of the server you wish to use it
REM         Create a new Scheduled Task pointing to this file


REM ===== Set Variables =====
SET servicename=Jaguar
SET drive=e:\
SET originaldir=%drive%\logs\jaguar\
SET archivedir=%drive%\logs\jaguar\
SET originalfilename=srv.log
SET finalprefix=srv
SET finalsuffix=.log


REM ===== Stop Service =====
ECHO [ Stopping Jaguar service ]
net stop %servicename%


REM ===== Create renamed output =====
ECHO [ Generating new filename ]
for /f "tokens=1,2,3,4* delims=/ " %%i in ('date /T') do set T=%%i&set M=%%j&set D=%%k&set Y=%%l
SET finalfilename=%finalprefix%_%Y%%M%%D%%finalsuffix%


REM ===== Check for existing file =====
ECHO [ Checking for existing file ]
if exist "%originaldir%\%originalfilename%" goto backup
echo File does not exist! Please check the files location...
goto end


REM ===== Backup the file =====
:backup
ECHO [ Backing up %originalfilename% ]
move /Y "%originaldir%\%originalfilename%" "%archivedir%\%finalfilename%"


:end
REM ===== Start Service =====
ECHO [ Restarting Jaguar service ]
net start %servicename%


ECHO [----- Set a timeout of 15 seconds -----]
ping 1.1.1.1 -n 1 -w 15000 >NUL


REM Load the Airtran xml
start iexplore c:\scripts\airtran.htm

ECHO [----- Set a timeout of 15 seconds -----]
ping 1.1.1.1 -n 1 -w 15000 >NUL

c:\scripts\kill -f iexplore

ECHO [----- Set a timeout of 5 seconds -----]
ping 1.1.1.1 -n 1 -w 5000 >NUL

start iexplore c:\scripts\airtran.htm

ECHO [----- Set a timeout of 15 seconds -----]
ping 1.1.1.1 -n 1 -w 15000 >NUL

c:\scripts\kill -f iexplore

REM pause

