#!/bin/bash
# @Autor         Miguel Arroyo
# @Fecha         30/08/2023
# @Descripcion   Creación de directorios para crear la BD

export ORACLE_SID=maqbda2

echo "Validando existencia de directorio para data files"

if [ -d "/u01/app/oracle/oradata/${ORACLE_SID^^}" ]; then
	echo "Directorio de data files ya existe"
else
	echo "Creando directorio para data files"
	cd /u01/app/oracle/oradata
	mkdir ${ORACLE_SID^^}
	#Cambiando dueño y grupo
	chown oracle:oinstall ${ORACLE_SID^^}
	chmod 750 ${ORACLE_SID^^}
fi;

echo "Creando carpeta para Redo Logs y control files"

if [ -d "/unam-bda/d01/app/oracle/oradata/${ORACLE_SID^^}" ]; then
	echo "El directorio de control files y redo logs ya existe"
else
	cd /unam-bda/d01
	mkdir -p app/oracle/oradata/${ORACLE_SID^^}  #-p todas las carpetas dentro
	chown -R oracle:oinstall app    #-R recursivo, no es necesario indicar todas las carpetas
	chmod -R 750 app
fi;

if [ -d "/unam-bda/d02/app/oracle/oradata/${ORACLE_SID^^}" ]; then
	echo "El directorio de control files y redo logs ya existe"
else
	cd /unam-bda/d02
	mkdir -p app/oracle/oradata/${ORACLE_SID^^}
	chown -R oracle:oinstall app
	chmod -R 750 app
fi;

if [ -d "/unam-bda/d03/app/oracle/oradata/${ORACLE_SID^^}" ]; then
	echo "El directorio de control files y redo logs ya existe"
else
	cd /unam-bda/d03
	mkdir -p app/oracle/oradata/${ORACLE_SID^^}
	chown -R oracle:oinstall app
	chmod -R 750 app
fi;

echo "Comporobando directorios"
echo "Mostrando directorio de data files"
ls -l /u01/app/oracle/oradata

echo "Mostrando directorios para control files y redo logs"
ls -l /unam-bda/d0*/app/oracle/oradata


