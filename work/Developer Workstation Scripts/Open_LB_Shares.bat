REM ECHO OFF
REM This script opens explorer windows for the load balance servers
REM

SET USERNAME=csaweb\administrator
SET PASSWORD=

FOR %%S IN (\\greenland.csaweb.local\c$ \\glasgow.csaweb.local\c$ \\grenada.csaweb.local\c$) DO (
	DIR %%S
	if errorlevel 1 (
		CMD /C net use %%S /USER:%USERNAME% %PASSWORD%
	)
	explorer %%S
)

REM pause
