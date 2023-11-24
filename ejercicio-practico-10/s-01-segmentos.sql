--@Autor:	Miguel Arroyo
--@Fecha:	28/10/2023
--@Descripción:	Creación de segmentos

whenever sqlerror exit rollback;

Prompt A) Conectando como sysdba
connect miguel1001/miguel

Prompt B) Creando la tabla empleado
create table empleado(
    empleado_id number(10) constraint empleado_pk primary key,
    nombre_completo varchar2(150) not null,
    num_cuenta varchar2(15) not null,
    expediente blob not null
) segment creation deferred;

Prompt C) Creando un indice de la tabla empleado
create unique index empleado_num_cuenta_uix on empleado(num_cuenta);

Prompt D) Comprobando la existencia de segmentos.
select *
from user_segments
where segment_name like '%EMPLEADO%';

Prompt E) Provocando la generación de extensiones
alter table empleado allocate extent;

Prompt F) Segundo metodo, inserción de registros
insert into empleado values(01,'Miguel Arroyo Quiroz', 317016136, empty_blob());

Prompt G) Mostrando los segmentos creados
select us.segment_name, us.segment_type, us.tablespace_name, 
us.bytes/1024 as segment_kbs, us.blocks, us.extents
from user_segments us join user_lobs ul
on us.segment_name=ul.segment_name or us.segment_name=ul.index_name
or us.segment_name like '%EMPLEADO%' or ul.table_name='EMPLEADO'
order by us.segment_name;

Prompt Almacenando los resultados en la tabla t01_emp_segments
create table t01_emp_segments as
  select us.segment_name, us.segment_type, us.tablespace_name, 
  (us.bytes/1024) as segment_kbs, us.blocks, us.extents
  from user_segments us join user_lobs ul
  on us.segment_name=ul.segment_name or us.segment_name=ul.index_name
  or us.segment_name like '%EMPLEADO%' or ul.table_name='EMPLEADO'
  order by us.segment_name;

Prompt Mostrando los datos de la tabla t01_emp_segments
select * from t01_emp_segments;