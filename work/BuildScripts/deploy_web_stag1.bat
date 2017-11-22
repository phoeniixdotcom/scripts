@ECHO OFF
REM MXS
REM Deploy war to the nightly server
REM Needs to deploy to testing server
REM Requires netsvc from the Server Tools CD
REM INPUT:
REM %1 is the path of war file
REM %2 is the name of the war
REM %3 is the wildcard name of the war for deleting any existing version already deployed

ECHO -------------------------------------------------------------------------------
ECHO  CSA Build Deployer for WEB
ECHO  -This script will deploy the latest war to the specified server.
ECHO  use: deploy_web file.war
ECHO -------------------------------------------------------------------------------
ECHO

REM -----Set variables-----
SET LEVEL=0
SET REMOTEDRIVE=y:


IF (%1)==() (goto error2) ELSE (SET BUILDDIR=%1)
ECHO [BUILD DIR: %BUILDDIR%]

IF (%2)==() (goto error2) ELSE (SET BUILDFILE=%2)
ECHO [BUILD FILE: %BUILDFILE%]

IF (%3)==() (goto checkservers) ELSE (SET WILDCARDFILE=%3)
ECHO [WILCARD FILE: %WILDCARDFILE%]

:checkservers
FOR /F "tokens=*" %%G IN ('type c:\BuildScripts\webservers_stag1.txt') DO (call :s_do_sums %%G)
GOTO :EOF

:s_do_sums
SET HOST=%1
ECHO [Deploying on %HOST%]

REM ---- Stopping JBoss service -----
"c:\BuildScripts\psservice.exe" \\%HOST% -u csaweb\tca -p Monday01 stop JBAS72FIN
IF ERRORLEVEL 1 goto error7


ECHO [ Map network drive to deploy server ]
net use %REMOTEDRIVE% \\%HOST%\c$\jboss-as-7.2.0.Final\standalone\deployments /USER:csaweb\scr Monday01
IF ERRORLEVEL 1 goto error9

REM ---- Delete all files meeting wildcard parameter like web-xxxxx*.war ---
ECHO [ Delete files from %REMOTEDRIVE%\%WILDCARDFILE% ]
IF (%WILDCARDFILE%)==() (goto copyfile) ELSE del %REMOTEDRIVE%\%WILDCARDFILE%
IF ERRORLEVEL 2 goto error11

:copyfile
ECHO [ Copying files to %1 ]
copy /Y /D /B %BUILDDIR%\%BUILDFILE% %REMOTEDRIVE%
IF ERRORLEVEL 2 goto error5

:deldrive
ECHO [ Deleting Mapped Drive ]
net use %REMOTEDRIVE% /DELETE
IF ERRORLEVEL 1 goto error10


REM ---- Starting JBoss service -----
"c:\BuildScripts\psservice.exe" \\%HOST% -u csaweb\tca -p Monday01 start JBAS72FIN
IF ERRORLEVEL 1 goto error8


SET /a waitCount=0

:wait_for_server_start
SET TEMPFILE="c:\BuildScripts\answer%3%.txt"
REM remove the server check file
IF EXIST %TEMPFILE% del %TEMPFILE%

REM Call server check to see if server is available
SET CHECK=http://%HOST%:8100/jsp/CheckAppServer.jsp
ECHO %CHECK%
"C:\Program Files\Tools\curl" %CHECK% > %TEMPFILE%

REM Check contents of file created by server check
set content=
for /f "delims=" %%i in ('type %TEMPFILE%') do (
	set content=%content% %%i
)
set content=%content: =%
ECHO "%content%"

REM if the response is not OK, repeat
if "%content%"=="ok" (
	REM IF EXIST %TEMPFILE% del %TEMPFILE%
	GOTO EOF
) else (
	if %waitCount% gtr 100 goto EOF
	ECHO waiting for server for 10 seconds, iteration %waitCount%
	ping -n 11 127.0.0.1 > nul
	SET /a waitCount = %waitCount% + 1
	goto :wait_for_server_start
)



goto EOF



REM -----ERRORS-----
:error1
SET LEVEL=1
ECHO ERROR: You must specify a servername as x in xxxx.travelsecure.local.
goto exit

:error2
ECHO ERROR: You must specify a script to run.
SET LEVEL=2
goto deldrive

:error5
ECHO ERROR: Unable to copy files.
SET LEVEL=5
goto deldrive

:error7
ECHO ERROR: Unable to stop JBoss.
SET LEVEL=7
goto deldrive

:error8
ECHO Error: Unable to start JBoss.
SET LEVEL=8
goto deldrive

:error9
ECHO ERROR: Unable to map drive to remote server.
SET LEVEL=9
goto deldrive

:error10
ECHO Error: Problem deleting remote drive.
SET LEVEL=10
goto exit

:error11
ECHO Error: Problem deleting the wildcard.
SET LEVEL=11
goto exit


:exit
ECHO %LEVEL%
REM pause
EXIT %LEVEL%

:EOF
