--@Autor:	Miguel Arroyo
--@Fecha:	14/10/2023
--@Descripción:	Realiza consultas en modo compartido

whenever sqlerror exit rollback;

Prompt Ingresando en modo compartido
connect sys@maqbda2_shared/system2 as sysdba

Prompt Creando la tabla t02_dispatcher_config
create table miguel09.t02_dispatcher_config as
  select 1 as id, dispatchers, connections, sessions, service
  from v$dispatcher_config;
  
Prompt Creando la tabla t03_dispatcher
create table miguel09.t03_dispatcher as
  select 1 as id, name, network, status, messages,
  trunc((bytes/1024)/1024, 2) as messages_mb, created as circuits_created, trunc(idle/6000, 2) as idle_min
  from v$dispatcher;

Prompt Creando la tabla t04_shared_server
create table miguel09.t04_shared_server as
  select 1 as id, name, status, messages, trunc((bytes/1024)/1024, 2) as messages_mb, 
  requests, trunc(idle/6000, 2) as idle_min, trunc(busy/6000, 2) as busy_min
  from v$shared_server;

Prompt Creando la tabla t05_queue
create table miguel09.t05_queue as
  select 1 as id, queued, wait, totalq
  from v$queue;

Prompt Creando la tabla t06_virtual_circuit
create table miguel09.t06_virtual_circuit as
  select 1 as id, c.circuit, d.name, c.server, c.status, c.queue
  from v$circuit c join v$dispatcher d
  on c.dispatcher=d.paddr;
