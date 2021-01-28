#!/usr/bin/bash

clear
index=1
echo "#################################"
for db in `ls dbs/`
do
	echo $index - $db
	index=$[$index + 1]
done
echo "#################################"
printMainMenu