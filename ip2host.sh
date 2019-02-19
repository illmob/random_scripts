#!/bin/bash
export LC_ALL=C
for item
do
 domain=$(dig -x "$item"  +short)
 if [ -n "$domain"  ] ;
 then
     echo "$domain"
 else
     echo "$item" result is NULL
 fi
done

#cat ips.txt  |  xargs ./ip2host.sh >hostnames.txt && grep -v 'result is NULL' hostnames.txt | sed 's/\.$//g' >hosts.txt
