#!/bin/bash
# Chris Sanders
# Intrusion Detection Honeypots Book
# This command dumps the process list using ps and formats it for Cowrie's cmdoutput.json file using jq. 
ps -eo pcpu,%mem,pid,rss,start_time,stat,bsdtime,tty,user,vsz,args | egrep -v '(ps -eo|jq|egrep|awk)' | awk '{for(i=1;i<=10;i++){printf "%s\t",$i};out=$11; for(i=12;i<=NF;i++){out=out" "$i}; print out}'  | jq -s  --slurp --raw-input --raw-output 'split("\n") | .[1:-1] | map(split("\t")) | map({"COMMAND": .[10], "CPU": .[0]|tonumber, "MEM": .[1]|tonumber, "PID": .[2]|tonumber, "RSS": .[3]|tonumber, "START": .[4], "STAT": .[5], "TIME": .[6], "TTY": .[7], "USER": .[8], "VSZ": .[9]|tonumber})| { "command": { "ps": .}}'
