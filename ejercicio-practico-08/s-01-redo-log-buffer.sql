--@Autor:       Miguel Arroyo
--@Fecha:       05/10/2023
--@Descripción: Información sobre el redo log buffer

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

Prompt Creando la tabla t01_redo_log_buffer
create table miguel08.t01_redo_log_buffer as(
  select (vp.value/1024)/1024 as redo_buffer_size_param_mb, (vsga.bytes/1024)/1024 as redo_buffer_sga_info_mb, vsga.resizeable 
  from v$parameter vp, v$sgainfo vsga 
  where vp.name='log_buffer' and vsga.name='Redo Buffers');

Prompt Mostrando información de la tabla t01_redo_log_buffer
select * from miguel08.t01_redo_log_buffer;