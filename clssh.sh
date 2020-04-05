#!/bin/bash
#-------------------------------------------------
#
# Author: A. GRIFFITH
# Purpose: Cluster SSH Script
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
elif [ "$1" = 'servers23' ]; then
    HOSTS="server2 server3"
    tmux rename-window "PGH Nagios"
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
