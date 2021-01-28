clear
kdialog --title "Table Name" --inputbox "What is the name of the Table you want to remove?" > out

for choice in $(cat out) ;do
if [ -f dbs/"$connectDbName"/$choice ];then
     rm dbs/"$connectDbName"/$choice
     rm dbs/"$connectDbName"/$choice.types
    else
    kdialog --sorry "Table Name doesnt  exist"
   
fi

done
