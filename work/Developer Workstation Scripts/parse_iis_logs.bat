@ECHO OFF
REM MXS 09/11/2007
REM This tool will parse an iis log file and output the data like results from a SQL query.
REM It requires Log Parser 2.2.x from Microsoft

REM Set program and log file locations
SET LOGFILE="z:\iis\w3svc1\ex070917.log"
SET PROCESSACTION=start /MIN /D"c:\program files\iis resources\log parser 2.2\" logparser
SET NORMALACTION="c:\program files\iis resources\log parser 2.2\logparser"

REM To search all day, set starthr to 0, endhr to 23
REM IIS log files record time in GMT so add +7 hours to the time you wish to track.
SET STARTHR=14
SET ENDHR=16
SET DELAY=30000


ECHO TEST-use to test script
REM %NORMALACTION% "SELECT TO_STRING(time, 'HH') AS Hour, TO_STRING(time, 'mm') AS Minute, c-ip AS IP, CASE STRCNT(cs-uri-stem,'.gif') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.css') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.pdf') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.js') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.jpg') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.png') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'getrequest') WHEN 1 THEN 'XML' ELSE CASE STRCNT(cs-uri-stem,'getquote') WHEN 1 THEN 'PURCHASE' ELSE CASE STRCNT(cs-uri-stem,'quoteoptions') WHEN 1 THEN 'PURCHASE' ELSE CASE STRCNT(cs-uri-stem,'purchase') WHEN 1 THEN 'PURCHASE' END END END END END END END END END END AS Request_Type, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE (TO_INT(TO_STRING(time, 'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR%) GROUP BY Hour, Minute, IP, Request_Type ORDER BY Hour, Minute, Hits, Request_Type ASC" -i:IISW3C -o:DATAGRID
%NORMALACTION% "SELECT TO_STRING(time, 'HH') AS Hour, TO_STRING(time, 'mm') AS Minute, CASE STRCNT(cs-uri-stem,'getrequest') WHEN 1 THEN 'XML' ELSE CASE STRCNT(cs-uri-stem,'.do') WHEN 1 THEN 'NORMAL' ELSE CASE STRCNT(cs-uri-stem,'.htm') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'validator.jsp') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.xml') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.ico') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.gif') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.css') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.pdf') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.js') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.jpg') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.png') WHEN 1 THEN 'RESOURCE' ELSE CASE STRCNT(cs-uri-stem,'.jsp') WHEN 1 THEN 'XML' ELSE CASE STRCNT(cs-uri-stem,'getquote') WHEN 1 THEN 'PURCHASE' ELSE CASE STRCNT(cs-uri-stem,'quoteoptions') WHEN 1 THEN 'PURCHASE' ELSE CASE STRCNT(cs-uri-stem,'purchase') WHEN 1 THEN 'PURCHASE' ELSE 'OTHER' END END END END END END END END END END END END END END END END AS Request_Type, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE (TO_INT(TO_STRING(time, 'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR%) GROUP BY Hour, Minute, Request_Type ORDER BY Hour ASC, Minute ASC, Hits DESC" -i:IISW3C -o:DATAGRID
REM %NORMALACTION% "SELECT TO_STRING(time, 'HH') AS Hour, TO_STRING(time, 'mm') AS Minute, c-ip AS IP, SUBSTR(cs-uri-stem,0,INDEX_OF(cs-uri-stem,';')) as URI, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE (TO_INT(TO_STRING(time, 'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR%) AND URI = '/jsp/getrequest.jsp' GROUP BY Hour, Minute, IP, URI ORDER BY Hour, Minute, Hits ASC" -i:IISW3C -o:DATAGRID
REM %NORMALACTION% "SELECT TO_STRING(time, 'HH') AS Hour, TO_STRING(time, 'mm') AS Minute, c-ip AS IP, SUBSTR(cs-uri-stem,0,INDEX_OF(cs-uri-stem,';')) as URI, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE (TO_INT(TO_STRING(time, 'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR%) AND URI <> '/jsp/getrequest.jsp' GROUP BY Hour, Minute, IP, URI ORDER BY Hour, Minute, Hits ASC" -i:IISW3C -o:DATAGRID

ECHO CANCEL TEST!!!!!
pause




ECHO ===== OUTPUT TO DATAGRID =====

ECHO Total requests by minute...
%PROCESSACTION% "SELECT TO_STRING(time, 'HH') AS Hour, TO_STRING(time, 'mm') AS Minute, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE TO_INT(TO_STRING(time,'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR% GROUP BY Hour, Minute ORDER BY Hour, Minute ASC" -i:IISW3C -o:DATAGRID
ping 1.1.1.1 -n 1 -w %DELAY% >NUL


