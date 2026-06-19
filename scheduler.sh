#!/bin/bash
# GitHub Trending Scheduler
# Checks daily at 09:00 and runs scraper if not already run today

LOGFILE="/tmp/trending.log"
LAST_FILE="/tmp/trending_last_run.txt"
SCRIPT_DIR="$(dirname "$0")"

TODAY=$(date +%Y-%m-%d)
LAST=$(cat $LAST_FILE 2>/dev/null)

if [ "$TODAY" != "$LAST" ]; then
    echo "[$(date)] Running scraper..." >> $LOGFILE
    cd $SCRIPT_DIR
    python3 scraper.py >> $LOGFILE 2>&1
    echo $TODAY > $LAST_FILE
    echo "[$(date)] Done" >> $LOGFILE
fi
