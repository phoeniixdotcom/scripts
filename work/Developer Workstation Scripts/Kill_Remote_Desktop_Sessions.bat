:: This file helps automate the process of killing rd sessions on servers
:: Requirements: 2000 Server or XP
:: Author: MXS
:: Date: 11/30/05
@echo OFF
SET DOMAINNAME=travelsecure
:START 

if NOT "%DOMAINNAME%" EQU "" GOTO TOPMENU
:DOMAIN
SET /p DOMAINNAME=IN WHAT DOMAIN? (xxxxxx.local):

:TOPMENU
CLS
echo =================================
echo CSA Remote Desktop session killer
echo =================================
echo.
 
echo Current domain: %DOMAINNAME%.local
echo.
SET /p ACTIONABBR=WHAT TO DO? - [Q]uery, [D]elete, [E]xit or [C]hange Domain:
echo.
if "%ACTIONABBR%" EQU "E" GOTO END
if "%ACTIONABBR%" EQU "e" GOTO END
if "%ACTIONABBR%" EQU "Q" GOTO QUERY
if "%ACTIONABBR%" EQU "q" GOTO QUERY
if "%ACTIONABBR%" EQU "D" GOTO DELETE
if "%ACTIONABBR%" EQU "d" GOTO DELETE
if "%ACTIONABBR%" EQU "C" GOTO DOMAIN
if "%ACTIONABBR%" EQU "c" GOTO DOMAIN
echo Invalid action!  Please select a valid action [Q][D][E][C].
pause
GOTO START
 

:QUERY
echo [Listing sessions]
SET /p SERVERNAME=WHAT IS THE SERVERNAME? (XXXX.%DOMAINNAME%.local):
echo Login example: domain\username
net use \\%SERVERNAME%.%DOMAINNAME%.local
echo.
qwinsta /server:%SERVERNAME%.%DOMAINNAME%.local 
pause 
GOTO START
 

:DELETE
echo [Remove session number]
SET /p SERVERNAME=WHAT IS THE SERVERNAME? (XXXX.%DOMAINNAME%.local):
echo Login example: domain\username
net use \\%SERVERNAME%.%DOMAINNAME%.local
echo.
SET /p SESSIONNUMBER=WHAT IS THE SESSION NUMBER YOU WISH TO DELETE?:
echo.
echo [Removing session %SESSIONNUMBER%]
rwinsta /server:%SERVERNAME%.%DOMAINNAME%.local %SESSIONNUMBER% 
pause 
GOTO START
 

:END
 
