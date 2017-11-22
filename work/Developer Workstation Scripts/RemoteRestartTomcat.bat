@ECHO OFF
REM MXS


ECHO This file will restart Tomcat and Jaguar on the specified server.
ECHO You will need the file netsvc.exe in your path to execute.


set /p server=Please enter the servername (XXXX.csaweb.local):


netsvc "Apache Tomcat" \\%server%.csaweb.local /stop

ECHO [----- Set a timeout of 5 seconds -----]
ping 1.1.1.1 -n 1 -w 10000 >NUL

netsvc "Apache Tomcat" \\%server%.csaweb.local  /start

pause