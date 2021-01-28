#!/usr/bin/bash
#@todo , handle cancel event and add a nice decription of the tables in the cli

var=$(ls -I "*.types" dbs/$connectDbName)

zenity --list --title="List Tables" --column="Tables" $var
