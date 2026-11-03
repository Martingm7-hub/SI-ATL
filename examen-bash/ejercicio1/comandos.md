mkdir academia
cd academia
mkdir material inscripciones copias temporal
cd material
nano alumnos.txt
nano cursos.txt
nano docentes.txt
tree
.
|-- alumnos.txt
|-- cursos.txt
`-- docentes.txt
nano alumnos.txt "Añadimos los nombres"
cp alumnos.txt ../copias
cd ..
cd copias
tree
.
`-- alumnos.txt
cd material
mv docentes.txt ../inscripciones
mv cursos.txt cursos_antiguos.txt
cd ..
tree
.
|-- copias
|   `-- alumnos.txt
|-- inscripciones
|   `-- docentes.txt
|-- material
|   |-- alumnos.txt
|   `-- cursos_antiguos.txt
`-- temporal
