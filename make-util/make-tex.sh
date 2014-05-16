#!/bin/sh

input="$1"
output="$2"

error()
{
	test -n "$1" && echo "$0: $1" >&2
	exit 1
}

pdflatex="pdflatex -interaction=nonstopmode"
command -v pdflatex >/dev/null 2>/dev/null \
	|| error "comando «pdflatex» no encontrado"

test -f "$input" || error "fichero «$input» no encontrado."
echo "$input" | grep -qe "\.tex$" || error "la extensión debe ser «.tex»."

dir=`dirname "$input"`
name=`basename "$input" | sed -e "s/\.tex$//"`

cd "$dir" || error
rm -f *.aux *.dvi *.log *.out *.toc *.synctex.gz
echo "compilando «$input»..."
$pdflatex "$name.tex" >/dev/null 2>/dev/null &
pid=$!
while test -d "/proc/$pid"; do sleep 0.5; done
echo "compilando «$input» de nuevo (para el índice)..."
$pdflatex "$name.tex" >/dev/null
exitcode=$?

rm -f *.aux *.dvi *.log *.out *.toc *.synctex.gz
test $exitcode -eq 0 || error

cd -
i="`readlink -f "$dir/$name.pdf"`" || error
o="`readlink -f "$output"`" || error
test "$i" = "$o" || mv -f "$i" "$o"

