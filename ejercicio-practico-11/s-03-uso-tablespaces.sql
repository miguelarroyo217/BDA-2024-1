--@Autor:	Miguel Arroyo
--@Fecha:	24/11/2023
--@Descripción:	Uso de tablespaces creados

--whenever sqlerror exit rollback;

Prompt a) Conectando como sysdba
connect sys/system2 as sysdba

set serveroutput on

Prompt b) Asignar cuotas a miguel11 en los tablespaces
alter user miguel11 quota unlimited on store_tbs1;
alter user miguel11 quota unlimited on store_tbs_multiple;
alter user miguel11 quota 50m on store_tbs_big;
alter user miguel11 quota unlimited on store_tbs_zip;
alter user miguel11 quota unlimited on store_tbs_custom;

Prompt c) Modificando default ts de miguel11
alter user miguel11 default tablespace store_tbs1;

Prompt d) Asignando tablespace temporal a miguel11
alter user miguel11 temporary tablespace store_tbs_temp;

Prompt e) Creando tabla store_test
create table miguel11.store_test(
    test_id integer
) segment creation deferred;

Prompt Conectado como miguel11
connect miguel11/miguel

set serveroutput on

Prompt f) Ejecutando programa anónimo PL/SQL
declare
    v_extensiones number;
    v_total_espacio number;
begin
    v_extensiones := 0;
    loop
        begin
            execute immediate 'alter table store_test allocate extent';
            exception
            when others then
            if sqlcode = -1653 then
                exit;
            end if;
        end;
    end loop;
    --total espacio asignado
    select sum(bytes)/(1024*1024),count(*) into v_total_espacio,v_extensiones
    from user_extents
    where segment_name='STORE_TEST';
    dbms_output.put_line('Total de extensiones creadas: '||v_extensiones);
    dbms_output.put_line('Total de espacio reservado: '||v_total_espacio);
end;
/

Prompt Conectando como sys
connect sys/system2 as sysdba

set serveroutput on

Prompt g) Agregando datafile al ts store_tbs1
alter tablespace store_tbs1
    add datafile '/u01/app/oracle/oradata/MAQBDA2/store_tbs02.dbf' size 2m;

insert into miguel11.store_test values(217);