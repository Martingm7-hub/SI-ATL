# Chuletilla de Bash

*Resumen de los comandos y conceptos de la batería de ejercicios (bloques 1 a 5).*

## 1. Navegación y consulta del sistema

| Comando | Qué hace | Ejemplo |
|---|---|---|
| `pwd` | Muestra dónde estás | `pwd` |
| `ls` | Lista el contenido | `ls` |
| `ls -a` | Incluye archivos ocultos (empiezan por `.`) | `ls -a` |
| `ls -l` | Lista detallada: permisos, propietario, tamaño, fecha | `ls -l` |
| `ls -la` | Detallada + ocultos | `ls -la` |
| `man comando` | Manual del comando (salir con `q`) | `man ls` |
| `clear` | Limpia la pantalla (también `Ctrl+L`) | `clear` |
| `history` | Historial de comandos | `history` |
| `tree` | Estructura en árbol (puede requerir instalarlo: `sudo apt install tree`) | `tree practica_bash` |

**Rutas**

- `~` = directorio personal (home). `.` = directorio actual. `..` = directorio padre.
- **Absoluta**: empieza por `/` o `~` → `cd ~/practica_bash`
- **Relativa**: parte de donde estás → `cd documentos/informes`
- `cd` solo (o `cd ~`) → vuelve al home. `cd -` → vuelve al directorio anterior.

**Atajos útiles:** `Tab` autocompleta · `↑`/`↓` recorre el historial · `Ctrl+C` cancela · `!!` repite el último comando.

## 2. Directorios y archivos

### Crear estructura

```bash
mkdir practica_bash                      # un directorio
mkdir -p documentos/texto documentos/informes   # -p crea también los padres
mkdir documentos scripts copias temporal # varios a la vez
touch apuntes.txt tareas.txt             # crea archivos vacíos (varios a la vez)
```

### Escribir y ver contenido

```bash
echo "Mi primera práctica" > apuntes.txt     # > SOBRESCRIBE el archivo
echo "Otra línea" >> apuntes.txt             # >> AÑADE al final (no borra)
echo "Fecha: $(date +%d/%m/%Y)" >> apuntes.txt   # $(...) inserta el resultado de un comando
cat apuntes.txt                              # muestra el contenido
nano tareas.txt                              # editor de texto
```

**Atención:** `>` borra lo anterior, `>>` conserva. Es el error más típico del ejercicio 6.

### Nano: teclas básicas

| Acción | Teclas |
|---|---|
| Guardar | `Ctrl+O` y luego `Enter` |
| Salir | `Ctrl+X` |
| Cortar línea / pegar | `Ctrl+K` / `Ctrl+U` |
| Buscar | `Ctrl+W` |

### Copiar, mover, renombrar, borrar

```bash
cp origen destino          # copiar (el original se conserva)
cp apuntes.txt ../../copias/
mv origen destino          # MOVER (el original desaparece de su sitio)
mv lectura.txt lectura_final.txt   # mv también RENOMBRA
rm archivo                 # borra un archivo
rm archivo1 archivo2       # borra varios
rmdir directorio           # borra SOLO directorios vacíos
```

- `rmdir` falla con *"Directory not empty"* si el directorio contiene algo: hay que borrar antes su contenido (`rm`) y luego el directorio.
- `rm -r directorio` borra un directorio con todo su contenido. **Cuidado**: no pide confirmación y no se puede deshacer. Úsalo solo en lo que hayas creado tú.
- **Copiar vs mover:** `cp` deja dos archivos independientes (modificar uno no cambia el otro); `mv` solo cambia el archivo de sitio.

## 3. Permisos

Salida de `ls -l`:

```
-rwxr-xr--  1 usuario grupo  120 nov 2 10:00 prueba.sh
│└┬┘└┬┘└┬┘
│ │  │  └─ otros
│ │  └──── grupo
│ └─────── propietario (u)
└───────── tipo: - archivo, d directorio
```

| Letra | Significado | Valor |
|---|---|---|
| `r` | lectura | 4 |
| `w` | escritura | 2 |
| `x` | ejecución | 1 |
| `-` | sin permiso | 0 |

