#!/usr/bin/bash
clear
echo $connectDbName
kdialog --title "Table Name" --inputbox "What is the name of your Table?" > out

for choice in $(cat out) ;do
if [ -f dbs/"$connectDbName"/$choice ];then
kdialog --sorry "Table Name Already exists"
    else
    touch dbs/"$connectDbName"/$choice
fi

done

continueFlag=0 #checks if there are no errors in datatype
input=$(kdialog --title "Number of Table Fields" --inputbox "Please Enter the number of fields")

 for ((i=0;i<"$input";i++)) ; do
    number=$(( $i+1 ))
    name=$(kdialog --title "Field Names" --inputbox "Please Enter the $number field name")
    tableName=`cat out` 
    type=$(kdialog --title "Field Types" --inputbox "Please Enter the $number field int or str")
    case "$type" in
    "str")  echo "$name,$type" >>dbs/"$connectDbName"/"$tableName.types";;
    "int") echo "$name,$type" >>dbs/"$connectDbName"/"$tableName.types";;
      
    *) 
    kdialog --sorry "Please Enter a valid data type";
    rm dbs/"$connectDbName"/"$tableName";
    continueFlag=1; 
    break;
    ;;
    esac
    
    done
if [ $continueFlag -eq 0 ];then
    pk=$(kdialog --title "Field Names" --inputbox "Please Enter the Primary key")
    #check if the key entered is in valid fields  otherwise show error message and read key again
    awk -F, '{print $1};' dbs/"$connectDbName"/"$tableName.types">>keys
    flag=1
    while [ $flag -eq 1 ] ;do
    if grep -Fxq "$pk" keys
    then
        #if key is found
        key=$(awk /$pk/ dbs/"$connectDbName"/"$tableName.types") #gets the key
        sed -i "1 i\\$key" dbs/"$connectDbName"/"$tableName.types"
        line=$(awk -F',' -v pk="$pk" '{if($1==pk) print NR}' dbs/"$connectDbName"/"$tableName.types" | tail -1)
        sed -i "$line d" dbs/"$connectDbName"/"$tableName.types"  #deletes the line
        sed -i "1 i\pk,$pk" dbs/"$connectDbName"/"$tableName.types"
       
        
        flag=0
    else
        #if key is not found
        kdialog --sorry "Please Enter a valid key name"
        pk=$(kdialog --title "Field Names" --inputbox "Please Enter the Primary key")
    fi
    done
fi
if [ -f keys ];then
    rm keys
fi