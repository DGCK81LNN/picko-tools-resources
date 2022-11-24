#!/usr/bin/env bash

trap 'echo "$(s 30 101)^C$(s)"; exit 130' SIGINT

if [ -e ../game ]; then
  echo -n "$(s 91)Are you sure you want to discard $(s 7)game/$(s 27) and select another version? $(s 93)[y/n]> $(s)"

  while true; do read -srn1 # Getch
    if [ "$REPLY" == 'n' ]; then
      echo "$(s 30 101) No $(s)"
      exit 125
    elif [ "$REPLY" == $'\x04' ]; then
      echo "$(s 30 101)^D$(s)"
      exit 125
    elif [ "$REPLY" == 'y' ]; then
      echo "$(s 30 102) Yes $(s)"
      rm -rf ../game
      break
    fi
  done
fi

mkdir ../game

echo "$(s 94)Choose a game version$(s)"
_utils/cver 'game versions'
stat=$?
echo "$(s 2)gcver: delete temp directory$(s)"
rm -rf .cvertmp

if [ $stat -eq 125 ]; then # EOF
  rmdir ../game
  exit 125
elif [ $stat -eq 0 ]; then
  s 2
  # Create desktop.ini
  echo "gcver: create desktop.ini"
  echo -n $'[ViewState]\r\nFolderType=Generic\r\n' > ../game/desktop.ini &&
  attrib +s +h ../game/desktop.ini

  if [ -f .gcver-exename ] && (read exe < .gcver-exename; [ -f "$exe" ]); then
    echo "gcver: picko executable name unchanged"
  else
    echo "gcver: find picko executable"
    exe="$(find ../game/ -maxdepth 1 -name 'PICKO*.exe' | head -n1)"
    if [ "$exe" ]; then
      echo -n "$exe" > .gcver-exename

      # Update shortcut(s)
      if [ "$exe" -a -f shortcuts.txt ]; then
        readarray -t shortcuts < shortcuts.txt
        for shortcut in "${shortcuts[@]%$'\r'}"; do
          if [[ "$shortcut" && "$shortcut" != "#"* ]]; then
            echo "gcver: update shortcut $shortcut"
            _utils/mkshortcut "$shortcut" "$exe" ../game/
          fi
        done
      fi
    else
      echo "gcver: picko executable not found"
    fi
  fi
  s

  echo "$(s 92)Game version switched!$(s)"
else
  echo "$(s 91)Error occurred!$(s)"
  exit $stat
fi
