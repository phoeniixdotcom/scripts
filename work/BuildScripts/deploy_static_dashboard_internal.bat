@ECHO OFF

ECHO -------------------------------------------------------------------------
ECHO - MXS                                                                   -
ECHO - CSA Build Deployer for Internal Dashboard site                        -
ECHO - This script will deploy the latest war to the specified server.       -
ECHO - use: deploy_static_dashboard_internal folder                          -
ECHO - percent1 is the folder to deploy to                                   -
ECHO -------------------------------------------------------------------------
ECHO.


REM -----Set variables-----
SET LEVEL=0
SET REMOTEDRIVE=t:
SET REMOTESERVER=zealand.travelsecure.local
SET SOURCEFILES=.\

IF (%1)==() (
    goto error1
) ELSE (
    SET ENVIRONMENT=%1
)





ECHO [ Deploy static site to each remote server ]
FOR %%A IN (%REMOTESERVER%) DO (
	ECHO [ Map network drive to deploy server %%A ]
	net use %REMOTEDRIVE% \\%%A\%ENVIRONMENT% /USER:travelsecure\tca Monday01

	ECHO [ Copying files to %%A ]
	REM copy /Y /D /B *.* %REMOTEDRIVE%\*.*
	robocopy %SOURCEFILES% %REMOTEDRIVE% /MIR /XD .svn
	IF ERRORLEVEL 2 goto error5

	ECHO [ Deleting Mapped Drive ]
	net use %REMOTEDRIVE% /DELETE
	IF ERRORLEVEL 1 goto error10	
)
IF ERRORLEVEL 0 goto :exit




REM -----ERRORS-----
:error1
SET LEVEL=1
ECHO ERROR: You must specify a servername as x in xxxx.csaweb.local.
goto exit

:error2
ECHO ERROR: Unable to map drive to remote server.
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
ECHO Error: Problem deleting remote drive.
SET LEVEL=10
goto exit





:deldrive
ECHO [ Deleting Mapped Drive ]
net use %REMOTEDRIVE% /DELETE
IF ERRORLEVEL 1 goto error10
goto exit





:exit
REM pause
REM ECHO %LEVEL%
EXIT %LEVEL%