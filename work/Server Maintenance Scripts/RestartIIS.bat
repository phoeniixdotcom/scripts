@ECHO off
REM Created by MXS 01-17-2005
REM This file makes a back up of the Jaguar server log and restarts the Jaguar service
REM To use: Put in c:\scripts\ and set a scheduled task to run it
REM ===== Restart Jaguar =====


ECHO [----- Set Variables -----]
SET servicename="World Wide Web Publishing Service"
SET drive=c:\
SET originaldir=%drive%\logs\tomcat\
SET archivedir=%drive%\logs\tomcat\
SET originalfilename=isapi_redirect.log
SET finalprefix=isapi_redirect
SET finalsuffix=.log


ECHO [----- Stopping IIS service -----]
net stop %servicename%


ECHO [----- Set a timeout of 5 seconds -----]
ping 1.1.1.1 -n 1 -w 5000 >NUL


ECHO [----- Generating new filename -----]
SET finalfilename=%finalprefix%_bak%finalsuffix%


ECHO [----- Check for existing file -----]
if exist "%originaldir%\%originalfilename%" goto backup
ECHO File does not exist! Please check the files location...
goto end


ECHO [----- Backing up %originalfilename% -----]
:backup
move /Y "%originaldir%\%originalfilename%" "%archivedir%\%finalfilename%"


:end
ECHO [----- Starting IIS service -----]
net start %servicename%

rem pause

