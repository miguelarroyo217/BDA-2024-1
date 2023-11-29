--@Autor:	Miguel Arroyo
--@Fecha:	28/11/2023
--@Descripción:	Administración básica de datos undo

whenever sqlerror exit rollback;

Prompt a) Sentencia SQL que muestra el ts undo que se está usando
select name, value, issys_modifiable from v$parameter 
where name='undo_tablespace';

Prompt b) Creando un nuevo ts de datos undo
create undo tablespace undotbs2
    datafile '/u01/app/oracle/oradata/MAQBDA2/undotbs_2.dbf' size 30m
        autoextend off
    extent management local autoallocate;

Prompt c) Cambiando el ts undo por default de la instancia
alter system set undo_tablespace='undotbs2' scope=memory;

Prompt d) Verificando el uso del nuevo ts undo
select name, value, issys_modifiable from v$parameter 
where name='undo_tablespace';

Prompt e) Mostrando información de v$undostats
select begin_time, end_time, undotsn, undoblks, txncount,
maxqueryid, maxquerylen, activeblks, 
unexpiredblks, expiredblks, tuned_undoretention
from v$undostat
where rownum<=20
order by begin_time desc;

Prompt g) Mostrando el nombre de cada ts en la consulta anterior
select vus.begin_time, vus.end_time, vus.undotsn, vts.name
from v$undostat vus join v$tablespace vts
on vus.undotsn=vts.ts#
where rownum<=20
order by begin_time desc;

Prompt h) Mostrando el espacio de almacenamiento libre del ts undo
select dfs.tablespace_name, dfs.blocks blocks_free, sum(ds.blocks) blocks_used,
dfs.blocks+sum(ds.blocks) total_blocks
from dba_free_space dfs join dba_segments ds
on dfs.tablespace_name=ds.tablespace_name 
where ds.tablespace_name='UNDOTBS2'
group by dfs.tablespace_name, dfs.blocks;

--select * from dba_free_space;
Prompt i) Creando al usuario miguel072 y otrogando permisos
create user miguel072 identified by miguel quota unlimited on users;

grant create session, create table, create procedure, create sequence to miguel072;

Prompt i) Creando la tabla maq_cadena_2
create table miguel072.maq_cadena_2(
  id number constraint maq_cadena_2_pk primary key, 
  cadena varchar2(1024)
) nologging;

Prompt i) Creando la secuencia sec_maq_cadena_2
create sequence miguel072.sec_maq_cadena_2
  start with 1
  increment by 1
  maxvalue 99999
  minvalue 1
  nocycle;
  
create sequence miguel072.sec_maq_cadena_2_2
  start with 100000
  increment by 1
  maxvalue 999999999999999
  minvalue 100000
  nocycle;

Prompt Llenado de tabla con 50,000 registros
declare
  v_rows number;
  v_query varchar2(100);
  v_query1 varchar2(100);
begin
  v_rows := 1000*50;
  v_query :=
    'insert into miguel072.maq_cadena_2(id, cadena) values (:ph1,:ph2)';
  v_query1 :=
    'insert into miguel072.maq_cadena_2(id, cadena) values (:ph3,:ph4)';
  for v_index in 1 .. v_rows loop
    if v_index = 1 then
      execute immediate 'select miguel072.sec_maq_cadena_2.nextval from dual';
      execute immediate v_query1
        using miguel072.sec_maq_cadena_2.currval, dbms_random.string('P', 1016);
    else
      execute immediate v_query
        using miguel072.sec_maq_cadena_2.nextval, dbms_random.string('P', 1016);
    end if;
  end loop;
end;
/
commit;

--select * from miguel072.maq_cadena_2;

Prompt j) Replicación del error DML. Ejecutando consulta del inciso e)
select begin_time, end_time, undotsn, undoblks, txncount,
maxqueryid, maxquerylen, activeblks, 
unexpiredblks, expiredblks, tuned_undoretention
from v$undostat
where rownum<=20
order by begin_time desc;

Prompt j) Eliminando 5000 registros
delete from miguel072.maq_cadena_2
where rownum <= 5000;

create table miguel072.dml_error as
  select '0-5000' registros_eliminados, undoblks bloques_utilizados, 
  txncount transacciones_ejecutadas, activeblks bloques_activos, 
  tuned_undoretention retencion_seg_calculada
  from v$undostat
  where rownum<=1
  order by begin_time desc;

insert into miguel072.dml_error
  select '25000' registros_eliminados, undoblks bloques_utilizados, 
  txncount transacciones_ejecutadas, activeblks bloques_activos, 
  tuned_undoretention retencion_seg_calculada
  from v$undostat
  where rownum<=1
  order by begin_time desc;

rollback;

select * from miguel072.dml_error;

Prompt k) Replicación del error snapshot too old 

Prompt 1. Iniciando transacción con un nivel de aislamiento
set transaction isolation level serializable name 'T1-LR';


Prompt 2. Realizando consultas
select count(*) from miguel072.maq_cadena_2;

select count(*)
from miguel072.maq_cadena_2
where cadena like 'A%'
or cadena like 'Z%'
or cadena like 'M%';

delete from miguel072.maq_cadena_2
where rownum <= 5000;

Prompt m) Realizando comportamiento inverso

Prompt Cambiando prioridad de la base de datos
alter tablespace undotbs2 retention guarantee;