La cifra de cada grupo es la **suma** de sus valores: `rwx`=7, `r-x`=5, `r--`=4, `rw-`=6.

### chmod simbólico

```bash
chmod u+x prueba.sh      # u=propietario, g=grupo, o=otros, a=todos
chmod g-w prueba.sh      # + añade, - quita, = fija
chmod o+r prueba.sh
chmod u=rwx,g=rx,o=r prueba.sh
```

### chmod numérico

```bash
chmod 754 prueba.sh      # rwx r-x r--
chmod 644 archivo.txt    # rw- r-- r--  (permisos típicos de un archivo nuevo)
chmod 755 script.sh      # rwx r-x r-x
```

**Resultado del ejercicio 13:** `rwxr-xr--` = `754`.

Un archivo nuevo suele crearse con `rw-r--r--` (644): sin permiso de ejecución. Por eso hay que hacer `chmod u+x` antes de lanzar un script con `./`.

## 4. Scripts: estructura básica

```bash
#!/bin/bash
# Comentario: describe qué hace el script
echo "Hola"
```

1. Crear con `nano saludo.sh`.
2. Dar permiso: `chmod u+x saludo.sh`.
3. Ejecutar: `./saludo.sh` (el `./` indica "en este directorio").

También se puede ejecutar sin permiso con `bash saludo.sh`.

### Variables

```bash
nombre="Martín"              # SIN espacios alrededor del =
curso="DAM"
echo "Soy $nombre y estudio $curso"   # $ para usar el valor
echo "Soy ${nombre}Gorlat"            # llaves si va pegado a otro texto
```

- Comillas dobles `" "`: expanden variables. Comillas simples `' '`: texto literal (`'$nombre'` imprime `$nombre`).
- **Error típico:** `nombre = "Martín"` (con espacios) **no funciona**.

### Parámetros

| Variable | Significado |
|---|---|
| `$0` | Nombre del script |
| `$1`, `$2`, ... | Primer, segundo... parámetro |
| `$#` | Número de parámetros recibidos |
| `$@` | Todos los parámetros |

```bash
#!/bin/bash
echo "Hola $1, tienes $2 años"
```

```bash
./presentacion.sh Ana 20
./presentacion.sh "Luis Pérez" 35     # comillas si el valor lleva espacios
```

## 5. Condicionales

### Estructura

```bash
if [ condición ]; then
    comandos
elif [ otra_condición ]; then
    comandos
else
    comandos
fi
```

**Los espacios dentro de `[ ]` son obligatorios:** `[ "$1" -gt 5 ]` ✔ · `["$1" -gt 5]` ✘

### Comparación de números

| Operador | Significa |
|---|---|
| `-eq` | igual (=) |
| `-ne` | distinto (≠) |
| `-gt` | mayor que (>) |
| `-lt` | menor que (<) |
| `-ge` | mayor o igual (≥) |
| `-le` | menor o igual (≤) |

### Comparación de textos

| Operador | Significa |
|---|---|
| `=` | iguales |
| `!=` | distintos |
| `-z "$x"` | cadena vacía |
| `-n "$x"` | cadena no vacía |

### Pruebas sobre archivos

| Prueba | Es verdadera si... |
|---|---|
| `-e ruta` | la ruta existe (sea lo que sea) |
| `-f ruta` | existe y es un **archivo normal** |
| `-d ruta` | existe y es un **directorio** |
| `-r ruta` | tiene permiso de **lectura** para quien ejecuta |
| `-w ruta` | tiene permiso de **escritura** para quien ejecuta |
| `-x ruta` | tiene permiso de **ejecución** para quien ejecuta |

Negación con `!`: `[ ! -d "$1" ]` = "no es un directorio".

Combinar condiciones: `[ -f "$1" ] && [ -r "$1" ]` (y) · `[ "$a" -eq 1 ] || [ "$a" -eq 2 ]` (o).

### Buenas prácticas

