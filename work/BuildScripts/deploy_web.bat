@ECHO OFF
REM MXS


ECHO.
ECHO ------------------------------------------------------------------
ECHO CSA Build Pre-Deployer for JBoss
ECHO.
ECHO This script will copy the indicated war to the specified server.
ECHO.
ECHO INPUT:
ECHO Param 1 is the war to be copied
ECHO Param 2 is the servername
ECHO Param 3 is the login name with domain
ECHO Param 4 is the login password
ECHO ------------------------------------------------------------------
ECHO.


REM ----- Set parameters -----
IF (%1)==() (goto error1) ELSE (SET WARLOCATION=%1)
IF (%2)==() (goto error2) ELSE (SET REMOTESERVER=%2)
IF (%3)==() (goto error3) ELSE (SET USERNAME=%3)
IF (%4)==() (goto error4) ELSE (SET PASSWORD=%4)


REM -----Set variables-----
SET REMOTEDRIVE=Z:
SET DEPLOYDIR=deploy
SET LEVEL=0


REM ----- Set date -----
for /f "tokens=1,2,3,4* delims=/ " %%i in ('date /T') do set T=%%i&set M=%%j&set D=%%k&set YY=%%l
SET Y=%YY:~-2%


REM ---- Stopping JBoss service -----
"c:\BuildScripts\psservice.exe" \\%REMOTESERVER% -u %USERNAME% -p %PASSWORD% stop JBAS50SVC
IF ERRORLEVEL 1 goto error5


ECHO [ Map network drive to deploy server ]
@ECHO ON
net use %REMOTEDRIVE% \\%REMOTESERVER%\c$ /USER:%USERNAME% "%PASSWORD%"
@ECHO OFF
IF ERRORLEVEL 1 goto error7


ECHO [ Backup existing war ]
if exist %REMOTEDRIVE%\jboss-5.1.0.GA\server\csa\%DEPLOYDIR%\ROOT.war (
	ECHO [ Backing up war... ]
	@ECHO ON
	copy /Y /D %REMOTEDRIVE%\jboss-5.1.0.GA\server\csa\%DEPLOYDIR%\ROOT.war /B %REMOTEDRIVE%\jboss-5.1.0.GA\server\csa\%DEPLOYDIR%\backup\ROOT%Y%%M%%D%.war.bak /B
	@ECHO OFF
	IF ERRORLEVEL 1 goto error8
)


ECHO [ Adding war to server ]
@ECHO ON
copy /Y /D %WARLOCATION% /B %REMOTEDRIVE%\jboss-5.1.0.GA\server\csa\%DEPLOYDIR%\ROOT.war /B
@ECHO OFF
IF ERRORLEVEL 1 goto error9


:deldrive
ECHO [ Deleting Mapped Drive ]
@ECHO ON
net use %REMOTEDRIVE% /DELETE
@ECHO OFF
IF ERRORLEVEL 1 goto error10


REM ---- Starting JBoss service -----
"c:\BuildScripts\psservice.exe" \\%REMOTESERVER% -u %USERNAME% -p %PASSWORD% start JBAS50SVC
IF ERRORLEVEL 1 goto error6


goto exit


REM -----ERRORS-----
:error1
ECHO ERROR: You must specify the location of the source war.
SET LEVEL=1
goto exit

:error2
ECHO ERROR: You must specify the fully qualified servername to copy to.
SET LEVEL=2
goto exit

:error3
ECHO ERROR: You must specify username including domain.
SET LEVEL=3
goto exit

:error4
ECHO ERROR: You must specify a password.
SET LEVEL=4
goto exit

:error5
ECHO ERROR: Unable to stop JBoss Service.
SET LEVEL=5
goto deldrive

:error6
ECHO ERROR: Unable to start JBoss Service.
SET LEVEL=6
goto deldrive

:error7
ECHO ERROR: Unable to map drive to remote server.
SET LEVEL=7
goto deldrive

:error8
ECHO ERROR: Unable to backup old war.
SET LEVEL=8
goto deldrive

:error9
ECHO ERROR: Unable to copy up new war.
SET LEVEL=9
goto deldrive

:error10
ECHO Error: Problem deleting remote drive.
SET LEVEL=10
goto exit



:exit
ECHO Exit Level: %LEVEL%
REM pause
exit %LEVEL%