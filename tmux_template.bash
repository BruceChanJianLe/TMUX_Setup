#!/bin/bash
# This script is a template for starting a predefined tmux

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-p] [-g]
Script description here.
Available options:
-h, --help      Print this help and exit -p, --path      Set path to somewhere
-g, --gui       Set true or false some application's GUI
EOF
  exit
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

parse_params() {
  # default values of variables set from params
  MY_PATH="$HOME"
  GUI="true"

  while test $# -gt 0; do
    case $1 in
    -h | --help) usage ;;
    -p | --path)
      shift
      MY_PATH=$1
      ;;
    -g | --gui)
      shift
      if [[ $1 == "true" || $1 == "false" ]]
      then
        GUI=$1
      else
        die "-g only accepts true or false."
      fi
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  return 0
}

parse_params "$@"

tmux has-session -t tmux_template

if [ $? != 0 ]; then
    # create a new session
    tmux new-session -s tmux_template -n tmux_template -d

    # First Pane Description
    tmux send-keys -t tmux_template 'echo "First command to run"' C-m
    tmux select-layout -t tmux_template tiled

    # Second Pane Description
    tmux split-window -h -t tmux_template
    tmux send-keys -t tmux_template 'echo "Second command to run"' C-m
    tmux select-layout -t tmux_template tiled

    # Third Pane Description
    tmux split-window -v -t tmux_template
    tmux send-keys -t tmux_template 'echo "Third command to run"' C-m
    tmux select-layout -t tmux_template tiled

    # Fourth Pane Description
    tmux split-window -h -t tmux_template
    tmux send-keys -t tmux_template 'echo "Fourth command to run"' C-m
    tmux select-layout -t tmux_template tiled

    # New window
    tmux new-window -a -t tmux_template -n new_window
    tmux send-keys -t tmux_template:new_window  'echo "New window first command"' C-m 
    tmux select-layout -t tmux_template:new_window tiled

    # New window Second Pane Description
    tmux split-window -h -t tmux_template:new_window
    tmux send-keys -t tmux_template:new_window  'echo "New window second command"' C-m 
    tmux select-layout -t tmux_template:new_window tiled

    # New window Third Pane Description
    tmux split-window -v -t tmux_template:new_window
    tmux send-keys -t tmux_template:new_window  'echo "New window third command"' C-m 
    tmux select-layout -t tmux_template:new_window tiled

    # New window Fourth Pane Description
    tmux split-window -h -t tmux_template:new_window
    tmux send-keys -t tmux_template:new_window  'echo "New window fourth command"' C-m 
    tmux select-layout -t tmux_template:new_window tiled

fi

if [ -z "$TMUX" ]; then
  tmux attach -t tmux_template
else
  tmux switch-client -t tmux_template
fi
