#!/usr/bin/env bash
if [ ! -e ../game/_start.txt ]; then
  echo "$(s 31)No startup commands$(s)"
  exit 1
fi

echo -n "$(s 91)Are you sure you want to discard $(s 7)_start.txt$(s 27)? $(s 93)[y/n]> $(s)"

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

rm -f ../game/_start.txt
_utils/cverlog "startup commands: (deleted)"
