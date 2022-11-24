#!/usr/bin/env bash
if [ -f .gcver-exename ]; then
  exe="$(cat .gcver-exename)"
else
  exe="$(find ../game/ -maxdepth 1 -name 'PICKO*.exe' | head -n1)"
fi
exe="$(realpath "$exe")"
cd ../game/
start "$exe"
