#!/bin/bash

# Preparar los datos de prueba del escenario 1
mkdir -p "$HOME/datos_busqueda/archivos"

cat > "$HOME/datos_busqueda/bash.txt" << 'EOF'
Bash permite automatizar tareas.
Los scripts facilitan la administracion de sistemas.
BASH es un interprete de comandos.
EOF

cat > "$HOME/datos_busqueda/linux.txt" << 'EOF'
Linux es un sistema operativo.
Permite gestionar usuarios y archivos.
Se utiliza habitualmente en servidores.
EOF

cat > "$HOME/datos_busqueda/scripts.txt" << 'EOF'
Los scripts permiten automatizar tareas.
Un script Bash puede utilizar variables y bucles.
EOF

cat > "$HOME/datos_busqueda/archivos/errores.txt" << 'EOF'
Error de conexion.
Servicio iniciado correctamente.
ERROR de permisos.
EOF

touch "$HOME/datos_busqueda/vacio.txt"

echo "Escenario 1 preparado correctamente."
echo "Directorio de datos: $HOME/datos_busqueda"

find datos_busqueda "*.txt"
datos_busqueda
datos_busqueda/archivos
datos_busqueda/archivos/errores.txt
datos_busqueda/vacio.txt
datos_busqueda/scripts.txt
datos_busqueda/bash.txt
datos_busqueda/linux.txt

cd datos_busqueda
grep "BASH" bash.txt
BASH es un interprete de comandos.
wc -l linux.txt
3 linux.txt
head -n 2 scripts.txt
Los scripts permiten automatizar tareas.
Un script Bash puede utilizar variables y bucles.
cd archivos
tail -n 1 errores.txt
ERROR de permisos.
