--@Autor:       Miguel Arroyo
--@Fecha:       05/10/2023
--@Descripción: Información sobre el shared pool

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

Prompt Creando la tabla t02_shared_pool
create table miguel08.t02_shared_pool as (
  select 
        shared_pool_param_mb,
        shared_pool_sga_info_mb,
        resizeable,
        shared_pool_component_total,
        shared_pool_free_memory
    from (
        select 
            (select (value/1024)/1024 from v$parameter where name = 'shared_pool_size') as shared_pool_param_mb,
            (select (bytes/1024)/1024 from v$sgainfo where name = 'Shared Pool Size') as shared_pool_sga_info_mb,
            (select resizeable from v$sgainfo where name = 'Shared Pool Size') as resizeable,
            (select count(*) from v$sgastat where pool='shared pool') as shared_pool_component_total,
            (select (bytes/1024)/1024 from v$sgastat where pool='shared pool' and name='free memory') as shared_pool_free_memory
        from dual
        )
    );

Prompt Mostrando información de la tabla t02_shared_pool
select * from miguel08.t02_shared_pool;

Prompt Creando la tabla t03_library_cache_hits
create table miguel08.t03_library_cache_hits as 
  select 1 as id, reloads,invalidations,pins,pinhits,pinhitratio
  from v$librarycache
  where namespace='SQL AREA';
  
Prompt Creando la tabla test_orden_compra
create table miguel08.test_orden_compra(id number);

Prompt Ejecutando consultas con sentencias sql estáticas.
set timing on
declare
  v_orden_compra miguel08.test_orden_compra%rowtype;
begin
  for i in 1..50000 loop
    begin
    execute immediate
  'select * from miguel08.test_orden_compra where id='||i
    into v_orden_compra;
  exception
    when no_data_found then
      null;
  end;
  end loop;
end;
/
set timing off

Prompt Capturando nuevamente estadísticas del library cache
insert into miguel08.t03_library_cache_hits(id, reloads, invalidations,
  pins, pinhits, pinhitratio)
  select 2 as id, reloads, invalidations, pins, pinhits, pinhitratio
  from v$librarycache
  where namespace='SQL AREA';
commit;

Prompt Reiniciando instancia
shutdown
startup

Prompt Capturando estadisticas del library cache después del reinicio de la instancia
insert into miguel08.t03_library_cache_hits(id, reloads, invalidations,
  pins, pinhits, pinhitratio)
  select 3 as id, reloads, invalidations, pins, pinhits, pinhitratio
  from v$librarycache
  where namespace='SQL AREA';
commit;

Prompt Ejecuntando bloque anonimo con placeholders
set timing on
declare
  v_orden_compra miguel08.test_orden_compra%rowtype;
begin
  for i in 1..50000 loop
    begin
    execute immediate
  'select * from miguel08.test_orden_compra where id= :ph1'
    into v_orden_compra using i;
  exception
    when no_data_found then
      null;
  end;
  end loop;
end;
/
set timing off

Prompt Capturando estadisticas del library cache despues de usar placeholders
insert into miguel08.t03_library_cache_hits(id, reloads, invalidations,
  pins, pinhits, pinhitratio)
  select 4 as id, reloads, invalidations, pins, pinhits, pinhitratio
  from v$librarycache
  where namespace='SQL AREA';
commit;

Prompt Mostrando los datos de la tabla t03_library_cache_hits
select * from miguel08.t03_library_cache_hits;
