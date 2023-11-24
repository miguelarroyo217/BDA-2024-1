--@Autor:	Miguel Arroyo
--@Fecha:	12/10/2023
--@Descripción:	Configuración necesaria para conectar en modo compartido

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

Prompt Configurando instancia en modo compartido
alter system set shared_servers=4 scope=memory;
alter system set dispatchers='(dispatchers=2)(protocol=tcp)' scope=memory;

Prompt Mostrando los parametros de la instancia
show parameter;

Prompt Actualizando configuración del listener
alter system register;

Prompt Mostrando la lista de servicios registrados en el listener
select program, pid, sosid, pname from v$process
where pname like 'S0%' or pname like 'D0%' order by program;
