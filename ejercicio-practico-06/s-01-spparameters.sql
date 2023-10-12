--@Autor:	Miguel Arroyo
--@Fecha:	19/09/2023
--@Descripción: Creación de un PFILE a partir de un SPFILE
whenever sqlerror exit rollback;

Prompt Iniciando sesión como sysdba
connect sys/system2 as sysdba

Prompt Creando un PFILE a partir de un SPFILE
create pfile=
'/unam-bda/ejercicios-practicos/ejercicio-practico-06/e-02-spparameter-pfile.txt'
from spfile;

Prompt PFILE Creado correctamente

declare
	v_count number;
	v_username varchar2(20) := 'MIGUEL06';
begin
	select count(*) into v_count from all_users where username=v_username;
	if v_count >0 then
		execute immediate 'drop user '||v_username|| 'cascade';
	end if;
end;
/

Prompt Creando al usuario miguel06
create user miguel06 identified by miguel quota unlimited on users;
grant create session, create table, create sequence, create procedure to miguel06;

Prompt Creando tabla de parametros
create table miguel06.t01_spparameters as
	select name,value
	from v$spparameter
	where value is not null;

Prompt Mostrando información de la tabla
select * from miguel06.t01_spparameters;
