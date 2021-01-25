#!/usr/bin/bash

echo "Please enter the name of the database you want to connect to"
echo -n "Name: "
read name

exitflag=0


while [ $exitflag -eq 0 ];do

if [ -z $name ];then
	echo -n "Please enter a name: "
	read name
	continue
fi
if [ -d dbs/$name ];then
	connectDbName=$name
	exitflag=1
else
	echo "No such Database found"
	echo -n "Enter another name: "
	read name
fi
done

. ./deleteFrom.sh