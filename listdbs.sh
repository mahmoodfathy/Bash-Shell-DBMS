#!/usr/bin/bash

index=1
for db in `ls dbs/`
do
	echo $index - $db
	index=$[$index + 1]
done
