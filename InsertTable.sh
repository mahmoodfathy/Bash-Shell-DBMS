#!/usr/bin/bash
function checkDataType(){
	case "$1" in
		"int") 
			if [[ "$2" =~ ^-?[0-9]+$ ]];then
				echo "true"
			else 
			echo "false"
			fi
			;;
		"str")	
			if [[ "$2" =~ [^a-zA-Z0-9] ]];then
				echo "false"
			else
			echo "true" 
			fi;;
		*)  echo "false"
			;;	
	esac
}
echo "##############################"
echo $connectDbName
echo "##############################"
tableName=$(kdialog --title "Table Name" --inputbox "Please Enter Table Name")
if [ -f dbs/"$connectDbName"/$tableName ];then

number=$(wc -l  dbs/"$connectDbName"/"$tableName.types" | awk '{print $1}')
number=$(( $number-1 ))


output=""
for ((i=0;i<"$number";i++));do
    #skip the first line
    lineNumber=$(( $i+2 ))
    fieldName=$(awk -F, -v lineNumber="$lineNumber" '{if (NR==lineNumber) print $1 }' dbs/"$connectDbName"/"$tableName.types")
    fieldType=$(awk -F, -v lineNumber="$lineNumber" '{if (NR==lineNumber) print $2 }' dbs/"$connectDbName"/"$tableName.types")
    fields=$(kdialog --title "Fields" --inputbox "Please Enter $fieldName ")
	if [ $i -eq 0 ];then
	exitflag=0
	isUnique=`awk -F',' -v id="$fields" '{if($1==id) print}' dbs/$connectDbName/$tableName`
		while [ $exitflag -eq 0 ];do
			if [ -z $isUnique ];then
				exitflag=1
				
			else
				kdialog --sorry "Primary Key should be unique ,Enter another one please"
				fields=$(kdialog --title "Fields" --inputbox "Please Enter $fieldName ")
				isUnique=`awk -F',' -v id="$fields" '{if($1==id) print}' dbs/$connectDbName/$tableName`
			fi
		done
	fi
    type=`checkDataType $fieldType $fields `
    pk=$(awk -F, '{if (NR==1) print $2 }' dbs/"$connectDbName"/"$tableName.types")
    
    while [ $type = "false" ];do
                echo "in while condition"
				fields=$(kdialog --title "Fields" --inputbox "Please Enter $fieldName ")
				type=`checkDataType $fieldType $fields`
            
                   
                
    done
   output+="$fields,"
 
done
 echo "$output" >> dbs/"$connectDbName"/"$tableName"
 sed -i  's/,$/\ /'  dbs/"$connectDbName"/$tableName""
 else
 kdialog --sorry "Table Name doesnt  exist"
 fi
