@ECHO OFF
REM MXS


ECHO This file will restart Tomcat and Jaguar on the specified server.
ECHO You will need the file netsvc.exe in your path to execute.


set /p server=Please enter the servername (XXXX.csaweb.local):


netsvc "Apache Tomcat" \\%server%.csaweb.local /stop
netsvc "Apache Tomcat" \\%server%.csaweb.local  /start


netsvc "Jaguar" \\%server%.csaweb.local /stop
netsvc "Jaguar" \\%server%.csaweb.local  /start


pause