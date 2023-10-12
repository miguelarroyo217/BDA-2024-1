--@Autor:          Miguel Arroyo
--@Fecha creación:  30/08/2023
--@Descripción: Creación del diccionario de datos

prompt 1. Ejecución de scripts SQL, conectando como sys
connect sys/system2 as sysdba

@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql
@?/rdbms/admin/utlrp.sql

prompt 2. Ejecutar el siguiente script como system
connect system/system2
@?/sqlplus/admin/pupbld.sql

prompt Listo!
