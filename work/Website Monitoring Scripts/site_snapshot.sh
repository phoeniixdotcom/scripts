#!/bin/sh

site=$1
FILENAME="/tmp/$site/"`date +'%y%m%d-%H%M%S.html'`
baseUrl="http://$site.yoursite.com"
urls=("$baseUrl/" "$baseUrl/trams" "$baseUrl/aboutus.do" "$baseUrl/jsp/TestPage.jsp")
index=$[$RANDOM % 4];
uri=${urls[$index]}
cookieFile=`mktemp`

echo "Requesting $uri saving to $FILENAME (cookies in $cookieFile)";
curl -i -L -c $cookieFile --cookie $cookieFile $uri > $FILENAME
echo "Requesting $uri" >> $FILENAME

REP_COUNT=`grep -c "<html" $FILENAME`

echo "REPs: $REP_COUNT";

if [ $REP_COUNT -gt  1 ]
then
   echo "Bad response";
   session=r`awk '/Set-Cookie\: JSESSIONID=(.*)/ {print $2}' $FILENAME`
   echo "Found multiple ($REP_COUNT) segments in $FILENAME"
   echo "Found multiple ($REP_COUNT) HTML segments in $FILENAME $session" | mail -s "Bad response to $uri"  xxx@xxxxx.com,yyy@yyyyy.com
fi
