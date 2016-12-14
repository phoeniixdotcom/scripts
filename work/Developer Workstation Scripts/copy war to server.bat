ECHO off
REM MXS
REM This file creates a network drive and copies the generated war file to the server
REM

cls
ECHO CSA War deployment script
ECHO Important!!! Ensure your war file has been created before deploying!


REM set variables
SET DRIVETOMAP=p
SET /P SERVER=ENTER SERVER NAME (XXXX.CSAWEB.LOCAL):
SET REMOTESERVER=%SERVER%.csaweb.local
SET LOCALTOM=c:\jakarta-tomcat-5.5.12\webapps
SET REMOTETOM=c:\jakarta-tomcat-5.5.12\webapps


REM backup file
ECHO
ECHO [map drive]
	ECHO %REMOTESERVER%
	net use %DRIVETOMAP%: \\%REMOTESERVER%\%REMOTETOM% /USER:csaweb\administrator 02tuf@weBB

ECHO [backup old war]
	for /f "tokens=1,2,3,4* delims=/ " %%i in ('date /T') do set T=%%i&set M=%%j&set D=%%k&set Y=%%l
	copy /Y %DRIVETOMAP%:\csa.war %DRIVETOMAP%:\backup\csa%M%%D%%Y%.war

ECHO [copy up the new war]
	copy /Y %LOCALTOM%\csa.war %DRIVETOMAP%:\csa.war

ECHO [unmap drive]
	net use %DRIVETOMAP%: /delete


pause