#!/usr/bin/bash

getTableName

echo "Please Enter row's primary key that you want to select"
echo -n "Primary Key: "
read pk

fieldNum=`awk -F',' -v pk="$pk" '{if($1==pk) print NR}' dbs/$connectDbName/$tableName`
exitflag=0

while [ $exitflag -eq 0 ];do
	if [ -z $fieldNum ];then
		echo "No such primary key found"
        echo -n "Please enter a valid primay key: "
		read pk
		fieldNum=`awk -F',' -v pk="$pk" '{if($1==pk) print NF}' dbs/$connectDbName/$tableName`
	else
		exitflag=1
	fi
done

echo "##########################"
awk -F',' -v pk="$pk" '{if($1==pk) print}' dbs/$connectDbName/$tableName
echo "##########################"