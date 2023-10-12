--@Autor:       Miguel Arroyo
--@Fecha:       28/09/2023
--@Descripción: Mostrar información del buffer cache

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

Prompt Creando la tabla t01_db_buffer_cache
create table miguel07.t01_db_buffer_cache as(
  select vbp.block_size, vbp.current_size, vbp.buffers, vbp.target_buffers, 
  vbp.prev_size, vbp.prev_buffers, vp.value as default_pool_size
  from v$buffer_pool vbp, v$parameter vp
  where vp.name='db_cache_size');

Prompt Mostrando la información de la tablas
select * from miguel07.t01_db_buffer_cache;

Prompt Creando tabla t02_db_buffer_sysstats
create table miguel07.t02_db_buffer_sysstats as (
    select 
        db_blocks_gets_from_cache,
        consistent_gets_from_cache,
        physical_reads_cache,
        trunc((1 - physical_reads_cache / (db_blocks_gets_from_cache + consistent_gets_from_cache)), 6) as cache_hit_radio
    from (
        select 
            (select value from v$sysstat where name = 'db block gets from cache') as db_blocks_gets_from_cache,
            (select value from v$sysstat where name = 'consistent gets from cache') as consistent_gets_from_cache,
            (select value from v$sysstat where name = 'physical reads cache') as physical_reads_cache
        from dual
        )
    );
    
Prompt Mostrando información de la tabla t02_db_buffer_sysstats
select * from miguel07.t02_db_buffer_sysstats;