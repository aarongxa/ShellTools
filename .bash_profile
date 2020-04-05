# tmux stuff
alias nt="tmux list-sessions >/dev/null 2>&1 echo 'Attaching to existing tmux session' && sleep .5 && tmux -2 attach || echo 'Creating new tmux session..' && sleep .5 && sh $HOME/tmux-new-session.sh"
alias t='tmux -2 attach -d'
alias tl='tmux list-sessions'

_tmux_send_keys_all_panes_ () {
  for _pane in $(tmux list-panes -F '#P'); do
    tmux send-keys -t ${_pane} "$@"
  done
}

# Rename tmux title to server hostname
ssh() {
    if [ "$(ps -ef | awk '{print $6}' | grep '/usr/bin/tmux')" ]; then
        tmux rename-window "$(echo $* | cut -d @ -f 2)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

# Docker stuff
docker-ips() {
    docker inspect --format='{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
}

docker-ip() {
  docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$@"
}