#!/bin/bash

DT=$(date)
INDEX_FILE=index
HTMLFILE="articoli/indipendenzadigitale.html"

FILE_COUNT=$(( $(ls clog | grep -e '[0-9+]' | wc -l) + 1 )) 

echo -n "Titolo del post: "
read TITLE
read -p "File da copiare (n se vuoi crearne uno nuovo): " HTMLFILE
if [ $HTMLFILE != "n" ]
then
	HTMLFILE="articoli/$HTMLFILE"
	if [ ! -f $HTMLFILE ]
	then
		echo "Il file non esiste!" >&2
		exit
	else
		#printf "\e[2m%s\e[0m\n" $DT >> clog/$FILE_COUNT
		#printf "\e[32m%s\e[0m\n\n" $TITLE >> clog/$FILE_COUNT
		TESTO=$(grep -o '<[p|h][1-9]*[^>]*>.*</[p|h][1-9]*>' $HTMLFILE | \
			sed -e 's/<h[1-9][^>]*>/\o033[32m/' \
	    		-e 's/<\/h[1-9]>/\o033[0m/' \
	    		-e 's/<strong>/\o033[4m/' \
	    		-e 's/<\/strong>/\o033[0m/' \
	    		-e '/<\/p>/ a\
			'  \
			-e '/<br>/ a\
			' | \
			sed 's/<[^>]*>//g')
		printf "$TESTO" >> clog/$FILE_COUNT
	fi
else
	printf "\e[32m%s\e[0m\n\n" $TITLE >> clog/$FILE_COUNT
fi

printf "\t%s:\t%s\n" $FILE_COUNT "$TITLE" >> clog/index
vim clog/$FILE_COUNT

printf "Creato post numero %s\n" $FILE_COUNT
