#!/bin/bash

# Preparar los datos de prueba del escenario 2
mkdir -p "$HOME/empresa_pruebas/documentos"
mkdir -p "$HOME/empresa_pruebas/scripts"

cat > "$HOME/empresa_pruebas/documentos/clientes.txt" << 'EOF'
Cliente: Ana López
Cliente: Luis García
Cliente: Marta Sánchez
EOF

cat > "$HOME/empresa_pruebas/documentos/incidencias.txt" << 'EOF'
Incidencia 001: Error de conexión
Incidencia 002: Servicio iniciado correctamente
Incidencia 003: ERROR de permisos
EOF

cat > "$HOME/empresa_pruebas/documentos/proveedores.txt" << 'EOF'
Proveedor: Acme
Estado: activo
EOF

echo "Escenario 2 preparado correctamente."
echo "Directorio de trabajo: $HOME/empresa_pruebas"
Escenario 2 preparado correctamente.
Directorio de trabajo: /root/empresa_pruebas

cd empresas_pruebas
cd scripts
nano comprobar.sh
!/bin/bash
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

./comprobar.sh                                              
Error: numero de parametros incorrecto.
Uso: ./comprobar.sh <ruta_archivo> <palabra>

./comprobar.sh ~/empresa_pruebas/documentos/clientes.txt    
Error: numero de parametros incorrecto.
Uso: ./comprobar.sh <ruta_archivo> <palabra>

./comprobar.sh ~/empresa_pruebas/documentos/clientes.txt Ana Martin
Error: numero de parametros incorrecto.
Uso: ./comprobar.sh <ruta_archivo> <palabra>

./comprobar.sh ~/empresa_pruebas/descargas/clientes.txt Ana
Error: la ruta '/root/empresa_pruebas/descargas/clientes.txt' no existe o no es un archivo.
