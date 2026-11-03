#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Error: numero de parametros incorrecto."
    echo "Uso: $0 <ruta_archivo> <palabra>"
    exit 1
fi

ruta="$1"
palabra="$2"

if [ -f "$ruta" ]; then
    echo "===== Contenido de $ruta ====="
    cat "$ruta"
    echo "=============================="

    echo "Buscando la palabra '$palabra' en $ruta..."
    if grep -n --color=auto "$palabra" "$ruta"; then
        echo "La palabra '$palabra' se ha encontrado en el archivo."
    else
        echo "La palabra '$palabra' no se ha encontrado en el archivo."
    fi
else
    echo "Error: la ruta '$ruta' no existe o no es un archivo."
    exit 1
fi
