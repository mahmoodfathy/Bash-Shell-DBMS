#!/usr/bin/bash

echo -n "Please enter the database name: "
read name
exitflag=0


while [ $exitflag -eq 0 ];do

if [ -z $name ];then
echo -n "Please enter a name: "
read name
continue
fi
if [ -d dbs/$name ];then
	echo "Database already exists"
	echo -n "Please enter another name: "
	read name
else
	mkdir dbs/$name/
	echo "Database created successfully"
	exitflag=1
fi
done
