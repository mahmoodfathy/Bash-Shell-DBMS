#!/usr/bin/bash

exitflag=0

while [ $exitflag -eq 0 ];do

echo -n "Please enter a table name: "
read tableName

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

echo "Please Enter row's primary key that you want to delete"
echo -n "Primary Key: "
read pk

fieldNum=`awk -F',' -v pk="$pk" '{if($1==pk) print NR}' dbs/$connectDbName/$tableName`

exitflag=0

while [ $exitflag -eq 0 ];do
	if [ -z $fieldNum ];then
		echo -n "Please enter a valid primary key: "
		read pk
		fieldNum=`awk -F',' -v pk="$pk" '{if(NR==pk) print NF}' dbs/$connectDbName/$tableName`
	else
		exitflag=1
	fi
done

rowNum=`awk -F',' -v fn="$pk" '{if($1==fn) print NR}' dbs/$connectDbName/$tableName`

echo $rowNum
awk -F',' -v rn="$rowNum" '{if(NR!=4) print}' dbs/$connectDbName/$tableName > dbs/$connectDbName/transitionFile
cat dbs/$connectDbName/transitionFile > dbs/$connectDbName/$tableName
rm dbs/$connectDbName/transitionFile
echo "Row deleted Successfully"