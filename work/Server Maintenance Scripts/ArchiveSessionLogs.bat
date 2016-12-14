@echo off
REM Created by MXS 01-31-2005 - updated 02-13-06 zig
REM This bat requires the Winzip command line tool wzzip.exe
REM Td0 means dont archive anything newer than 1 days


REM ===== Archive the Tomcat logs =====

REM ===== Set Variables =====
SET WINZIPLOC="c:\program files\winzip\wzzip.exe"
SET SESSIONLOC="e:\logs\session\"

REM ===== Get Date =====
@echo off

for /F "tokens=2-4 delims=/ " %%f in ('date /t') do (
 set mm=%%f
 set dd=%%g
 set yyyy=%%h
)

set CurDate=%mm%/%dd%/%yyyy%

REM Substract your days here
set /A dd=1%dd% - 100 - %1
set /A mm=1%mm% - 100

:CHKDAY

if /I %dd% GTR 0 goto DONE

set /A mm=%mm% - 1

if /I %mm% GTR 0 goto ADJUSTDAY

set /A mm=12
set /A yyyy=%yyyy% - 1

:ADJUSTDAY

if %mm%==1 goto SET31
if %mm%==2 goto LEAPCHK
if %mm%==3 goto SET31
if %mm%==4 goto SET30
if %mm%==5 goto SET31
if %mm%==6 goto SET30
if %mm%==7 goto SET31
if %mm%==8 goto SET31
if %mm%==9 goto SET30
if %mm%==10 goto SET31
if %mm%==11 goto SET30
REM ** Month 12 falls through

:SET31

set /A dd=31 + %dd%

goto CHKDAY

:SET30

set /A dd=30 + %dd%

goto CHKDAY

:LEAPCHK

set /A tt=%yyyy% %% 4

if not %tt%==0 goto SET28

set /A tt=%yyyy% %% 100

if not %tt%==0 goto SET29

set /A tt=%yyyy% %% 400

if %tt%==0 goto SET29

:SET28

set /A dd=28 + %dd%

goto CHKDAY

:SET29

set /A dd=29 + %dd%

goto CHKDAY

:DONE

echo Date %1 days before %CurDate% is %mm%/%dd%/%yyyy%

Call this routine with a 1 and it will subtract 1 day from the current date. The components will be available in %yyyy%, %mm%, and %dd%. You can remove the echo statement. 

REM ===== Archive Files =====
%WINZIPLOC% -m -Td0 %SESSIONLOC%%MM%%DD%%YYYY%.zip %SESSIONLOC%*.log

PAUSE