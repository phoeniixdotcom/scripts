@ECHO OFF
REM This script will launch all CSA websites by subdomain in the browser you choose.
REM Author mxs

REM FOR /F "tokens=*" %%G IN ('type c:\BuildScripts\soaqaservers.txt') DO (call :s_do_sums %%G)
SET DOMAINS=csatravelprotection.com csatravelpro.com vacationrentalinsurance.com propertydamageprotection.com vacationprotection.com youtravelweprotect.com defendyourid.com

SET FFLOC="c:\Program Files (x86)\Mozilla Firefox" firefox.exe
SET CHLOC="%HOMEPATH%\AppData\Local\Google\Chrome\Application" chrome.exe
SET SALOC="c:\Program Files (x86)\Safari" Safari.exe
SET OPLOC="c:\Program Files (x86)\Opera" Opera.exe
SET IELOC="c:\Program Files (x86)\Internet Explorer" iexplore.exe

ECHO ============================
ECHO = Launch all CSA websites. =
ECHO ============================
REM ECHO Current Browser: %SELECTEDBROWSER%
ECHO.

:SELECTBROWSER
SET /p SELECTEDBROWSER=1. SELECT A BROWSER? - [F]irefox, [C]hrome, [S]afari, [O]pera, [I]E, or [Q]uit:

if "%SELECTEDBROWSER%" EQU "F" GOTO FIREFOX
if "%SELECTEDBROWSER%" EQU "f" GOTO FIREFOX
if "%SELECTEDBROWSER%" EQU "C" GOTO CHROME
if "%SELECTEDBROWSER%" EQU "c" GOTO CHROME
if "%SELECTEDBROWSER%" EQU "S" GOTO SAFARI
if "%SELECTEDBROWSER%" EQU "s" GOTO SAFARI
if "%SELECTEDBROWSER%" EQU "O" GOTO OPERA
if "%SELECTEDBROWSER%" EQU "o" GOTO OPERA
if "%SELECTEDBROWSER%" EQU "I" GOTO IE
if "%SELECTEDBROWSER%" EQU "i" GOTO IE
if "%SELECTEDBROWSER%" EQU "Q" GOTO EOF
if "%SELECTEDBROWSER%" EQU "q" GOTO EOF
ECHO Please enter F, C, S, O, I, or Q...
GOTO SELECTBROWSER


:FIREFOX
SET RUNNABLE=%FFLOC%
SET BROWSER=Firefox
GOTO SELECTSUBDOMAIN
:CHROME
SET RUNNABLE=%CHLOC%
SET BROWSER=Chrome
GOTO SELECTSUBDOMAIN
:SAFARI
SET RUNNABLE=%SALOC%
SET BROWSER=Safari
GOTO SELECTSUBDOMAIN
:OPERA
SET RUNNABLE=%OPLOC%
SET BROWSER=Opera
GOTO SELECTSUBDOMAIN
:IE
SET RUNNABLE=%IELOC%
SET BROWSER=Internet Explorer
GOTO SELECTSUBDOMAIN


:SELECTSUBDOMAIN
SET /p SELECTEDSUBDOMAIN=2. ENTER A SUBDOMAIN? - [W]ww, [S]taging, web[Q]a, web[B]eta, or [O]ther:

if "%SELECTEDSUBDOMAIN%" EQU "W" GOTO WWW
if "%SELECTEDSUBDOMAIN%" EQU "w" GOTO WWW
if "%SELECTEDSUBDOMAIN%" EQU "S" GOTO STAGING
if "%SELECTEDSUBDOMAIN%" EQU "s" GOTO STAGING
if "%SELECTEDSUBDOMAIN%" EQU "Q" GOTO WEBQA
if "%SELECTEDSUBDOMAIN%" EQU "q" GOTO WEBQA
if "%SELECTEDSUBDOMAIN%" EQU "B" GOTO WEBBETA
if "%SELECTEDSUBDOMAIN%" EQU "b" GOTO WEBBETA
if "%SELECTEDSUBDOMAIN%" EQU "O" GOTO OTHER
if "%SELECTEDSUBDOMAIN%" EQU "o" GOTO OTHER
ECHO Please enter W, S, Q, B, or O...
GOTO SELECTSUBDOMAIN


:WWW
SET SUBDOMAIN=www.
GOTO LAUNCHWEBSITES
:STAGING
SET SUBDOMAIN=staging.
GOTO LAUNCHWEBSITES
:WEBQA
SET SUBDOMAIN=webqa.
GOTO LAUNCHWEBSITES
:WEBBETA
SET SUBDOMAIN=webbeta.
GOTO LAUNCHWEBSITES
:OTHER
SET /p SUBDOMAIN=2a. ENTER A CUSTOM SUBDOMAIN:
GOTO LAUNCHWEBSITES


:LAUNCHWEBSITES
FOR %%G IN (%DOMAINS%) DO (
	ECHO Opening... http://%SUBDOMAIN%%%G in %BROWSER%
	start /B /D%RUNNABLE% http://%SUBDOMAIN%%%G
)


:EOF
ECHO Exiting...
pause
exit