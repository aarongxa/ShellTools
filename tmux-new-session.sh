#!/bin/sh
# simple script to fire up tmux with a lot of windows

# start a new session, but don't attach to it
tmux new-session -d

# we get one window "for free", so "1-29" will mean a total of 30 windows
# "1-19" will mean a total of 20 windows
for n in {1..3} ; do
  tmux neww
done

# attach to the session
tmux -2 attach

#!/bin/sh
# take a param and use it to change the active tmux window
case $1 in
  "")
    # empty string means "go to the last active window"
    tmux last-window
    ;;
  [0-9]|[0-9][0-9])
    # 1 or 2 digit numbers are assumed to be window numbers
    tmux select-window -t ":$1"
    ;;
esac

