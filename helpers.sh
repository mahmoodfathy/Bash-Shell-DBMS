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