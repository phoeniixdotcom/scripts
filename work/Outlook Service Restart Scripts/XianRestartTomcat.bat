REM restart tomcat on xian

netsvc "Apache Tomcat" \\xian.csaweb.local /stop
netsvc "Apache Tomcat" \\xian.csaweb.local /start