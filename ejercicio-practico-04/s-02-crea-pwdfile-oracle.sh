#!/bin/bash
# @Autor         Miguel Arroyo
# @Fecha         29/08/2023
# @Descripcion   Creación de un archivo de passwords.

echo "Creando archvivo de passwords"
#Se debe ubicar en ${ORACLE_HOME}/dbs/orapw${ORACLE_SID}

#cambiar iniciales
export ORACLE_SID=maqbda2

if [ -f "${ORACLE_HOME}/dbs/orapw${ORACLE_SID}" ]; then
  read -p "El archivo existe, [enter] para sobrescribir, Ctrl-C para cancelar"
fi;

#En caso de no escribir Ctrl-C, el script continua
orapwd \
  FORCE=Y \
  FILE='${ORACLE_HOME}/dbs/orapw${ORACLE_SID}' \
  FORMAT=12.2 \
  SYS=hola1234*

echo "comprobando la creación del archivo"
ls -l ${ORACLE_HOME}/dbs/orapwmaqbda2
