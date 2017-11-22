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



ECHO [ Map network drive to nightly server ]
net use %REMOTEDRIVE% \\%REMOTESERVER%.csaweb.local\c$%TOMCATLOC% /USER:csaweb\administrator "8ontNose"
IF ERRORLEVEL 1 goto error2


ECHO [ Checking for existing war ]
if exist %REMOTEDRIVE%\csa.war (
	ECHO [ Backup existing war ]
	copy /Y /D /B %REMOTEDRIVE%\csa.war %REMOTEDRIVE%\backup\csa%Y%%M%%D%.war
	IF ERRORLEVEL 1 goto error3
) ELSE (
	goto deploy
)



:deploy
ECHO [ Stopping service ]
netsvc %REMOTESERVICE% \\%REMOTESERVER%.csaweb.local /stop
IF ERRORLEVEL 1 ECHO WARNING!!! Action behaved differently than expected.


ECHO [ Set a timeout of 5 seconds ]
ping 1.1.1.1 -n 1 -w 5000 >NUL


ECHO [ Adding war to repository ]
copy /Y /D /B c:%DEPLOYLOC%\csa.war %REMOTEDRIVE%\csa.war
IF ERRORLEVEL 1 (
	SET ERROR=error5
	goto restart
)


ECHO [ Checking for existing webapp folder ]
if exist "%REMOTEDRIVE%%WEBAPPFOLDER%" goto remove
ECHO Webapp folder does not exist! Ok to restart Tomcat...
goto restart

:remove
ECHO [ Removing %WEBAPPFOLDER% ]
rd /s /q %REMOTEDRIVE%%WEBAPPFOLDER%
IF ERRORLEVEL 1 (
	SET ERROR=error6
	goto restart
)




:restart
ECHO [ Restarting service ]
netsvc %REMOTESERVICE% \\%REMOTESERVER%.csaweb.local  /start
IF ERRORLEVEL 1 ECHO WARNING!!! Action behaved differently than expected.
goto deldrive



:deldrive
ECHO [ Deleting Mapped Drive ]
net use %REMOTEDRIVE% /DELETE
IF ERRORLEVEL 1 ECHO WARNING!!! Action behaved differently than expected.
IF (%ERROR%)==() (
	goto end
) ELSE (
	goto %ERROR%
)







REM -----ERRORS-----
:error1
ECHO ERROR: You must specify a servername as x in xxxx.csaweb.local.  Deploy Failed.
pause
exit 1

:error2
ECHO ERROR: Unable to map drive to remote server.  Cancelling deploy.
SET ERROR=error4
pause
goto deldrive

:error3
ECHO ERROR: Unable to backup old war.
pause
exit 3

:error4
ECHO ERROR: Service doesnt exist.
pause
exit 4

:error5
ECHO ERROR: Unable to copy up new war.
pause
exit 5

:error6
ECHO ERROR: Unable to delete old webapp directory.
pause
exit 6



:end