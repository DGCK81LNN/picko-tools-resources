@echo off
:: start game
start /d ..\..\game ..\..\game\PICKO_picko.exe
:: sleep 300ms
ping 192.168.0.10 -n 1 -w 300 > nul
:: run resizer
picko-resizer %1
