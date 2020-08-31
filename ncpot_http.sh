#!/bin/bash

# Chris Sanders
# Intrusion Detection Honeypots Book

PORT=80
LOG=hpot.log
BANNER=`cat index.html`

touch /tmp/hpot.hld
echo "" >> $LOG

while [ -f /tmp/hpot.hld ]
 do
  echo "$BANNER" | ncat -lvnp $PORT 1>> $LOG 2>> $LOG
  echo "==ATTEMPTED CONNECTION TO PORT $PORT AT `date`==" >> $LOG
  echo "" >> $LOG
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" >> $LOG
 done


