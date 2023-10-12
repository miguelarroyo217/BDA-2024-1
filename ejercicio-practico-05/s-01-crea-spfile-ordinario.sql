--@Autor:          Miguel Arroyo
--@Fecha creación:  29/08/2023
--@Descripción: Creación de un SPFILE

Prompt conectando como SYS empleando archivo de passwords
connect sys/hola1234* as sysdba

Prompt creando un SPFILE a partir de un PFILE
create spfile from pfile;

Prompt verificando su existencia
--ejecuta un comando del sistema operativo
!ls ${ORACLE_HOME}/dbs/spfilemaqbda2.ora

Prompt Listo!

--como ejecutar:
-- en una terminal con usuario admin u ordinario
--cambiarse al directorio donde se encuentra el script
-- sqlplus /nolog
-- start s-01-crea-spfile-ordinario.sql
