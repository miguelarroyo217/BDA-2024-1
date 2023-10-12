--@Autor:          Miguel Arroyo
--@Fecha creación:  08/09/2023
--@Descripción: Roles

--Permite detener la ejecución del script al primer error.
whenever sqlerror exit rollback;

Prompt Conectando como usuario sys.
connect sys/system1 as sysdba

--Colocar el procedimiento aqui
declare
    v_count number;
    v_username varchar2(20) := 'MIGUEL0301';
    v_table varchar2(20) := 'T02_DB_ROLES';
    v_count2 number;
    v_rol varchar2(20) := 'BASIC_USER_ROLE';
begin
    select count(*) into v_count from all_tables where table_name=v_table;
    select count(*) into v_count2 from dba_roles where role=v_rol;
    if v_count >0 and v_count2 >0 then
        execute immediate 'drop table '||v_username||'.'||v_table||' cascade constraint';
        execute immediate 'drop role '||v_rol||'';
        elsif v_count >0 then
          execute immediate 'drop table '||v_username||'.'||v_table||' cascade constraint';
            elsif v_count2 > 0 then
                execute immediate 'drop role '||v_rol||''; 
    end if;
end;
/

Prompt Creando tabla de Roles
--oracle_maintained indica que fue creado durante la creación de la BD.
create table miguel0301.t02_db_roles as
    select role_id,role 
    from dba_roles
    where oracle_maintained='Y';

Prompt Consultando la tabla de roles
select * from miguel0301.t02_db_roles;

Prompt Creando un nuevo rol básico de usuario
create role basic_user_role;

Prompt Asignando privilegios al rol basico
grant create table, create session, create sequence, create procedure to basic_user_role;

Prompt Asignando rol básico al usuario miguel0301
grant basic_user_role to miguel0301;

Prompt Comprobando los roles asignados al usuario miguel0301
connect miguel0301/miguel

col username format a30;
col granted_role format a30;
set linesize window;
select username, granted_role from user_role_privs;

Prompt Comprobando los privilegios del usuario
select privilege, admin_option
  from user_sys_privs;
