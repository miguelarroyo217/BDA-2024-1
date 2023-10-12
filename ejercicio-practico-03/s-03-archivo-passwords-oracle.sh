# @Autor         Miguel Arroyo
# @Fecha         09/09/2023
# @Descripcion   Respaldo y creación de archivo de passwords

export ORACLE_SID=maqbda1

echo Creando respaldo del archivo de password en /home/${USER}/backups
cp ${ORACLE_HOME}/dbs/orapw${ORACLE_SID} /home/${USER}/backups/;

echo Verificando la existencia del respaldo
ls /home/${USER}/backups/;
if [ -f "/home/${USER}/backups/orapw${ORACLE_SID}" ]; then
  read -p "El archivo existe, [enter] para continuar, Ctrl-C para cancelar"
fi;

echo Borrando archivo de passwords
rm ${ORACLE_HOME}/dbs/orapw${ORACLE_SID};

echo Verificando la existencia de otro archivo de passwords
if [ -f "${ORACLE_HOME}/dbs/orapw${ORACLE_SID}" ]; then
  read -p "El archivo existe, [enter] para sobrescribir, Ctrl-C para cancelar"
fi;

echo Creando un nuevo archivo de passwords
orapwd \
  FORCE=Y \
  FILE='${ORACLE_HOME}/dbs/orapw${ORACLE_SID}' \
  FORMAT=12.2 \
  sys=y \
  sysbackup=y


echo "comprobando la creación del archivo"
ls -l ${ORACLE_HOME}/dbs/orapw${ORACLE_SID}
