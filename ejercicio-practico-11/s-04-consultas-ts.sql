--@Autor:	Miguel Arroyo
--@Fecha:	24/11/2023
--@Descripción:	Consultas de los tablespaces creados

whenever sqlerror exit rollback;

Prompt a) Mostrando tamaño de los tablespace
select tablespace_name, block_size/1024 as block_size_kb, 
initial_extent/1024 as initial_extent_kb, 
next_extent/1024 as next_extent_kb, trunc((max_extents/1024)/1024, 2) as max_extents,
trunc((max_size/1024)/1024, 2) as max_size_mb, status, contents, logging
from dba_tablespaces;

Prompt b) Mostrando información de los tablespace
select tablespace_name, extent_management, allocation_type,
segment_space_management, bigfile, encrypted, compress_for
from dba_tablespaces;

Prompt c) Mostrando información de miguel11
select du.username, du.default_tablespace, du.temporary_tablespace,
'UNLIMITED' as quota_mb, (dtq.bytes/1024)/1024 as allocated_mb, dtq.blocks
from dba_users du join dba_ts_quotas dtq
on du.username=dtq.username and du.default_tablespace=dtq.tablespace_name
where du.username='MIGUEL11';