ECHO OFF
REM This file will open all the sites for testing during a build

REM ===== SET VARIABLES =====
REM Leave this blank
SET BROWSERCHOSEN=
SET BROWSERMOZILLA=C:\Program Files\Mozilla Firefox\firefox.exe
SET BROWSERIE=C:\Progra~1\Intern~1\IEXPLORE.EXE
rem SET BROWSERIE=C:\Program Files\Internet Explorer\IEXPLORE.EXE
SET USERDIR=mxs

ECHO ======================
ECHO = CSA Website Tester =
ECHO ======================
ECHO.

REM ===== DELETE COOKIES =====
ECHO Deleting IE Cookies
cd c:\documents*
cd %USERDIR%\cookies
del *csa*.*

ECHO Deleting Firefox Cookies
cd C:\Documents*
cd %USERDIR%\Application Data\Mozilla\Firefox
del /S cookies.txt

ECHO.



REM ===== GET USER INPUT =====
SET /P BROWSER=Please select a browser - (F)irefox, (I)nternet Explorer, E(x)it:
if "%BROWSER%" EQU "F" SET BROWSERCHOSEN=%BROWSERMOZILLA%
if "%BROWSER%" EQU "f" SET BROWSERCHOSEN=%BROWSERMOZILLA%
if "%BROWSER%" EQU "I" SET BROWSERCHOSEN=%BROWSERIE%
if "%BROWSER%" EQU "i" SET BROWSERCHOSEN=%BROWSERIE%
if "%BROWSER%" EQU "X" GOTO END
if "%BROWSER%" EQU "x" GOTO END

ECHO Please make sure an instance of Firefox is open
pause

ECHO.

SET /P SERVER=Please select a server - (R)eno, (P)hoenix, (S)taging, E(x)it:
if "%SERVER%" EQU "R" GOTO RENO
if "%SERVER%" EQU "r" GOTO RENO
if "%SERVER%" EQU "P" GOTO PHOENIX
if "%SERVER%" EQU "p" GOTO PHOENIX
if "%SERVER%" EQU "S" GOTO STAGING
if "%SERVER%" EQU "s" GOTO STAGING
if "%SERVER%" EQU "X" GOTO END
if "%SERVER%" EQU "x" GOTO END
GOTO END

ECHO.



REM ===== LOAD PAGES =====
:RENO
ECHO Testing Product Pages - (Reno)
"%BROWSERCHOSEN%" "https://www.csatravelprotection.com/csa/preparequote.do"
"%BROWSERCHOSEN%" "https://www.csavg40.com/csa/preparequote.do"
"%BROWSERCHOSEN%" "https://www.globalcare-cocco.com/csa/preparequote.do"
"%BROWSERCHOSEN%" "https://www.csatravelprotection.com/csa/jsp/index.jsp?aff=advantag"

"%BROWSERCHOSEN%" "http://www.csatravelprotection.com/csa/jsp/index.jsp?aff=cruise1"
"%BROWSERCHOSEN%" "http://www.csatravelprotection.com/csa/jsp/index.jsp?aff=cruisesn"
"%BROWSERCHOSEN%" "http://www.csatravelprotection.com/csa/jsp/index.jsp?aff=greatamt"
"%BROWSERCHOSEN%" "http://www.csatravelprotection.com/csa/jsp/index.jsp?aff=goodsamc"
GOTO END

:PHOENIX
ECHO Testing Product Pages - (Phoenix)
"%BROWSERCHOSEN%" "https://www2.csatravelprotection.com/csa/preparequote.do"
"%BROWSERCHOSEN%" "https://www2.csavg40.com/csa/preparequote.do"
"%BROWSERCHOSEN%" "https://www2.csatravelprotection.com/csa/jsp/index.jsp?aff=advantag"

"%BROWSERCHOSEN%" "http://www2.csatravelprotection.com/csa/jsp/index.jsp?aff=cruise1"
"%BROWSERCHOSEN%" "http://www2.csatravelprotection.com/csa/jsp/index.jsp?aff=cruisesn"
"%BROWSERCHOSEN%" "http://www2.csatravelprotection.com/csa/jsp/index.jsp?aff=greatamt"
"%BROWSERCHOSEN%" "http://www2.csatravelprotection.com/csa/jsp/index.jsp?aff=goodsamc"
GOTO END

:STAGING
ECHO Testing Product Pages - (Staging)
"%BROWSERCHOSEN%" "http://staging.csatravelprotection.com/csa/preparequote.do"
"%BROWSERCHOSEN%" "http://staging.csavg40.com/csa/preparequote.do"
"%BROWSERCHOSEN%" "http://staging.globalcare-cocco.com/csa/preparequote.do"
"%BROWSERCHOSEN%" "http://staging.csatravelprotection.com/csa/jsp/index.jsp?aff=advantag"

"%BROWSERCHOSEN%" "http://staging.csatravelprotection.com/csa/jsp/index.jsp?aff=cruise1"
"%BROWSERCHOSEN%" "http://staging.csatravelprotection.com/csa/jsp/index.jsp?aff=cruisesn"
"%BROWSERCHOSEN%" "http://staging.csatravelprotection.com/csa/jsp/index.jsp?aff=greatamt"
"%BROWSERCHOSEN%" "http://staging.csatravelprotection.com/csa/jsp/index.jsp?aff=goodsamc"
GOTO END



:END
pause