ECHO off
REM MXS
REM This script is designed to loop through the list of servers and create shares to 
REM their network drives to copy files that need to be replicated to all servers.  Copies 
REM are separated by pause statements.  An Explorer window will open for one server at a time
REM allowing you do do your copy, then it will be closed and another window will be opened.
REM

cls
ECHO CSA "establish remote smb connections" script
ECHO .
SET /P USERNAME=Enter your username (domain\user):
SET /P PASSWORD=Enter your password:

REM set variables
SET DRIVETOMAP=Z:
SET SERVERLIST=soaprod001 soaprod002.csaweb.local soaprod003 soaprod004 soaprod010 soaprod011 jagprod001 jagprod002 jagprod003 jagprod004

FOR %%S IN (%SERVERLIST%) DO (
	ECHO [Mapping %%S/c$]
	ECHO .
	ECHO ON
	net use %DRIVETOMAP% \\%%S\c$ /USER:%USERNAME% "%PASSWORD%" /PERSISTENT:no
	ECHO OFF

	REM ECHO [open mapped drive in explorer]
	REM call explorer %DRIVETOMAP%
	REM pause

	ECHO [Unmap drive %DRIVETOMAP%]
	net use %DRIVETOMAP% /delete /y
)

pause
:exit