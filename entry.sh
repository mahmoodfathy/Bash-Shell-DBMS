#!/usr/bin/bash

###Entry point for DBMS
clear
PS3="Please enter a choice: "

options=("Press 1 to create database" "press 2 to list databases" "press 3 to connect to database" "press 4 to drop database" "press 5 to exit")
select choice in "${options[@]}"
do
	case $REPLY in
		1) . ./createdb.sh;;
		2) . ./listdbs.sh;;
		3) . ./connect.sh;;
		4) . ./dropdb.sh;;
		5) echo "Bye"
			exit;;
		*) echo "Please enter a valid option";;
	esac	
done
