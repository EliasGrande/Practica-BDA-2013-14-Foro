#!/bin/sh

input="$1"
output="$2"

error()
{
	test -n "$1" && echo "$0: $1" >&2
	exit 1
}

compila="`readlink -m "$0/../compila.sh"`" || error

test -f "$input" || error "fichero «$input» no encontrado"
echo "$input" | grep -qe "\.pc$" || error "la extensión debe ser «.pc»"

dir=`dirname "$input"`
name=`basename "$input" | sed -e "s/\.pc$//"`

cd "$dir" || error
rm -f "$name.o" "$name.c" "$name.lis"
"$compila" "$name"
#exitcode=$?

#test $exitcode -eq 0 || error

cd -
i="`readlink -f "$dir/$name"`" || error
o="`readlink -m "$output"`" || error
test "$i" = "$o" || mv -f "$i" "$o"

