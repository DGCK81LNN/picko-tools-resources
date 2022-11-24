#!/usr/bin/env bash
if [ ! -e ../game/_record.txt ]; then
  echo "$(s 31)No recorded play$(s)"
  exit 1
fi

if [ -e ../game/_replay_2_play.txt ]; then
  echo -n "$(s 91)This will overwrite $(s 7)_replay_2_play.txt$(s 27)! Are you sure? $(s 93)[y/n]> $(s)"

  while true; do read -srn1 # Getch
    if [ "$REPLY" == 'n' ]; then
      echo "$(s 30 101) No $(s)"
      exit 125
    elif [ "$REPLY" == $'\x04' ]; then
      echo '^D'
      exit 125
    elif [ "$REPLY" == 'y' ]; then
      echo "$(s 30 102) Yes $(s)"
      break
    fi
  done
fi

s 2
mv -fv ../game/_record.txt ../game/_replay_2_play.txt
s
_utils/cverlog "replays: (copied from record)"
