#!/bin/sh

DIR=/tmp/csa

for f in `ls $DIR`
do
   count=`grep -c "<html" $DIR/$f`

   if [ $count -gt 1 ]
   then
      fileInfo=`ls -l --time-style=long-iso $DIR/$f` 
      size=`echo $fileInfo | awk '{print $5}'`
      createDate=`echo $fileInfo | awk '{print $6,$7}'`
      echo "$f   $size   $createDate   $count"
   fi
done


