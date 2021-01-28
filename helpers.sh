function printMainMenu(){
	PS3="please enter a choice: "
	echo "Press 1 to create database"
	echo "Press 2 to list databases"
	echo "Press 3 to connect to database"
	echo "Press 4 to drop database"
	echo "Press 5 to exit"
}

function checkDataType(){
	case "$1" in
		"int") 
			if [[ "$2" =~ ^-?[0-9]+$ ]];then
				echo "true"
			else 
			echo "false"
			fi
			;;
		"str")	
			if [[ "$2" =~ [^a-zA-Z0-9] ]];then
				echo "false"
			else
			echo "true" 
			fi;;
		*)  echo "false"
			;;	
	esac
}

function getTableName(){
	exitflag=0

	tableName=""
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
}

function listTableContents(){
	echo "####################################"
	for val in `cat dbs/$connectDbName/$tableName`;do
		echo $val
	done
	echo "####################################"
}