@ECHO OFF
ECHO ------------------------------------------------------------------
ECHO  JBoss temp file cleaner
ECHO  -This script will delete any jboss temp files.
ECHO  Author: MXS
ECHO ------------------------------------------------------------------
ECHO.

REM -----Set variables-----
set REMOTESERVICE=JBAS50SVC
set JBOSS_TMP_DIR=c:\jboss-5.1.0.GA\server\csa\tmp
set JBOSS_WORK_DIR=c:\jboss-5.1.0.GA\server\csa\work\jboss.web\localhost\_


CHOICE /C YN /T 10 /D N /M "This script will restart JBoss.  Are you sure you wish to continue?"
IF ERRORLEVEL 2 GOTO exit

ECHO.
ECHO [ Stopping service ]
net stop %REMOTESERVICE%
IF ERRORLEVEL 2 goto error8

ECHO.
ECHO [ Deleting jboss tmp dir ]
del /q /s %JBOSS_TMP_DIR%\*.*
REM rmdir /q /s %JBOSS_TMP_DIR%

ECHO.
ECHO [ Deleting jboss work root dir ]
del /q /s %JBOSS_WORK_DIR%\*.*
REM rmdir /q /s %JBOSS_WORK_DIR%

ECHO.
ECHO [ Restarting service ]
net start %REMOTESERVICE%
IF ERRORLEVEL 2 goto error9

goto exit



:error8
ECHO Error: Problem stopping service.  Do you run this as administrator?
goto exit

:error9
ECHO Error: Problem starting service.  Do you run this as administrator?
goto exit



:exit
ECHO.
pause
exit