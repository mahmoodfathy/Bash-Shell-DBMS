#!/usr/bin/bash

exitflag=0

while [ $exitflag -eq 0 ];do

if [ -z $tableName ];then
	echo -n "Please enter a table name: "
	read tableName
	continue
fi
if [ -f dbs/$connectDbName/$tableName ];then
	exitflag=1
else
	echo "No such Table found"
	echo -n "Enter another table name: "
	read tableName
fi
done


echo "####################################"
for val in `cat dbs/$connectDbName/$tableName`;do
    echo $val
done
echo "####################################"

echo "Please Enter row's primary key that you want to update"
echo -n "Primary Key: "
read pk

fieldNum=`awk -F',' -v pk="$pk" '{if($1==pk) print NR}' dbs/$connectDbName/$tableName`
exitflag=0

while [ $exitflag -eq 0 ];do
	if [ -z $fieldNum ];then
		echo -n "Please enter a valid primary key: "
		read pk
		fieldNum=`awk -F',' -v pk="$pk" '{if($1==pk) print NF}' dbs/$connectDbName/$tableName`
	else
		exitflag=1
	fi
done

rowNum=`awk -F',' -v fn="$pk" '{if($1==fn) print NR}' dbs/$connectDbName/$tableName`

if [ $rowNum -gt 0 ];then

	exitflag=0
	while [ $exitflag -eq 0 ];do
		echo -n "Please Enter a valid field number: "
		read fieldNumber
		fieldCount=`awk -F',' -v rn="$rowNum" '{if(NR==rn) print NF}' dbs/$connectDbName/$tableName`
		if [ $fieldNumber -lt $fieldCount ];then
			break
		fi
	done

	typeField=$[ $fieldNumber+1 ]
	type=`awk -F',' -v ty="$typeField" '{if(NR==ty) print $2}' dbs/$connectDbName/$tableName.types`
	echo -n "Please Enter the new value: "
	read new

	exitflag=0
	if [ $fieldNumber -eq 1 ];then

		idExist=`awk -F',' -v id="$new" '{if($1==id) print}' dbs/$connectDbName/$tableName`
		while [ $exitflag -eq 0 ];do
			if [ -z $idExist ];then
				exitflag=1
				
			else
				echo -n "Please Enter a unique primary key: "
				read new
				idExist=`awk -F',' -v id="$new" '{if($1==id) print}' dbs/$connectDbName/$tableName`
			fi
		done

		awk -F',' -v col="${fieldNumber}" -v id="${pk}" -v val=$new '{if($1==id){$col=val}{print $0}}' FS=, OFS=, dbs/$connectDbName/$tableName > dbs/$connectDbName/transitionFile
		cat dbs/$connectDbName/transitionFile > dbs/$connectDbName/$tableName

		else
			correct=`checkDataType $type $new`

			while [ $correct = "false" ];do
				echo "Date type for field $fieldNumber is $type"
				echo -n "Please enter a valid data type: "
				read new
				correct=`checkDataType $type $new`
			done
	fi

	awk -F',' -v col="${fieldNumber}" -v id="${pk}" -v val=$new '{if($1==id){$col=val}{print $0}}' FS=, OFS=, dbs/$connectDbName/$tableName > dbs/$connectDbName/transitionFile
	cat dbs/$connectDbName/transitionFile > dbs/$connectDbName/$tableName
fi

rm dbs/$connectDbName/transitionFile
echo "Row updated successfully"