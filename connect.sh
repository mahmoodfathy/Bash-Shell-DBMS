#!/usr/bin/bash
PS3="Please select a database operation: "

function printMainMenu(){
	clear
	PS3="please enter a choice: "
	echo "Press 1 to create database"
	echo "Press 2 to list databases"
	echo "Press 3 to connect to database"
	echo "Press 4 to drop database"
	echo "Press 5 to exit"
}

dboptions=("Create table" "List tables" "Drop Table" "Insert into table" "Select from table" "Delete from table" "Update table" "Back to main menu")

select ch in "${dboptions[@]}"
do
	case $REPLY in 
		1) echo "create table";;
		2) echo "List table";;
		3) echo "Drop table";;
		4) echo "insert";;
		5) echo "select";;
		6) echo "delete from";;
		7) echo "update";;
		8) 
		   printMainMenu
		   break;;
		*) echo "Please enter a valid option";;
	esac
done
