--@Autor:	Miguel Arroyo
--@Fecha:	05/10/2023
--@Descripción:	Creación del usuario para realizar el ejercicio 08

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

declare
    v_count number;
    v_username varchar2(20) := 'MIGUEL08';
begin
    select count(*) into v_count from all_users where username=v_username;
    if v_count >0 then
        execute immediate 'drop user '||v_username||' cascade';
    end if;
end;
/


Prompt Creando al usuario miguel08
create user miguel08 identified by miguel quota unlimited on users;
grant create session, create table, create sequence to miguel08;
