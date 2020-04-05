#!/bin/bash 
# Get current swap usage for all running processes

# Confirm root user
# make one call to ps, to gather info for each pid
# total up the "Swap:" lines from /proc/<pid>/smaps
# print the swap totals for each pid, with pid info, then sort by swap usage


if [ "$(id -u)" != "0" ]; then
    echo "Sorry, you are not root. Please run script as root"
    exit 1
fi

( \
ps -e -o pid,user,stime,tty,time,cmd --no-headers | sed -e 's/^/PIDS /' ; \
find /proc/ -noleaf -maxdepth 2 -type f -name "smaps" | xargs egrep "^Swap:" 2>/dev/null | grep -v " 0 kB" | awk -F: '{print $1 "/" $3}' | awk -F/ '{print $3 $5}' \
) | \
awk '$1=="PIDS"{pid=$2; user=$3; $1=""; $2=""; $3=""; users[pid]=user ; details[pid]=$0} $1!="PIDS"{swap[$1]+=$2 ; 
total+=$2}END{for (pid in swap) {printf("%10s %10d kB %5.1f %% %12s %.50s\n", pid, swap[pid], (swap[pid] / total * 100), users[pid], details[pid])}}' 2>/dev/null | \
sort -k2 -n | awk '{total+=$2 ; print }END{printf("TOTAL = %s kB\n", total)}'