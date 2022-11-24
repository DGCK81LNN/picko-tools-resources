#!/usr/bin/env bash

trap 'echo "$(s 30 101)^C$(s)"; exit 130' SIGINT

# List avalable zips but exclude game.zip
readarray -t collections < <(cd ../resources; find -name '*.zip' -a ! -name 'game versions.zip')
collections=("${collections[@]#./}") # Trim ./ prefix
collections=("${collections[@]%.zip}") # Trim .zip suffix

while true; do
  echo "$(s 94)Choose a category to customize, or Ctrl+D to go back$(s)"

  for _ in ''; do
    # Choose a collection
    select collection in "${collections[@]}"; do
      # Keep prompting until input is valid
      if [ "$collection" ]; then break 2; fi
    done
    break 2 # Stop choosing collections
  done

  echo "$(s 94)Choose one of the $(s 4)$collection$(s 24), or Ctrl+D to go back$(s)"
  _utils/cver "$collection"
  stat=$?
  if [ $stat -eq 125 ]; then
    continue # EOF means cancel
  elif [ $stat -eq 0 ]; then
    echo "$(s 92 4)$collection$(s 24) switched!$(s)"
  else
    echo "$(s 91)Error occurred!$(s)"
  fi
done

echo "$(s 2)rcver: delete temp directory$(s)"
rm -rf .cvertmp
