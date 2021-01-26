#!/usr/bin/bash
clear
kdialog --menu "Operations Menu" "1" "Create Table" "2" "List Tables" "3" "Drop Table" "4" "Insert into Table" "5" "Select From Table" "6" "Delete From Table" "7" "Update Table" "0" "Exit" > out

for choice in $(cat out); do 

case $choice in 
1)
 . ./createTable.sh;;
2)
. ./ListTables.sh;;
3)
 . ./DropTable.sh;;
4)
. ./InsertTable.sh;;
5) . ./selectFrom.sh;;
6) . ./deleteFrom.sh;;
7) . ./updateTable.sh;;
0) kdialog --sorry "YOU CHOSE CANCEL";;
 *)
 kdialog --msgbox "Sorry, invalid selection"
esac
done
if [ -f out ];then
rm out
fi