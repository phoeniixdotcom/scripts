#!/bin/sh

i=0
while [ $i -lt 500 ]
do
   echo pinging $i
#   curl http://10.10.5.120:8100/
#   curl http://10.10.3.66:8100/
#   curl http://10.14.2.105/ 
#   curl -d @post_purchase_request.dat http://10.10.1.228/jsp/getrequest.jsp -D -&
   curl http://10.14.2.140/images/bullet_rainy.jpg > /dev/null &
#   curl -d @post_purchase_request.dat http://10.10.5.84:8100/jsp/getrequest.jsp & #sxlpcold
   i=`expr $i + 1`
done
