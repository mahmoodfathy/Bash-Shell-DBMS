#!/usr/bin/bash

###Entry point for DBMS

clear
. ./helpers.sh
PS3="Please enter a choice: "
connectDbName=""
# echo " _   _      _ _        __        __         _     _ _ _"
# echo "| | | | ___| | | ___   \ \      / /__  _ __| | __| | | |"
# echo "| |_| |/ _ \ | |/ _ \   \ \ /\ / / _ \| '__| |/ _  | | |"
echo "  _   _      _ _        __        __         _     _ _ _
 | | | | ___| | | ___   \ \      / /__  _ __| | __| | | |
 | |_| |/ _ \ | |/ _ \   \ \ /\ / / _ \| '__| |/ _  | | |
 |  _  |  __/ | | (_) |   \ V  V / (_) | |  | | (_| |_|_|
 |_| |_|\___|_|_|\___/     \_/\_/ \___/|_|  |_|\__,_(_|_)"

options=("Press 1 to create database" "press 2 to list databases" "press 3 to connect to database" "press 4 to drop database" "press 5 to exit")
select choice in "${options[@]}"
do
	case $REPLY in
		1) . ./createdb.sh;;
		2) . ./listdbs.sh;;
		3) . ./connect.sh
		   printMainMenu;;
		4) . ./dropdb.sh;;
		5) echo "Bye"
			exit;;
		*) echo "Please enter a valid option";;
	esac	
done
