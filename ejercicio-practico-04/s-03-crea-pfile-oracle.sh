#!/bin/bash
# @Autor         Miguel Arroyo
# @Fecha         29/08/2023
# @Descripcion   Creación de un PFILE 
# @Modificación  30/08/2023 Corrección de carpetas para control

echo "Creando un pfile"
#ajustar
export ORACLE_SID=maqbda2

pfile="${ORACLE_HOME}/dbs/init${ORACLE_SID}.ora"

if [ -f "${pfile}" ]; then
  read -p "El archivo ${pfile} ya existe, [enter] para sobrescribir"
fi;

echo \
"
db_name='${ORACLE_SID}'
memory_target=768M
control_files=(
  /unam-bda/d01/app/oracle/oradata/${ORACLE_SID^^}/control01.ctl,
  /unam-bda/d02/app/oracle/oradata/${ORACLE_SID^^}/control02.ctl,
  /unam-bda/d03/app/oracle/oradata/${ORACLE_SID^^}/control03.ctl,
)
" > ${pfile} 

echo "Comprobando la existencia y contenido del PFILE"
echo ""
cat ${pfile}