- **Pon siempre las variables entre comillas**: `"$1"`. Evita fallos con espacios o parámetros vacíos.
- Comprueba primero los **errores** (`$#` incorrecto, ruta inexistente) y termina con `exit 1`.
- Termina con `exit 0` si todo ha ido bien.

## 6. Plantillas para los ejercicios de scripts

### Ej. 17: comprobar número de parámetros

```bash
#!/bin/bash
if [ "$#" -eq 2 ]; then
    echo "Parámetros recibidos: $1 y $2"
else
    echo "Uso: $0 <parametro1> <parametro2>"
    exit 1
fi
```

### Ej. 18: comparar dos números

```bash
#!/bin/bash
if [ "$1" -gt "$2" ]; then
    echo "$1 es mayor que $2"
elif [ "$1" -lt "$2" ]; then
    echo "$1 es menor que $2"
else
    echo "$1 y $2 son iguales"
fi
```

Pruebas: `./comparar.sh 5 3`, `3 5`, `4 4`, `-2 1`, `0 0`.

### Ej. 19: ¿archivo, directorio o nada?

```bash
#!/bin/bash
if [ -f "$1" ]; then
    echo "$1 es un archivo"
elif [ -d "$1" ]; then
    echo "$1 es un directorio"
else
    echo "$1 no existe"
fi
```

### Ej. 20: positivo, negativo o cero

```bash
#!/bin/bash
if [ "$1" -gt 0 ]; then
    echo "Positivo"
elif [ "$1" -lt 0 ]; then
    echo "Negativo"
else
    echo "Cero"
fi
```

### Ej. 21: añadir texto a un archivo si existe

```bash
#!/bin/bash
if [ -f "$1" ]; then
    echo "$2" >> "$1"
    echo "Texto añadido a $1"
else
    echo "Error: $1 no existe"
    exit 1
fi
```

### Ej. 22: ¿tiene permiso de ejecución?

```bash
#!/bin/bash
if [ ! -e "$1" ]; then
    echo "Error: la ruta no existe"
    exit 1
elif [ -x "$1" ]; then
    echo "$1 tiene permiso de ejecución"
else
    echo "$1 NO tiene permiso de ejecución"
fi
```

### Ej. 23: copia de seguridad

```bash
#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Uso: $0 <archivo_origen> <directorio_destino>"
    exit 1
elif [ ! -f "$1" ]; then
    echo "Error: $1 no existe o no es un archivo normal"
    exit 1
elif [ ! -d "$2" ]; then
    echo "Error: el directorio $2 no existe"
    exit 1
else
    cp "$1" "$2"
    echo "Copia realizada: $1 -> $2"
fi
```

### Ej. 24: organizador

```bash
#!/bin/bash
if [ "$#" -lt 2 ]; then
    echo "Uso: $0 <origen> <destino> [archivo_a_copiar]"
    exit 1
fi

origen="$1"
destino="$2"
archivo="$3"

if [ ! -d "$origen" ]; then
    echo "Error: el origen $origen no existe"; exit 1
elif [ ! -d "$destino" ]; then
    echo "Error: el destino $destino no existe"; exit 1
fi

echo "Archivos en $origen:"
ls "$origen"

if [ -n "$archivo" ]; then
    if [ -f "$origen/$archivo" ]; then
        cp "$origen/$archivo" "$destino"
        echo "Copiado $archivo a $destino"
    else
        echo "Error: $archivo no existe en $origen"
        exit 1
    fi
else
    echo "No se ha indicado archivo a copiar. Solo se ha mostrado el listado."
fi
```

## 7. Errores típicos

| Síntoma | Causa probable | Solución |
|---|---|---|
| `Permission denied` al ejecutar `./script.sh` | Falta permiso de ejecución | `chmod u+x script.sh` |
| `command not found` | Falta `./` o la ruta | `./script.sh` |
| `[: missing ]` o `[: =: unary operator expected` | Faltan espacios en `[ ]` o comillas en `"$1"` | `[ "$1" -eq 5 ]` |
| `integer expression expected` | Comparas con `-eq/-gt` algo que no es un número | Revisa el parámetro |
| `nombre: command not found` | Espacios alrededor de `=` en una variable | `nombre="Ana"` |
| `rmdir: Directory not empty` | El directorio tiene contenido | Borra antes el contenido |
| El archivo se queda vacío | Usaste `>` en vez de `>>` | `>>` para añadir |
| `No such file or directory` | Ruta mal escrita o relativa desde otro sitio | Comprueba con `pwd` y `ls` |
| `bad interpreter` / `^M` | Archivo con saltos de línea de Windows | `sed -i 's/\r$//' script.sh` |

