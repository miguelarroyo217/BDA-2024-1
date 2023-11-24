--@Autor:	Miguel Arroyo
--@Fecha:	13/10/2023
--@Descripción:	Realiza conexiones en diferentes modos

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

Prompt Creando la tabla t01_session_data
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
create table miguel09.t01_session_data as
  select 1 as id, sid, sql_exec_start as logon_time, username, status, server, osuser, machine, type, process, port
  from v$session where username='SYS' and type='USER';

Prompt Haciendo commit tras el primer registro en la tabla t01
commit;

Prompt Ingresando en modo dedicado.
connect sys@maqbda2_dedicated/system2 as sysdba

Prompt Ingresando un nuevo registro en la tabla t01
alter session set nls_date_format='dd/mm/yyyy hh24:mi:ss';
insert into miguel09.t01_session_data(id, sid, logon_time, username, status, server, osuser, machine, type, process, port)
  select 2 as id, sid, sql_exec_start as logon_time, username, status, server, osuser, machine, type, process, port
  from v$session where username='SYS' and type='USER';

Prompt Haciendo commit tras el segundo registro en la tabla
commit;

Prompt Ingresando en modo compartido
connect sys@maqbda2_shared/system2 as sysdba

Prompt Agregando un nuevo registro a la tabla t01
insert into miguel09.t01_session_data(id, sid, logon_time, username, status, server, osuser, machine, type, process, port)
  select 3 as id, sid, sql_exec_start as logon_time, username, status, server, osuser, machine, type, process, port
  from v$session where username='SYS' and type='USER';

Prompt Haciendo commit tras el tercer registro de la tabla.
commit;