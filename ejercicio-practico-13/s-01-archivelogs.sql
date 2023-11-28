--@Autor:	Miguel Arroyo
--@Fecha:	27/11/2023
--@Descripción:	Configuración de la BD en modo archived

whenever sqlerror exit rollback;

Prompt Levantando instancia
startup;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

Prompt 2.1 Creando un pfile a partir de un spfile
create pfile='$ORACLE_HOME/dbs/initmaqdba2_inicio.ora' from spfile;

Prompt 2.2 Editando el archivo de parametros
alter system set log_archive_max_processes=2 scope=spfile;
alter system set log_archive_format='arch_maqbda2_%t_%s_%r.arc' scope=spfile;
alter system set log_archive_trace=12 scope=spfile;
alter system set log_archive_dest_1='LOCATION=/unam-bda/archivelogs/MAQBDA2/disk_a MANDATORY'scope=spfile;
alter system set log_archive_dest_2='LOCATION=/unam-bda/archivelogs/MAQBDA2/disk_b' scope=spfile;
alter system set log_archive_min_succeed_dest=1 scope=spfile;

Prompt 3.0 Deteniendo instancia
shutdown;

Prompt 3.1 Iniciando instancia en modo mount
startup mount;

Prompt 3.2 Ejecutando instrucciones para habilitar el modo archivelog
alter database archivelog;
alter database open;

Prompt 3.3 Deteniendo la instancia
shutdown;

Prompt 3.4 Abriendo la BD
startup;

Prompt 4. Verificando los cambios en la BD
archive log list;

Prompt 5. Respaldando nuevamente el spfile empleando un pfile

create pfile='$ORACLE_HOME/dbs/initmaqbda2_copia.ora' from spfile;