ECHO Total requests by minute, grouping by IP...
%PROCESSACTION% "SELECT TO_STRING(time, 'HH') AS Hour, TO_STRING(time, 'mm') AS Minute, c-ip AS IP, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE TO_INT(TO_STRING(time, 'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR% GROUP BY Hour, Minute, IP ORDER BY Hour, Minute, Hits ASC" -i:IISW3C -o:DATAGRID
ping 1.1.1.1 -n 1 -w %DELAY% >NUL


REM ECHO Total requests by minute, grouping by resolved IP...
REM ECHO NOTE REVERSEDNS option takes a while to process!!!
REM %PROCESSACTION% "SELECT TO_STRING(time, 'HH') AS Hour, TO_STRING(time, 'mm') AS Minute, REVERSEDNS(c-ip) AS IP, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE TO_INT(TO_STRING(time, 'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR% GROUP BY Hour, Minute, IP ORDER BY Hour, Minute ASC" -i:IISW3C -o:DATAGRID
REM ping 1.1.1.1 -n 1 -w %DELAY% >NUL


REM ECHO Total requests by minute, grouping by URI...
REM %PROCESSACTION% "SELECT TO_STRING(time, 'HH') AS Hour, TO_STRING(time, 'mm') AS Minute, EXTRACT_PATH(cs-uri-stem) as URI, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE TO_INT(TO_STRING(time, 'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR% GROUP BY Hour, Minute, IP, URI ORDER BY Hour, Minute, Hits ASC" -i:IISW3C -o:DATAGRID
REM ping 1.1.1.1 -n 1 -w %DELAY% >NUL


REM ECHO Total requests by minute, grouping by IP and URI...
REM %PROCESSACTION% "SELECT TO_STRING(time, 'HH') AS Hour, TO_STRING(time, 'mm') AS Minute, c-ip AS IP, EXTRACT_PATH(cs-uri-stem) as URI, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE (TO_INT(TO_STRING(time, 'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR%) GROUP BY Hour, Minute, IP, URI ORDER BY Hour, Minute, Hits ASC" -i:IISW3C -o:DATAGRID
REM ping 1.1.1.1 -n 1 -w %DELAY% >NUL


ECHO Total requests by minute, grouping by IP and non-xml URI...
%PROCESSACTION% "SELECT TO_STRING(time, 'HH') AS Hour, TO_STRING(time, 'mm') AS Minute, c-ip AS IP, SUBSTR(cs-uri-stem,0,INDEX_OF(cs-uri-stem,';')) as URI, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE (TO_INT(TO_STRING(time, 'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR%) AND URI <> '/jsp/getrequest.jsp' GROUP BY Hour, Minute, IP, URI ORDER BY Hour, Minute, Hits ASC" -i:IISW3C -o:DATAGRID
ping 1.1.1.1 -n 1 -w %DELAY% >NUL


ECHO Total requests by minute, grouping by IP and xml URI...
%PROCESSACTION% "SELECT TO_STRING(time, 'HH') AS Hour, TO_STRING(time, 'mm') AS Minute, c-ip AS IP, SUBSTR(cs-uri-stem,0,INDEX_OF(cs-uri-stem,';')) as URI, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE (TO_INT(TO_STRING(time, 'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR%) AND URI = '/jsp/getrequest.jsp' GROUP BY Hour, Minute, IP, URI ORDER BY Hour, Minute, Hits ASC" -i:IISW3C -o:DATAGRID
ping 1.1.1.1 -n 1 -w %DELAY% >NUL


ECHO Total
%PROCESSACTION% "SELECT TO_STRING(time, 'HH') AS Hour, TO_STRING(time, 'mm') AS Minute, c-ip AS IP, EXTRACT_EXTENSION(cs-uri-stem)) as TYPE, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE (TO_INT(TO_STRING(time, 'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR%) GROUP BY Hour, Minute, IP, TYPE ORDER BY Hour, Minute, Hits, TYPE ASC" -i:IISW3C -o:DATAGRID
ping 1.1.1.1 -n 1 -w %DELAY% >NUL


REM SUBSTR(EXTRACT_EXTENSION(cs-uri-stem),0,INDEX_OF(EXTRACT_EXTENSION(cs-uri-stem),';')) as TYPE,
REM EXTRACT_EXTENSION(File) IN ('zip'; 'pdf'; 'mpg')


REM ECHO ===== OUTPUT TO CHART =====

REM %PROCESSACTION% "SELECT TO_STRING(time, 'HH') AS Hour, COUNT(*) AS Hits INTO MyChart.jpg FROM %LOGFILE% WHERE TO_INT(TO_STRING(time, 'HH'))>=%STARTHR% AND TO_INT(TO_STRING(time, 'HH'))<=%ENDHR% GROUP BY Hour ORDER BY Hour ASC" -i:IISW3C -o:CHART -chartType:ColumnClustered -chartTitle:"Hourly Hits" -groupSize:420x280





pause
REM EOF