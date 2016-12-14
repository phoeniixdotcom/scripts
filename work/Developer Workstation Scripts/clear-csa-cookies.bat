ECHO off
REM MXS
REM This file will delete cookies from browsers on the system
REM

SET /P ACCOUNT=Enter the name of your User Account in Documents and Settings:


ECHO [Deleting IE Cookies]
cd c:\documents*
cd %ACCOUNT%\cookies
del *csa*.*


ECHO [Delete Firefox Cookies]
cd C:\Documents*
cd %ACCOUNT%\Application Data\Mozilla\Firefox
del /S cookies.txt


pause