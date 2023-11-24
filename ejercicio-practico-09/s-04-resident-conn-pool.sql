--@Autor:	Miguel Arroyo
--@Fecha:	14/10/2023
--@Descripción:	Configuración necesaria para crear un connection pool

whenever sqlerror exit rollback;

Prompt Iniciando sesión como sysdba
connect sys/system2 as sysdba

Prompt Iniciando un nuevo connection pool
exec dbms_connection_pool.start_pool();

Prompt Configurando connection pool
exec dbms_connection_pool.alter_param ('','MAXSIZE','50');
exec dbms_connection_pool.alter_param ('','MINSIZE','32');

Prompt Configurando otros parametros del connection pool
exec dbms_connection_pool.alter_param ('','INACTIVITY_TIMEOUT','1800');
exec dbms_connection_pool.alter_param ('','MAX_THINK_TIME','1800');