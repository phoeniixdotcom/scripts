REM @ECHO OFF
REM MXS
REM Deploy war to the nightly server
REM Needs to deploy to testing server
REM Requires netsvc from the Server Tools CD
REM INPUT: 
REM %1 is the remote server pc name

ECHO ------------------------------------------------------------------
ECHO  CSA Build Deployer for Tomcat
ECHO  -This script will deploy the latest war to the specified server.
ECHO ------------------------------------------------------------------
ECHO.


REM -----Set variables-----
SET REMOTESERVICE="Apache Tomcat"
SET REMOTEDRIVE=Z:
SET DEPLOYLOC=\deploy
SET TOMCATLOC=\jakarta-tomcat-5.5.12\webapps
SET WEBAPPFOLDER=\csa\
SET ERROR=
for /f "tokens=1,2,3,4* delims=/ " %%i in ('date /T') do set T=%%i&set M=%%j&set D=%%k&set YY=%%l
SET Y=%YY:~-2%
IF (%1)==() (
    goto error1
) ELSE (
    SET REMOTESERVER=%1
)






ECHO [ Map network drive to deploy server ]
net use %REMOTEDRIVE% \\%REMOTESERVER%.csaweb.local\c$%TOMCATLOC% /USER:csaweb\administrator "8ontNose"
IF ERRORLEVEL 1 goto error2






ECHO [ Checking for existing war ]
if exist %REMOTEDRIVE%\csa.war (
	ECHO [ Backup existing war ]
	copy /Y /D /B %REMOTEDRIVE%\csa.war %REMOTEDRIVE%\backup\csa%Y%%M%%D%.war
	IF ERRORLEVEL 1 goto error3
	goto deploy
) ELSE (
	goto deploy
)






:deploy
ECHO [ Deploying web application ]

ECHO [ Stopping service ]
netsvc %REMOTESERVICE% \\%REMOTESERVER%.csaweb.local /stop
IF ERRORLEVEL 2 goto error8

ECHO [ Set a timeout of 5 seconds ]
ping 1.1.1.1 -n 1 -w 5000 >NUL

ECHO [ Adding war to tomcat ]
copy /Y /D /B c:%DEPLOYLOC%\csa.war %REMOTEDRIVE%\csa.war
IF ERRORLEVEL 1 goto error5

ECHO [ Checking for existing webapp folder ]
if exist "%REMOTEDRIVE%%WEBAPPFOLDER%" goto remove
ECHO Webapp folder does not exist! Ok to restart Tomcat...
goto start






:remove
ECHO [ Removing %WEBAPPFOLDER% ]
rd /s /q %REMOTEDRIVE%%WEBAPPFOLDER%
IF ERRORLEVEL 1 goto error6
goto start






:start
ECHO [ Restarting service ]
netsvc %REMOTESERVICE% \\%REMOTESERVER%.csaweb.local /start
IF ERRORLEVEL 2 goto error9
goto deldrive






:deldrive
ECHO [ Deleting Mapped Drive ]
net use %REMOTEDRIVE% /DELETE
IF ERRORLEVEL 1 goto error10
goto exit






REM -----ERRORS-----
:error1
SET LEVEL=1
ECHO ERROR: You must specify a servername as x in xxxx.csaweb.local.
goto exit

:error2
ECHO ERROR: Unable to map drive to remote server.
SET LEVEL=2
goto deldrive

:error3
ECHO ERROR: Unable to backup old war.
SET LEVEL=3
goto start

:error4
ECHO ERROR: Service doesnt exist.
SET LEVEL=4
goto deldrive

:error5
ECHO ERROR: Unable to copy up new war.
SET LEVEL=5
goto start

:error6
ECHO ERROR: Unable to delete old webapp directory.
SET LEVEL=6
goto start

:error8
ECHO Error: Problem stopping service.
set ERROR=error8
goto start

:error9
ECHO Error: Problem starting service.
SET LEVEL=9
goto deldrive

:error10
ECHO Error: Problem deleting remote drive.
SET LEVEL=10
goto exit






:exit
ECHO %LEVEL%
REM pause
exit %LEVEL%