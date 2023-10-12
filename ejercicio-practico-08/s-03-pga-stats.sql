--@Autor:       Miguel Arroyo
--@Fecha:       05/10/2023
--@Descripción: Información sobre la PGA 

whenever sqlerror exit rollback;

Prompt Conectando como sysdba
connect sys/system2 as sysdba

Prompt Creando la tabla t04_pga_stats as
create table miguel08.t04_pga_stats as (
  select 
        max_pga_mb,
        pga_target_param_calc_mb,
        pga_target_param_actual_mb,
        pga_total_actual_mb,
        pga_in_use_actual_mb,
        pga_free_memory_mb,
        pga_process_count,
        pga_cache_hit_percentage
    from (
        select 
            (select trunc((value/1024)/1024, 2) from v$pgastat where name = 'maximum PGA allocated') as max_pga_mb,
            (select trunc((value/1024)/1024, 2) from v$pgastat where name = 'aggregate PGA target parameter') as pga_target_param_calc_mb,
            (select trunc((value/1024)/1024, 2) from v$parameter where name = 'pga_aggregate_target') as pga_target_param_actual_mb,
            (select trunc((value/1024)/1024, 2) from v$pgastat where name = 'total PGA allocated') as pga_total_actual_mb,
            (select trunc((value/1024)/1024, 2) from v$pgastat where name = 'total PGA inuse') as pga_in_use_actual_mb,
            (select trunc((value/1024)/1024, 2) from v$pgastat where name = 'total freeable PGA memory') as pga_free_memory_mb,
            (select value from v$pgastat where name = 'process count') as pga_process_count,
            (select value from v$pgastat where name = 'cache hit percentage') as pga_cache_hit_percentage
        from dual
        )
    );
  
Prompt Mostrando datos de la tabla t04_pga_stats
select * from miguel08.t04_pga_stats;