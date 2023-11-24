--@Autor:	Miguel Arroyo
--@Fecha:	28/10/2023
--@Descripción:	Creación de extensiones

whenever sqlerror exit rollback;

Prompt A) Conectando como miguel101
connect miguel1001/miguel

Prompt B) Creando tabla str_data
create table str_data(
    str char(1024)
)segment creation immediate pctfree 0;

Prompt C) Considerando el siguiente código y salida
select lengthb(str), length(str) from str_data;

Prompt D) Calculando número de registros necesarios para llenar.

Prompt E) Realizando inserción de datos a través de un procedimiento
declare
begin
  for i in 1..56 loop
    begin
      execute immediate 
        'insert into str_data(str) values (TO_CHAR(:ph1))'
        using i;
    end;
  end loop;
end;
/
show errors
commit;

Prompt F) Consultando user_extendes para verificar los resultados
select * from user_extents where segment_name='STR_DATA';


Prompt Mostrando rowid
select rowid from str_data order by 1;

Prompt Agrupando elementos del rowid
select substr(rowid,1,15) as codigo_bloque ,count(*) total_registros
from str_data
group by substr(rowid,1,15)
order by codigo_bloque;

Prompt Almacenando la información de la tabla anterior en la tabla t02_str_data_extents
create table t02_str_data_extents as
  select substr(rowid,1,15) as codigo_bloque ,count(*) total_registros
  from str_data
  group by substr(rowid,1,15)
  order by codigo_bloque;