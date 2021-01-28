#!/usr/bin/bash
typeset -i toNum
getTableName #helper function to get table name

listTableContents #helper function to list table rows

echo "Please Enter row's primary key that you want to update"
echo -n "Primary Key: "
read pk

fieldNum=`awk -F',' -v pk="$pk" '{if($1==pk) print NR}' dbs/$connectDbName/$tableName`
exitflag=0

while [ $exitflag -eq 0 ];do #loop until he enters a valid primary key
	if [ -z $fieldNum ];then #if fields number = 0 then this is invalid primary key
		echo -n "Please enter a valid primary key: "
		read pk
		#if primary ket exists the following line will get the number of fields of that row
		fieldNum=`awk -F',' -v pk="$pk" '{if($1==pk) print NF}' dbs/$connectDbName/$tableName`
	else
		exitflag=1
	fi
done

#the next line gets the row number of that primary key
rowNum=`awk -F',' -v fn="$pk" '{if($1==fn) print NR}' dbs/$connectDbName/$tableName`

if [ $rowNum -gt 0 ];then #only excute when the row number exists

	exitflag=0
	while [ $exitflag -eq 0 ];do #loop to make sure he entered a valid field number
		echo -n "Please Enter a valid field number: "
		read fieldNumber
		#the following lines gets the number of fields of the specified row
		fieldCount=`awk -F',' -v rn="$rowNum" '{if(NR==rn) print NF}' dbs/$connectDbName/$tableName`
		num=0
		num=$(($num+$fieldNumber))

		#num is used to convert the fieldNumber value to integer if he entered a string instead of number
		#the following if check if the fieldNumber input is less than the actual number of fields
		#[ $num -gt 0 ] this means he didn't input a string or input a 0
		if [ $num -le $fieldCount ] && [ $num -gt 0 ];then
			break
		fi
	done

	typeField=$[ $fieldNumber+1 ] #this variable holds the line number of the field data type

	#type variable will hold the data type
	type=`awk -F',' -v ty="$typeField" '{if(NR==ty) print $2}' dbs/$connectDbName/$tableName.types`
	echo -n "Please Enter the new value: "
	read new #read the new value to update with

	exitflag=0
	if [ $fieldNumber -eq 1 ];then #if he wants to update the primary key

		idExist=`awk -F',' -v id="$new" '{if($1==id) print}' dbs/$connectDbName/$tableName`

		correct=`checkDataType $type $new` #check new value is right data type

		while [ $correct = "false" ];do #loop to make data type is correct
			echo "Date type for field $fieldNumber is $type"
			echo -n "Please enter a valid data type: "
			read new
			correct=`checkDataType $type $new`
		done

		while [ $exitflag -eq 0 ];do #loop to make sure the id is unique
			if [ -z $idExist ];then #this if will happen if new value is unique
				exitflag=1
				
			else
				echo -n "Please Enter a unique primary key: "
				read new
				#idExist holds the value to check if primary key is unique
				idExist=`awk -F',' -v id="$new" '{if($1==id) print}' dbs/$connectDbName/$tableName`
			fi
		done

		#update the table and save it
		awk -F',' -v col="${fieldNumber}" -v id="${pk}" -v val=$new '{if($1==id){$col=val}{print $0}}' FS=, OFS=, dbs/$connectDbName/$tableName > dbs/$connectDbName/transitionFile
		cat dbs/$connectDbName/transitionFile > dbs/$connectDbName/$tableName

		else
			correct=`checkDataType $type $new` #check new value is right data type

			while [ $correct = "false" ];do #loop to make data type is correct
				echo "Date type for field $fieldNumber is $type"
				echo -n "Please enter a valid data type: "
				read new
				correct=`checkDataType $type $new`
			done
	fi

	#update the table and save it
	awk -F',' -v col="${fieldNumber}" -v id="${pk}" -v val=$new '{if($1==id){$col=val}{print $0}}' FS=, OFS=, dbs/$connectDbName/$tableName > dbs/$connectDbName/transitionFile
	cat dbs/$connectDbName/transitionFile > dbs/$connectDbName/$tableName
fi

#remove the transitionFile
rm dbs/$connectDbName/transitionFile
echo "Row updated successfully"