--@Autor:	Miguel Arroyo
--@Fecha:	12/10/2023
--@Descripción:	Creación del usuario para realizar el ejercicio práctico 09

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

declare
    v_count number;
    v_username varchar2(20) := 'MIGUEL09';
begin
    select count(*) into v_count from all_users where username=v_username;
    if v_count >0 then
        execute immediate 'drop user '||v_username||' cascade';
    end if;
end;
/


Prompt Creando al usuario miguel09
create user miguel09 identified by miguel quota unlimited on users;
grant create session, create table, create procedure to miguel09;
