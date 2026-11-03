#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Error: debes indicar exactamente una ruta de directorio." >&2
    exit 1
fi

directorio=$1

if [[ ! -d "$directorio" ]]; then
    echo "Error: '$directorio' no existe o no es un directorio." >&2
    exit 1
fi

contador=0

for archivo in "$directorio"/*.txt; do
    [[ -f "$archivo" ]] || continue

    nombre=${archivo##*/}
    ultima_linea=$(tail -n 1 -- "$archivo")
    primera_linea=$(head -n 1 -- "$archivo")
    numero_lineas=$(wc -l < "$archivo")
    numero_lineas=${numero_lineas//[[:space:]]/}

    printf 'Nombre de Archivo: %s\n' "$nombre"
    printf 'Ultima linea: %s\n' "$ultima_linea"
    printf 'Primera linea: %s\n' "$primera_linea"
    printf 'Numero de lineas: %s\n\n' "$numero_lineas"

    contador=$((contador + 1))
done

printf 'Total de archivos procesados: %s\n' "$contador"
```
