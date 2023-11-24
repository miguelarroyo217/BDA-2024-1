--@Autor:	Miguel Arroyo
--@Fecha:	14/10/2023
--@Descripción:	Observación del connection pool y otros procesos

whenever sqlerror exit rollback;

Prompt Iniciando sessión desde el pool creado
connect sys@maqbda2_pooled/system2 as sysdba

Prompt Agregando un nuevo registro a la tabla t01
insert into miguel09.t01_session_data(id, sid, logon_time, username, status, server, osuser, machine, type, process, port)
  select 4 as id, sid, sql_exec_start as logon_time, username, status, server, osuser, machine, type, process, port
  from v$session where username='SYS' and type='USER';

Prompt Creando la tabla t07_foreground_process
create table miguel09.t07_foreground_process as
  select p.sosid, p.pname, s.osuser as os_username, s.username as bd_username,
  s.server, trunc((p.pga_max_mem/1024)/1024, 2) as pga_max_mem_mb, p.tracefile
  from v$process p left join v$session s
  on p.addr=s.paddr
  where p.background is null
  order by s.osuser, p.pname;

Prompt Creando la tabla t08_f_process_actual
create table miguel09.t08_f_process_actual as
  select p.sosid, p.pname, s.osuser as os_username, s.username as bd_username,
  s.server, trunc((p.pga_max_mem/1024)/1024, 2) as pga_max_mem_mb, p.tracefile
  from v$process p left join v$session s
  on p.addr=s.paddr
  where sys_context('USERENV','SID') = s.sid;

Prompt Creando la tabla t09_background_process
create table miguel09.t09_background_process as
  select p.sosid, p.pname, s.osuser as os_username, s.username as bd_username,
  s.server, trunc((p.pga_max_mem/1024)/1024, 2) as pga_max_mem_mb, p.tracefile
  from v$process p left join v$session s
  on p.addr=s.paddr
  where p.background=1
  order by s.osuser, p.pname;