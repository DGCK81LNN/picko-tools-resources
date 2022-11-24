#!/usr/bin/env bash

# Emit a control sequence to set text color & style
s() {
  a=$*
  echo -ne "\e[${a// /\;}m"
}
export -f s

actionFuncs=()
actionLabels=()

addAction() {
  actionFuncs+=("$1")
  shift
  actionLabels+=("$*")
}

export PS3="$(s 93)[#?]> $(s)"
cd "$(dirname $0)"
trap '' SIGINT

addAction './_gcver.sh' "Cver: Switch Game Version"
addAction './_rcver.sh' "Cver: Apply Resources"
addAction './_cverlog.sh' "Cver: View Cver Log"
addAction './_setreplay.sh' "Replay Recorded Play"
addAction './_rmreplay.sh' "Remove Replay"
addAction './_setstartupcmd.sh' "Set Startup Commands"
addAction './_rmstartupcmd.sh' "Remove Startup Commands"
addAction 'ls --color ../game' "Ls Game Directory"
addAction './_startbash.sh' "Start Bash in Game Directory"
addAction './_startgame.sh' "Launch Game"
addAction './_startgameresized.sh' "Launch Game Resized"

while true; do
  echo "$(s 36)Choose an action, or Ctrl+D to quit$(s)"
  for _ in ''; do
    select label in "${actionLabels[@]}"; do
      if [ "$label" ]; then break 2; fi
    done
    break 2
  done
  index=$((REPLY - 1))
  func="${actionFuncs[$index]}"

  echo
  trap - SIGINT
  $func
  trap '' SIGINT
  echo
done

echo "$(s 36)Bye$(s)"
sleep 1
