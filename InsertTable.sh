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
number=$(wc -l  dbs/dep.type | awk '{print $1}')
number=$(( $number-1 ))
#echo "$number"
#awk -F, '{if (NR==3) print $2 }' dep.type get the third line and 2nd field
output=""
for ((i=0;i<"$number";i++));do
    #skip the first line
    lineNumber=$(( $i+2 ))
    fieldName=$(awk -F, -v lineNumber="$lineNumber" '{if (NR==lineNumber) print $1 }' dbs/dep.type)
    fieldType=$(awk -F, -v lineNumber="$lineNumber" '{if (NR==lineNumber) print $2 }' dbs/dep.type)
    fields=$(kdialog --title "Fields" --inputbox "Please Enter $fieldName ")
    type=`checkDataType $fieldType $fields `
    pk=$(awk -F, '{if (NR==1) print $2 }' dbs/dep.type)
    
    while [ $type = "false" ];do
                echo "in while condition"
				fields=$(kdialog --title "Fields" --inputbox "Please Enter $fieldName ")
				type=`checkDataType $fieldType $fields`
            
                   
                
    done
   output+="$fields,"
 
done
 echo "$output" >> dbs/dep
 sed -i  's/,$/\ /'  dbs/dep
