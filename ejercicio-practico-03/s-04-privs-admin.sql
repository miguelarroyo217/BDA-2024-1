--@Autor:          Miguel Arroyo
--@Fecha creación:  08/09/2023
--@Descripción: Roles

--Permite detener la ejecución del script al primer error.
whenever sqlerror exit rollback;

Prompt Conectando como sysdba empleando el archivo de passwords
connect sys/Hola1234# as sysdba

declare
    v_count number;
    v_username1 varchar2(20) := 'MIGUEL0302';
    v_username2 varchar2(20) := 'MIGUEL0303';
    v_username3 varchar2(20) := 'MIGUEL0304';
begin
    select count(*) into v_count from all_users where username=v_username1
     or username=v_username2 or username=v_username3;
    if v_count >0 then
        execute immediate 'drop user '||v_username1||' cascade';
        execute immediate 'drop user '||v_username2||' cascade';
        execute immediate 'drop user '||v_username3||' cascade';
    end if;
end;
/

Prompt Creando a los usuarios 0302, 0303, 0304
create user miguel0302 identified by miguel quota unlimited on users;
create user miguel0303 identified by miguel quota unlimited on users;
create user miguel0304 identified by miguel quota unlimited on users;

Prompt Otorgando privilegios
grant create session, create table to miguel0302, miguel0303, miguel0304;

Prompt Asignando roles de administración
grant sysdba to miguel0302;
grant sysoper to miguel0303;
grant sysbackup to miguel0304;

Prompt Creando la tabla de administradores
create table miguel0302.t04_priv_admin as
    select username,sysdba,sysoper,sysbackup
    from v$pwfile_users;

Prompt Mostrando los datos de la tabla
col username format a30;
select * from miguel0302.t04_priv_admin;
