clear
kdialog --title "Table Name" --inputbox "What is the name of the Table you want to remove?" > out

for choice in $(cat out) ;do
if [ -f dbs/$choice ];then
     rm dbs/$choice
    else
    kdialog --sorry "Table Name doesnt  exist"
   
fi

done
