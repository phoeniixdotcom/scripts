@echo off
REM Created by MXS 01-17-2005
REM This file makes a back up of the Jaguar server log using the current date

REM ===== Set Variables =====
SET servicename=Jaguar
SET drive=c:\
SET originaldir=%drive%\logs\jaguar\
SET archivedir=%drive%\logs\jaguar\
SET originalfilename=srv.log
SET finalprefix=srv
SET finalsuffix=.log

REM ===== Stop Service =====
net stop %servicename%

REM ===== Create renamed output =====
for /f "tokens=1,2,3,4* delims=/ " %%i in ('date /T') do set T=%%i&set M=%%j&set D=%%k&set Y=%%l
SET finalfilename=%finalprefix% %M%%D%%Y%%finalsuffix%
SET archivesubdir=%archivedir%\%Y%\%M%

REM ===== Create Directory =====
if exist %jaglogarcdir%\%Y%\%M% goto backup
echo Directory doesn't exist. Creating subfolder %Y%\%M%\ ...
mkdir %archivesubdir%
goto backup

REM ===== Backup the file =====
:backup
echo Backing up Jaguar log file...
move /Y "%originaldir%\%originalfilename%" "%archivesubdir%\%finalfilename%"
pause

REM ===== Start Service =====
net start %servicename%

:end

