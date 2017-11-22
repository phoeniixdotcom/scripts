@echo off
REM Makes a backup of the development directory on your machine
REM Created by MXS 01-31-2005
REM 



ECHO [ Set Variables ]
SET TOMCATWEBAPPFOLDER="c:\devel\intellij"
SET TOMCATBACKUPFOLDER="%TOMCATWEBAPPFOLDER%\backup"
SET /P BACKUPDIR=Specify the name of the webapp folder to backup (ie CSA):
SET /P RENAMEDIR=Specify a name to backup the CSA directory too:



ECHO [ Checking for existing folder ]
if exist "%TOMCATBACKUPFOLDER%\%BACKUPDIR%" goto backup
echo File does not exist! Please check the files location...
goto end



:backup
ECHO [ Backing up %ORIGINALFILENAME% ]
copy "%TOMCATWEBAPPFOLDER%\%BACKUPDIR%" "%TOMCATBACKUPFOLDER%\%RENAMEDIR%"
ECHO Finished...



:end
pause