@ECHO OFF
REM MXS
REM To be called by Scheduled Task Nightly
REM Needs to get latest
REM Needs to build war file



ECHO [ Set Vars ]
SET ANTDIR=c:\eclipse\plugins\org.apache.ant_1.6.5\bin
SET BUILDDIR=c:\jakarta-tomcat-5.5.12\webapps\csa\WEB-INF



ECHO [ Determine Action ]
IF (%1)==() (
    goto BUILDWAR
)
IF (%1)==(vssgetcsa) (
    goto GETLATEST
) ELSE (
    goto ERROR1
)
ECHO.



:GETLATEST
ECHO [ Run ant to switch db, and get latest ]
call %ANTDIR%\ant.bat -f "%BUILDDIR%\csabuild.xml" %1
ECHO.



:BUILDWAR
ECHO [ Run ant to build the war ]
call %ANTDIR%\ant.bat -f "%BUILDDIR%\csabuild.xml" clean
ECHO.



:MAILSTATUS
ECHO [ Run ant to send email of status ]
REM ant emailer
REM ant -logger org.apache.tools.ant.listener.MailLogger
ECHO.
GOTO EXIT



:ERROR1
ECHO Please specify a correct build action... (ie "c:\scripts\antBuild.bat vssgetdev")
GOTO EXIT



:EXIT