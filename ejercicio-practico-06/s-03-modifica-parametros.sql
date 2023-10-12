--@Autor:	Miguel Arroyo
--@Fecha:	19/09/2023
--@Descripción:	Modificación de Parametros

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

Prompt Modificando parametros
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
alter system set db_writer_processes=2 scope=spfile;
alter system set log_buffer=10485760 scope=spfile;
alter system set db_files=250 scope=spfile;
alter system set dml_locks=2500 scope=spfile;
alter system set transactions=600 scope=spfile;
alter session set hash_area_size=2097152;
alter system set hash_area_size=2097152 scope=spfile;
alter session set sort_area_size=1048576;
alter system set sql_trace=true scope=memory;
alter system set optimizer_mode='FIRST_ROWS_100' scope=both;
alter session set cursor_invalidation='DEFERRED';

Prompt Creando la tabla 3
create table miguel06.t03_update_param_session as
	select name,value
	from v$parameter
	where name in (
		'cursor_invalidation','optimizer_mode',
		'sql_trace','sort_area_size','hash_area_size','nls_date_format',
		'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
	)
	and value is not null;

Prompt Creando la tabla 4
create table miguel06.t04_update_param_instance as
        select name,value
        from v$system_parameter
        where name in (
                'cursor_invalidation','optimizer_mode',
                'sql_trace','sort_area_size','hash_area_size','nls_date_format',
                'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
        )
        and value is not null;

Prompt Creando la tabla 5
create table miguel06.t05_update_param_spfile as
        select name,value
        from v$spparameter
        where name in (
                'cursor_invalidation','optimizer_mode',
                'sql_trace','sort_area_size','hash_area_size','nls_date_format',
                'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
        )
        and value is not null;

Prompt Creando un PFILE a partir del SPFILE
create pfile='/unam-bda/ejercicios-practicos/ejercicio-practico-06/e-03-spparameter-pfile.txt' from spfile;

Prompt Mostrando el contenido del archivo e-03-spparameter-pfile.txt
!cat /unam-bda/ejercicios-practicos/ejercicio-practico-06/e-03-spparameter-pfile.txt | grep "*."


