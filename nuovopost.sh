#!/bin/bash
NOMEFILE="Nomefile"
TITOLO="Titolo"
RIASSUNTO="Riassunto del post"

read -p "Nome del file: " NOMEFILE
read -p "Titolo del post: " TITOLO
read -p "Riassunto: " RIASSUNTO

sed -i '/<div class="sinistra">/ a\
\			<div class="blocco">\
\				<h2>'"$TITOLO"'</h2>\
\				<p>'"$RIASSUNTO"'</p>\
\				<p><a href=articoli/'"$NOMEFILE"'.html>articolo completo</a></p>\
\			</div>' blog.html
sed -e 's/TitoloDaCambiare/'"$TITOLO"'/' -e  's/DescrizioneDaCambiare/'"$RIASSUNTO"'/' articoli/template.html > articoli/"$NOMEFILE".html
subl3 articoli/"$NOMEFILE".html
