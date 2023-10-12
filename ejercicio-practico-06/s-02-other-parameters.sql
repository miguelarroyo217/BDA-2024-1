--@Autor:	Miguel Arroyo
--@Fecha:	19/09/2023
--@Descripción:	Creación de nuevos paramteros para la instancia

whenever sqlerror exit rollback;

Prompt Iniciando sesión como sysdba
connect sys/system2 as sysdba

Prompt Creando una nueva tabla
create table miguel06.t02_other_parameters as
	select num,name,value,default_value,isses_modifiable as is_session_modifiable,
		issys_modifiable as is_system_modifiable
	from v$system_parameter
	where name in (
		'cursor_invalidation','optimizer_mode',
		'sql_trace','sort_area_size','hash_area_size','nls_date_format',
		'db_writer_processes','db_files','dml_locks','log_buffer','transactions'
	);


