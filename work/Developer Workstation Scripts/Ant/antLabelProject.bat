@ECHO OFF
REM MXS
REM Label current project in VSS
REM Needs to get latest
REM Needs to build war file



ECHO [ Set Vars ]
SET ANTDIR=C:\eclipse\plugins\org.apache.ant_1.6.5\bin
SET BUILDDIR=c:\jakarta-tomcat-5.5.12\webapps\csa\WEB-INF
IF NOT EXIST %1 (
    goto :EXIT
) ELSE IF [%1]=="vssgetdev" (
    goto :GETLATEST
)
ECHO.
pause



:GETLATEST
ECHO [ Run ant to label latest build as "%1" ]
rem call %ANTDIR%\ant.bat -f "%BUILDDIR%\csabuild.xml" -Dproject.version=%1 vsslabelproject
ECHO.
pause



:EXIT