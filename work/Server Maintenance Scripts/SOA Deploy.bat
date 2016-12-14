@ECHO off
REM Created by MXS 01-17-2005
REM This file copies the latest server ear file and restarts the JBoss service
REM ===== Restart Jaguar =====


ECHO [----Set Variables ----]
SET   servicename=JBAS50SVC



ECHO [----- Stopping JBoss service -----]
net stop %servicename%



ECHO "Copy ear file from \\SOADEMO002 to Deploy folder"
copy \\soademo002\c$\jboss-5.1.0.GA\server\csa\deploy\import-app-1.0.ear "C:\jboss-5.1.0.GA\server\csa\deploy"
IF ERRORLEVEL 1 goto error2

Pause

ECHO [----- Starting Jaguar service -----]
net start %servicename%

:end

pause

REM -----ERRORS-----
:error1
SET LEVEL=1
ECHO ERROR: You must specify a server name as x in xxxx.travelsecure.local.
goto exit

:error2
ECHO ERROR: Unable to mape a drive to remote server.
SET LEVEL=2
goto deldrive

:error5
ECHO ERROR: Unable to copy files.
SET LEVEL=5
goto deldrive

:error6
ECHO ERROR: Unable to delete directory.
SET LEVEL=6
goto deldrive

:error10
ECHO ERROR: Problem deleting remote drive.
SET LEVEL=10
goto exit


:exit
REM pause
EXIT %LEVEL%