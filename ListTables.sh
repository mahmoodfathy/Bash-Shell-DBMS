#!/usr/bin/bash

var=$(ls dbs/$connectDbName)

zenity --list --title="List Tables" --column="Tables" $var
