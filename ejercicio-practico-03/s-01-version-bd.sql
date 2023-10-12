--@Autor:          Miguel Arroyo
--@Fecha creación:  07/09/2023
--@Descripción: Verificación de versión

--Permite detener la ejecución del script al primer error.
whenever sqlerror exit rollback;

Prompt Conectando como usuario sys.
connect sys/system1 as sysdba

declare
    v_count number;
    v_username varchar2(20) := 'MIGUEL0301';
begin
    select count(*) into v_count from all_users where username=v_username;
    if v_count >0 then
        execute immediate 'drop user '||v_username||' cascade';
    end if;
end;
/

Prompt Creando al usuario miguel0301
create user miguel0301 identified by miguel quota unlimited on users;
grant create session, create table to miguel0301;

Prompt Creando tabla de versión
create table miguel0301.t01_db_version as
    select product,version,version_full
    from product_component_version;

Prompt Verificando los datos de la tabla
select * from miguel0301.t01_db_version;
