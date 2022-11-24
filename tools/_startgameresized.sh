#!/usr/bin/env bash
echo -n "$(s 93)Input the desired pixel ratio [1-9]>$(s) "
trap 'echo "$(s 30 101)^C$(s)"; echo ""; exit 130' SIGINT
n=0
until [ "$n" '>' '0' -a "$n" '<' ':' ]; do
  read -sN1 n
  if [ "$n" == $'\x04' ]; then
    echo "$(s 30 101)^D$(s)"
    exit 125
  fi
done
echo "$(s 30 102) $n $(s)"
./_startgame.sh
sleep 0.3
s 2
./picko-resizer/picko-resizer.exe "$n"
s
