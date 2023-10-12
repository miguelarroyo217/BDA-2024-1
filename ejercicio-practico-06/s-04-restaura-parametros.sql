--@Autor:	Miguel Arroyo	
--@Fecha:	23/09/2023
--@Descripción:	Restauración de parametros a nivel spfile.

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

Prompt Restaurando los valores de los parametros
alter system reset db_writer_processes scope=spfile;
alter system reset log_buffer scope=spfile;
alter system reset db_files scope=spfile;
alter system reset dml_locks scope=spfile;
alter system reset transactions scope=spfile;
alter system reset hash_area_size scope=spfile;
alter system reset sql_trace scope=memory;
alter system reset optimizer_mode scope=both;

Prompt Reiniciando instancia posterior a la restauración de parámetros
pause Presionar ENTER para continuar

connect sys/system2 as sysdba
shutdown immediate

Prompt shutdown completo, iniciando..
startup

Prompt Listo!
