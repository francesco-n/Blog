#!/bin/bash

DT=$(date)
IFS=''
INDEX_FILE=index

echo -n "Titolo del post: "
read TITLE

FILE_COUNT=$(( $(ls | grep -e '[0-9+]' | wc -l) + 1 )) 

printf "Creato post numero %s\n" $FILE_COUNT

touch $FILE_COUNT

printf "\e[2m%s\e[0m\n" $DT >> $FILE_COUNT
printf "\e[32m%s\e[0m\n\n" $TITLE >> $FILE_COUNT
printf "\t%s:\t%s\n" $FILE_COUNT $TITLE >> index

