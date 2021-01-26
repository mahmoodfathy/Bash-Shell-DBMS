#!/usr/bin/bash

getTableName

listTableContents

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

awk -F',' -v rn="$rowNum" '{if(NR!=rn) print}' dbs/$connectDbName/$tableName > dbs/$connectDbName/transitionFile
cat dbs/$connectDbName/transitionFile > dbs/$connectDbName/$tableName
rm dbs/$connectDbName/transitionFile
echo "Row deleted Successfully"