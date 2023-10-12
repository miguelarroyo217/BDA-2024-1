--@Autor:       Miguel Arroyo
--@Fecha:       01/10/2023
--@Descripción: Datos estadisticos del buffer cache por objeto.

whenever sqlerror exit rollback;

Prompt Conectando con el usuario miguel07
connect miguel07/miguel

Prompt creando tabla t03_random_data
create table t03_random_data(
  id number,
  random_string varchar2(1024)
);

Prompt creando tabla t04_db_buffer_status
create table t04_db_buffer_status(
  id number generated always as identity,
  total_bloques number,
  status varchar2(10),
  evento varchar2(30)
);

Prompt Generando procedimiento para generar cadenas aleatorias
declare
  v_rows number;
  v_query varchar2(100);
begin
  v_rows := 1000*10;
  v_query :=
    'insert into t03_random_data(id, random_string) values (:ph1,:ph2)';
  for v_index in 1 .. v_rows loop
    execute immediate v_query
      using v_index, dbms_random.string('P',1016);
  end loop;
end;
/
commit;

Prompt Iniciando sesión como sys
connect sys/system2 as sysdba

Prompt Insertando un primer registro en la tabla t04_db_buffer_status
insert into miguel07.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después de carga' as evento
  from v$bh
  where objd = (
    select data_object_id
    from dba_objects
    where object_name='T03_RANDOM_DATA'
    and owner = 'MIGUEL07'
  )
  group by status;
commit;

Prompt Liberando los buffers del cache
alter system flush buffer_cache;

Prompt Haciendo una nueva consulta y agregando un nuevo registro a la tabla t04
insert into miguel07.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después de vaciar db buffer' as evento
  from v$bh
  where objd = (
    select data_object_id
    from dba_objects
    where object_name='T03_RANDOM_DATA'
    and owner = 'MIGUEL07'
  )
  group by status;
commit;

Prompt Deteniendo e iniciando la instancia
shutdown
startup

Prompt Realizando una nueva consulta y otra insersión en la tabla t04
insert into miguel07.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después del reinicio' as evento
  from v$bh
  where objd = (
    select data_object_id
    from dba_objects
    where object_name='T03_RANDOM_DATA'
    and owner = 'MIGUEL07'
  )
  group by status;
commit;

Prompt Modificar un registro de la tabla
update miguel07.t03_random_data set random_string= upper(random_string)
where id =950;

Prompt Realizando una nueva consulta y registro en la tabla t04
insert into miguel07.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después del cambio 1' as evento
  from v$bh
  where objd = (
    select data_object_id
    from dba_objects
    where object_name='T03_RANDOM_DATA'
    and owner = 'MIGUEL07'
  )
  group by status;

Prompt En otra terminal crear una sesión con el usuario miguel07
Prompt Consultar el registro modificado 3 veces
pause "select * from t03_random_data where id =950", [enter] para continuar

Prompt Realizando una nueva consulta y registro en la tabla t04
insert into miguel07.t04_db_buffer_status (total_bloques,status,evento)
  select count(*) total_bloques,status, 'Después de 3 consultas' as evento
  from v$bh
  where objd = (
    select data_object_id
    from dba_objects
    where object_name='T03_RANDOM_DATA'
    and owner = 'MIGUEL07'
  )
  group by status;
commit;

Prompt Mostrando los datos finales
select * from miguel07.t04_db_buffer_status;