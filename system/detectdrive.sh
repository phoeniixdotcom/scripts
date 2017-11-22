#!/bin/bash
uptime=$(uptime | awk -F' '  '{ print $3" "$4 }' | sed s/,//)
date=$(date -d "$uptime ago" | awk '{print $2" "$3 }')
zgrep "$date"  /var/log/kern.log*  | \
grep 'ata[0-9]\+.[0-9][0-9]: ATA'  | \
sed 's/^.*\] ata//' | \
sort -n | sed 's/:.*//' | \
awk ' { a="ata" $1; printf("%10s is /dev/sd%c\n", a, 96+NR); }'