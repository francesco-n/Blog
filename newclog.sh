#!/bin/bash

FILE_COUNT=$(( $(ls clog | grep -e '[0-9+]' | wc -l) + 1 )) 

read -p "Post title: " TITLE
read -p "File to copy: (type n if you want to create a new post) " HTMLFILE
if [ $HTMLFILE != "n" ]
then
	HTMLFILE="articoli/$HTMLFILE"
	if [ ! -f $HTMLFILE ]
	then
		echo "File does not exist" >&2
		exit
	else
		TEXT=$(grep -o '<[p|h][1-9]*[^>]*>.*</[p|h][1-9]*>' $HTMLFILE | \
			sed -e 's/<h[1-9][^>]*>/\o033[32m/' \
	    		-e 's/<\/h[1-9]>/\o033[0m/' \
	    		-e 's/<strong>/\o033[4m/' \
	    		-e 's/<\/strong>/\o033[0m/' \
	    		-e '/<\/p>/ a\
			' | \
			sed 's/<[^>]*>//g')
			# Substitutes <h> tags with color green
			# Substitutes <strong> tags with underline
			# Adds a newline when paragraph ends
			# Removes all other tags
		printf "$TEXT" >> clog/$FILE_COUNT
	fi
else
	printf "\e[32m%s\e[0m\n\n" $TITLE >> clog/$FILE_COUNT
fi

printf "\t%s:\t%s\n" $FILE_COUNT "$TITLE" >> clog/index
vim clog/$FILE_COUNT

printf "Created post number %s\n" $FILE_COUNT
