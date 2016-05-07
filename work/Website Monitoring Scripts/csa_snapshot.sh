#!/bin/sh

FILENAME=`date +'/tmp/xxx/%y%m%d-%H%M%S.html'`
curl -i http://www.yoursite.com/ > $FILENAME

REP_COUNT=`grep -c "<html" $FILENAME`

echo "REP: $REP_COUNT";

if [ $REP_COUNT -gt  1 ]
then
   session=r`awk '/Set-Cookie\: JSESSIONID=(.*)/ {print $2}' $FILENAME`
   echo "Found multiple ($REP_COUNT) segments in $FILENAME"
   echo "Found multiple ($REP_COUNT) HTML segments in $FILENAME $session" | mail -s "Bad homepage on Xian"  xxx@xxxxx.com,yyy@yyyyy.com
fi
