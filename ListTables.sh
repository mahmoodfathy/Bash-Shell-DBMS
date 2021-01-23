#!/usr/bin/bash
# for table in $(ls dbs);do

# kdialog --title "Existing Tables" --passivepopup "$table" ;
# done 
cd dbs
kdialog --getexistingdirectory *
