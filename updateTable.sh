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

echo $pk