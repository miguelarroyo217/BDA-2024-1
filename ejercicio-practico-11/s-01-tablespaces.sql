--@Autor:	Miguel Arroyo
--@Fecha:	24/11/2023
--@Descripción:	Creación de tablespaces

whenever sqlerror exit rollback;

Prompt a) Conectando como sysdba
connect sys/system2 as sysdba

Prompt b) Crear tablespace store_tbs1
create tablespace store_tbs1
    datafile '/u01/app/oracle/oradata/MAQBDA2/store_tbs01.dbf' size 20m
        autoextend off
    extent management local autoallocate
    segment space management auto;

Prompt c) Crear tablespace store_tbs_multiple
create tablespace store_tbs_multiple
    datafile '/u01/app/oracle/oradata/MAQBDA2/store_tbs_multiple_01.dbf' size 10m autoextend off,
        '/u01/app/oracle/oradata/MAQBDA2/store_tbs_multiple_02.dbf' size 10m autoextend off,
        '/u01/app/oracle/oradata/MAQBDA2/store_tbs_multiple_03.dbf' size 10m autoextend off
    extent management local autoallocate
    segment space management auto;

Prompt d) Crear big tablespace store_tbs_big
create bigfile tablespace store_tbs_big
    datafile '/u01/app/oracle/oradata/MAQBDA2/store_tbs_big.dbf' size 100m
        autoextend off
    extent management local autoallocate
    segment space management auto;

Prompt e) Crear small tablespace store_tbs_zip
create smallfile tablespace store_tbs_zip
    datafile '/u01/app/oracle/oradata/MAQBDA2/store_tbs_zip01.dbf' size 10m
    default row store compress advanced;

Prompt f) Crear temporary tablespace store_tbs_temp
create temporary tablespace store_tbs_temp
    tempfile '/u01/app/oracle/oradata/MAQBDA2/store_tbs_temp01.dbf' size 32m
        reuse
    extent management local uniform size 16m;

Prompt g) Crear custom tablespace store_tbs_custom
create tablespace store_tbs_custom
    datafile '/u01/app/oracle/oradata/MAQBDA2/store_tbs_custom_01.dbf' size 10m
        reuse
        autoextend on next 1m maxsize 30m
    blocksize 8k
    nologging
    offline
    extent management local uniform size 64k
    segment space management auto;