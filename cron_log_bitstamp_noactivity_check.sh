#!/bin/bash

# restart bitstamp log collector if it did obtain any update last 10 minutes

# $1 bitstamp logfile directory path
# $2 bitstamp logfile name
# $3 bitstamp check time in minutes

if [ -f "${1}/${2}" ]
then
    if find "${1}" -type f -not -mmin -10 -print 2>/dev/null | grep -e "${2}$"
    then
        killall log_bitstamp_trades.py
        timestamp=$(date +%s)
        mv "${1}/${2}" "${1}/${2}.${timestamp}"
        nohup /mnt/data/code/log_bitstamp_trades.py "${1}/${2}" /mnt/data/bitstamp_logs/reload_log &
    fi
fi

