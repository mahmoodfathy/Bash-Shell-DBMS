#!/usr/bin/bash
echo -n "Please enter the database name that you want to drop:  "
read name

if [ -d dbs/$name ];then
	rm -r dbs/$name
	echo "Database dropped"
else
	echo "no such database found"
fi
