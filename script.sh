#!/bin/sh
# netstat -ant | grep -E ':80|:443' | wc -l
FILESIZE=`ls -l /var/log/httpd/access_log | awk '{print $5}' `
if [ $FILESIZE -le 3500000 ]
then
        # not enough data - log file has rolled over
        echo "APACHE_RPS|0"
else
