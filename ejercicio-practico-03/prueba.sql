declare
    v_count number;
    v_username varchar2(20) := 'MIGUEL0301';
    v_table varchar2(20) := 'T02_DB_ROLES';
    v_count2 number;
    v_rol varchar2(20) := 'BASIC_USER_ROLE';
begin
    select count(*) into v_count from all_tables where table_name=v_table;
    select count(*) into v_count2 from dba_roles where role=v_rol;

    if v_count >0 then
        execute immediate 'drop table MIGUEL0301.'||v_table|| ' cascade';
        elsif v_count2 >0 then
            execute immediate 'drop role '||v_rol|| ' cascade';
    end if;
end;
/


declare
    v_count number;
    v_username varchar2(20) := 'MIGUEL0301';
    v_table varchar2(20) := 'T02_DB_ROLES';
begin
    select count(*) into v_count from all_tables where table_name=v_table;
    if v_count >0 then
        execute immediate 'drop table '||v_username||'.'||v_table||' cascade constraint';
    end if;
end;
/


declare
    v_count2 number;
    v_rol varchar2(20) := 'BASIC_USER_ROLE';

begin
    select count(*) into v_count2 from dba_roles where role=v_rol;

    if v_count2 >0 then
        execute immediate 'drop role '||v_rol|| ' cascade';
    end if;
end;
/


--Ejercicio 06
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