#!/usr/bin/bash
clear
kdialog --title "Table Name" --inputbox "What is the name of your Table?" > out

for choice in $(cat out) ;do
if [ -f dbs/$choice ];then
kdialog --sorry "Table Name Already exists"
    else
    touch dbs/$choice
fi

done


