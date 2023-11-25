--@Autor:	Miguel Arroyo
--@Fecha:	24/11/2023
--@Descripción:	Administración Básica de Redo Logs

Prompt b) Mostrando información de los grupos de Redo Logs
select group#, sequence#, (bytes/1024)/1024 size_mb,
blocksize, members, status, first_change#, first_time, next_change#
from v$log;

Prompt d) Mostrando datos de los miembros de cada grupo de Redo Logs
select group#, status, type, member ruta_absoluta
from v$logfile;

Prompt e) Creando 3 nuevos grupos de Redo Logs con 2 miembros
alter database
    add logfile
    group 4 ('/unam-bda/d01/app/oracle/oradata/MAQBDA2/redo04a.log',
        '/unam-bda/d02/app/oracle/oradata/MAQBDA2/redo04b.log')
    size 80m blocksize 512;

alter database
    add logfile
    group 5 ('/unam-bda/d01/app/oracle/oradata/MAQBDA2/redo05a.log',
        '/unam-bda/d02/app/oracle/oradata/MAQBDA2/redo05b.log')
    size 80m blocksize 512;

alter database
    add logfile
    group 6 ('/unam-bda/d01/app/oracle/oradata/MAQBDA2/redo06a.log',
        '/unam-bda/d02/app/oracle/oradata/MAQBDA2/redo06b.log')
    size 80m blocksize 512;

Prompt f) Agregando un tercer miembro a cada grupo de Redo Logs
alter database
    add logfile member '/unam-bda/d03/app/oracle/oradata/MAQBDA2/redo04c.log' to group 4;

alter database
    add logfile member '/unam-bda/d03/app/oracle/oradata/MAQBDA2/redo05c.log' to group 5;

alter database
    add logfile member '/unam-bda/d03/app/oracle/oradata/MAQBDA2/redo06c.log' to group 6;

Prompt g) Ejecutando de nuevo la consulta del inciso b)
select group#, sequence#, (bytes/1024)/1024 size_mb,
blocksize, members, status, first_change#, first_time, next_change#
from v$log;

Prompt h) Ejecutando de nuevo la consulta del inciso d)
select group#, status, type, member ruta_absoluta
from v$logfile;

Prompt i) 1. Cambiando el grupo 4 como actual
alter system switch logfile;

Prompt i) 2. Mostrando nuevamete la consulta del inciso g)
select group#, sequence#, (bytes/1024)/1024 size_mb,
blocksize, members, status, first_change#, first_time, next_change#
from v$log;

Prompt j) 1. Colocando los grupos 1 a 3 como inactive
alter system checkpoint;

Prompt j) 2. Mostrando nuevamente la consulta del inciso anterior
select group#, sequence#, (bytes/1024)/1024 size_mb,
blocksize, members, status, first_change#, first_time, next_change#
from v$log;

Prompt k) 1. Eliminando los grupos 1 a 3
alter database drop logfile group 1;
alter database drop logfile group 2;
alter database drop logfile group 3;

Prompt k) 2. Verificando los resultados
select group#, sequence#, (bytes/1024)/1024 size_mb,
blocksize, members, status, first_change#, first_time, next_change#
from v$log;