## 8. Resumen de una línea

- Ver: `ls -la` · `cat` · `tree` · `man` · `history`
- Crear: `mkdir -p` · `touch` · `echo >>` · `nano`
- Mover/copiar/borrar: `mv` · `cp` · `rm` · `rmdir`
- Permisos: `chmod u+x` · `chmod 754` · `ls -l`
- Scripts: `#!/bin/bash` · `$1 $2 $#` · `if [ ] then elif else fi` · `-f -d -e -x`

## 9. find, grep, wc, head y tail

### find: buscar archivos por nombre o tipo

```bash
find ruta -type f                 # todos los archivos normales
find ruta -type d                 # todos los directorios
find ruta -name "*.txt"           # nombre que termina en .txt
find ruta -iname "*.txt"          # igual, ignorando mayúsculas
find . -type f -name "*.sh"       # combinar condiciones
```

- Estructura: `find <dónde buscar> <condiciones>`. `.` = el directorio actual.
- **Pon el patrón entre comillas** (`"*.txt"`), si no la shell puede expandir el `*` antes de tiempo.
- `-type f` = archivos normales, `-type d` = directorios.

### grep: buscar texto dentro de archivos

```bash
grep "Linux" linux.txt            # líneas que contienen Linux
grep -i "bash" archivo.txt        # ignora mayúsculas y minúsculas
grep -n "Linux" linux.txt         # muestra el número de línea
grep -c "Linux" linux.txt         # cuenta las líneas que coinciden
grep -v "Linux" linux.txt         # líneas que NO contienen Linux
grep -r "bash" carpeta/           # busca en todos los archivos de la carpeta
grep -ri "bash" carpeta/          # recursivo e ignorando mayúsculas
```

| Opción | Significado |
|---|---|
| `-i` | ignorar mayúsculas/minúsculas |
| `-n` | mostrar número de línea |
| `-c` | contar líneas con coincidencia |
| `-v` | invertir (líneas sin la palabra) |
| `-r` | recursivo (entra en subdirectorios) |
| `-w` | palabra completa |

### wc, head y tail: contar y recortar

```bash
wc -l bash.txt          # número de líneas (muestra también el nombre)
wc -l < bash.txt        # solo el número
head -n 1 bash.txt      # primera línea
tail -n 1 bash.txt      # última línea
head -n 5 bash.txt      # primeras 5 líneas
tail -n 5 bash.txt      # últimas 5 líneas
```

- Un archivo vacío (`touch vacio.txt`) da `0` con `wc -l vacio.txt`.
- `wc -l` cuenta saltos de línea: si la última línea no termina en Enter, no la cuenta.

### Qué comando va con cada tipo de pregunta

| Si el enunciado dice... | Usa |
|---|---|
| «muestra todos los archivos normales de X» | `find X -type f` |
| «archivos cuyo nombre termine en .txt» | `find . -name "*.txt"` |
| «líneas que contienen la palabra Linux en linux.txt» | `grep "Linux" linux.txt` |
| «ignorando mayúsculas y minúsculas» | `grep -i "bash" archivo` |
| «cuenta cuántas líneas tiene» | `wc -l archivo` |
| «primera línea» | `head -n 1 archivo` |
| «última línea» | `tail -n 1 archivo` |
| «archivo vacío, cuántas líneas» | `wc -l vacio.txt` (da 0) |

**Tuberías (`|`):** la salida de un comando entra en el siguiente. Ej.: `grep -i "bash" archivo.txt | wc -l` cuenta cuántas líneas contienen bash.
