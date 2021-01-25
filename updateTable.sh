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

fieldNum=`cat dbs/$connectDbName/$tableName | grep $pk | awk -F, '{print NF}'`

while [ $fieldNum -gt 0 ];do
if [ $fieldNum -eq 1 ];then
break
fi

echo -n "Please Enter new value for field number $fieldNum: "
read value
awk -F',' -v col="${fieldNum}" -v id="${pk}" -v val=$value '{if($1==id){$col=val}{print $0}}' FS=, OFS=, dbs/$connectDbName/$tableName > dbs/$connectDbName/transitionFile
cat dbs/$connectDbName/transitionFile > dbs/$connectDbName/$tableName
fieldNum=$[$fieldNum-1]
done

rm dbs/$connectDbName/transitionFile
echo "Row updated successfully"