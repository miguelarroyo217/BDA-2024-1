--@Autor:	Miguel Arroyo
--@Fecha:	15/10/2023
--@Descripción:	Configuración necesaria para resetear el conecction pool

whenever sqlerror exit rollback;

Prompt Iniciando sesión como sysdba (modo dedicado)
connect sys/system2 as sysdba
set serveroutput on;

Prompt Reiniciando las configuraciones del connection pool
exec dbms_connection_pool.stop_pool();
exec dbms_connection_pool.restore_defaults();