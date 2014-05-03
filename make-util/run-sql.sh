#!/bin/sh

sql="$1"
login="$2"

error()
{
	test -n "$1" && echo "$0: $1" >&2
	exit 1
}

test -f "$sql" || error "fichero «$sql» no encontrado"
command -v sqlplus >/dev/null 2>/dev/null \
	|| error "comando «sqlplus» no encontrado"

if test -z "$login"; then
	printf "\nIntroduce tus credenciales de Oracle.\nUsuario: "
	read user
	stty -echo
	printf "Contraseña: "
	read pass
	stty echo
	login="$user/$pass"
fi

printf "\n\n"
echo "@$sql;" | sqlplus -s "$login"

