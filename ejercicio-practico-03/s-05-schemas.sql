--@Autor:          Miguel Arroyo
--@Fecha creación:  09/09/2023
--@Descripción: Esquemas de privilegios de administración

--Permite detener la ejecución del script al primer error.
whenever sqlerror exit rollback;

Prompt Iniciando sesión como miguel0302 sin priv. de administración
connect miguel0302/miguel

Prompt Creando tabla de datos de sesión
create table t03_datos_sesion (
    usuario varchar2(128),
    nombre_esquema varchar2(128)
);

Prompt Conenctando como miguel0302 as sysdba
connect miguel0302/miguel as sysdba

Prompt Otorgando permisos al usuario public
grant insert,select on miguel0302.t03_datos_sesion to public;

Prompt Insertando datos desde el usuario sys
insert into miguel0302.t03_datos_sesion (usuario,nombre_esquema)
values (
    sys_context('USERENV','CURRENT_USER'),
    sys_context('USERENV','CURRENT_SCHEMA')
);

Prompt Mostrando datos de la tabla
select * from miguel0302.t03_datos_sesion;

Prompt Conectando como miguel0303 as sysoper
connect miguel0303/miguel as sysoper

Prompt Insertando datos desde el usuario public
insert into miguel0302.t03_datos_sesion (usuario,nombre_esquema)
values (
    sys_context('USERENV','CURRENT_USER'),
    sys_context('USERENV','CURRENT_SCHEMA')
);

Prompt Mostrando datos de la tabla
select * from miguel0302.t03_datos_sesion;

Prompt Conectando como miguel0304 as sysbackup
connect miguel0304/miguel as sysbackup

Prompt Insertando datos desde el usuario sysbackup
insert into miguel0302.t03_datos_sesion (usuario,nombre_esquema)
values (
    sys_context('USERENV','CURRENT_USER'),
    sys_context('USERENV','CURRENT_SCHEMA')
);

Prompt Mostrando datos de la tabla
select * from miguel0302.t03_datos_sesion;

Prompt Conectando como sys
connect sys/Hola1234# as sysdba

Prompt Revocando privilegios de administración a los usuarios
revoke sysdba from miguel0302;
revoke sysoper from miguel0303;
revoke sysbackup from miguel0304;

Prompt Cambiando la contraseña de sys
alter user sys identified by system1;
alter user sysbackup identified by system1;