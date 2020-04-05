#!/bin/bash
#-------------------------------------------------
# Author: Aaron Griffith - www.aarongriffith.net
# Purpose: Cluster SSH Script
# Updated: 27 AUG 2014
# Special Note: Please adjust "User Input" to fix your needs
#
#---------------------------------------------------------


HOSTS="*"

# Execute script ONLY if tmux is running
if [ -z "$TMUX" ]; then
  echo Must be run from within an active tmux session 1>&2  
  exit 1
fi

# User Input - Ex. Inputting dev will connect to (3) development hosts - dev1 dev2 and dev3
# Please change this to your liking
# 
if [ "$1" = 'docker-lab' ]; then
    HOSTS="control lb01 app01 app02 db01"
    tmux rename-window "Docker Lab"
elif [ "$1" = 'pghmon' ]; then
    HOSTS="pgh-dc-admin-monitor-01"
    tmux rename-window "PGH Nagios"
elif [ "$1" = 'pgh-syslog-01' ]; then
    HOSTS="10.110.254.14"
    tmux rename-window "pgh-syslog-01"
elif [ "$1" = 'vvm' ]; then
    HOSTS="172.16.11.162"
    tmux rename-window "VVM-INT1"
elif [ "$1" = 'cricket-server3-all' ]; then
    HOSTS="10.192.99.103 10.192.99.104 10.192.99.211"
    tmux rename-window "Cricket-Server3-All"
elif [ "$1" = 'modesto-server3-all' ]; then
    HOSTS="10.192.42.101 10.192.42.102 10.192.42.201"
    tmux rename-window "Modesto-Server3-All"
elif [ "$1" = 'askey-all' ]; then
    HOSTS="10.192.166.211 10.192.166.212 10.192.166.101 10.192.166.102"
    tmux rename-window "askey-all"
elif [ "$1" = 'avatar-animates-all' ]; then
    HOSTS="10.192.102.50 10.192.102.201 10.192.102.202 10.192.102.101 10.192.102.102 10.192.102.103 10.192.102.104 10.192.102.151 10.192.102.152"
    tmux rename-window "avatar-animates-all"
elif [ "$1" = 'island1-all' ]; then
    HOSTS="hp360-p246 hp360-p247 hp360-p248 hp360-p249 hp360-p250 hp360-p293 d1950-p132 d1950-p133 d1950-p145 d1950-p146 d1950-p156 d1950-p188 d1950-p189 d1950-p203 d1950-p204 d1950-p205 d1950-p209 dr610-p217"
    tmux rename-window "ISLAND1-ALL"
elif [ "$1" = 'island2-all' ]; then
    HOSTS="vvm-ss01 vvm-ss02 vvm-ss03 vvm-ss04 vvm-ss05"
    tmux rename-window "ISLAND2-ALL"
elif [ "$1" = 'island3-all' ]; then
    HOSTS="vvm-ss01.island3.corevm.com vvm-ss02.island3.corevm.com vvm-ss03.island3.corevm.com vvm-ss04.island3.corevm.com vvm-ss05.island3.corevm.com"
    tmux rename-window "ISLAND3-ALL"
else
    #Connect to any user inputed hosts"
    HOSTS=$*
    tmux rename-window "Cluster"
fi

# SSH to hosts and arrange tiles
for i in $HOSTS
do
    tmux splitw "ssh $i"
    tmux select-layout tiled
done

# sync panes on
tmux set-window-option synchronize-panes on
