@ECHO OFF
REM MXS
REM USAGE deployJar <servername>
REM DESCRIPTION This file is designed to deploy a jar file if found in 
REM c:\todeploy to the specified server



ECHO CSA JAR FILE DEPLOYER
ECHO.



IF NOT (%1)==() (
ECHO [ Deleting insurance package ]
	jagtool -host %1 -port 9000 -user jagadmin -password *** -logfile c:\todeploy\jagtoollogdel.txt remove Package:insurance Server:Jaguar
ECHO [ Installing insurance package ]
	jagtool -host %1 -port 9000 -user jagadmin -password *** -logfile c:\todeploy\jagtoollogins.txt deploy -type jagjar -jagjartype Package -install true -overwrite true c:\todeploy\insurance.jar
ECHO [ Refreshing Jaguar server ]
	jagtool -host %1 -port 9000 -user jagadmin -password *** -logfile c:\todeploy\jagtoollogref.txt refresh Server:Jaguar
) ELSE (
ECHO This tool requires you to specify a servername to deploy to.
)
IF ERRORLEVEL 0 (ECHO True)
IF ERRORLEVEL 1 (ECHO False)
IF ERRORLEVEL 2 (ECHO Exception)



:EXIT
