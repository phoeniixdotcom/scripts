@ECHO OFF
REM MXS
REM Deploy war to the nightly server
REM Needs to deploy to testing server
REM Requires netsvc from the Server Tools CD




ECHO [ Run set of scripts to deploy to nightly server ]
SET REMOTESERVICE="Jakarta Tomcat 5"
SET REMOTESERVER=cayman
SET REMOTEDRIVE=U:
SET TOMCATLOC=\jakarta-tomcat-5.5.12\webapps
SET WEBAPPFOLDER=\csa\


ECHO [ Map network drive to nightly server ]
net use %REMOTEDRIVE% \\%REMOTESERVER%.csaweb.local\c$%TOMCATLOC%


ECHO [ Checking for existing war ]
if exist "%TOMCATLOC%%WEBAPPFOLDER%" goto backup
copy -Y "c:\jakarta-tomcat-5.5.12\webapps\csa.war" %REMOTEDRIVE%%TOMCATLOC%


ECHO [ Stopping service ]
netsvc %REMOTESERVICE% \\%REMOTESERVER%.csaweb.local /stop


ECHO [ Set a timeout of 5 seconds ]
ping 1.1.1.1 -n 1 -w 5000 >NUL


ECHO [ Checking for existing webapp folder ]
if exist "%TOMCATLOC%%WEBAPPFOLDER%" goto backup
ECHO Webapp folder does not exist! Restarting Tomcat...
goto restart


:backup
ECHO [ Removing %WEBAPPFOLDER% ]
rd /s /q "%TOMCATLOC%%WEBAPPFOLDER%"


:restart
ECHO [ Restarting service ]
netsvc %REMOTESERVICE% \\%REMOTESERVER%.csaweb.local  /start
