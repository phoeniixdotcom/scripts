#!/bin/sh
site=$1
testDir="/home/xxx/tests"
baseUrl=http://$site.yoursite.com

for file in `ls $testDir`
do
   uri=`echo $file |  sed -e 's/--/\//'`

   requestUrl=$baseUrl/$uri
   postFile=$testDir/$file
   echo "Posting $postFile to $requestUrl"
   wget --verbose -O /tmp/site_tests/$file --post-file $postFile $requestUrl
done
