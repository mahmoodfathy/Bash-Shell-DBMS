#!/usr/bin/bash

var=$(ls dbs)

zenity --list --title="List Tables" --column="Tables" $var
