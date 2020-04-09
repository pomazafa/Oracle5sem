Create tablespace TS_DPV
    Datafile 'D:\ORACLE\TS_DPV.dbf'
    size 7 m
    AUTOEXTEND on next 5M
    Maxsize 20M
    Extent management local;
    
Create temporary tablespace TS_DPV_TEMP
    Tempfile 'D:\ORACLE\TS_DPV_TEMP.dbf'
    size 5 m
    AUTOEXTEND on next 3M
    Maxsize 30M
    Extent management local;
    
drop tablespace TS_DPV_TEMP;

SELECT  FILE_NAME, BLOCKS, TABLESPACE_NAME
   FROM DBA_DATA_FILES;
   
   
alter session set "_ORACLE_SCRIPT"=true;



create role RL_DPVCORE;

grant create session to RL_DPVCORE;
grant create table  to RL_DPVCORE;
grant create view  to RL_DPVCORE;
grant create PROCEDURE  to RL_DPVCORE;

grant delete any table to RL_DPVCORE;
grant drop any view  to RL_DPVCORE;
grant drop any  PROCEDURE  to RL_DPVCORE;


select privilege 
from dba_sys_privs 
where grantee='RL_DPVCORE';



alter session set "_ORACLE_SCRIPT"=true;
create profile PF_DPVCORE LIMIT
    password_life_time 180
    sessions_per_user 3
    failed_login_attempts 7
    password_lock_time 1
    password_reuse_time 10
    password_grace_time default
    connect_time 180
    idle_time 30;
    
select distinct profile from dba_profiles;
select * from dba_profiles where profile = 'PF_DPVCORE';
select * from dba_profiles where profile = 'DEFAULT';


create user DPVCORE identified by 12345
default tablespace TS_DPV QUOTA unlimited on TS_DPV
temporary tablespace TS_DPV_TEMP
profile PF_DPVCORE
ACCOUNT unlock
password expire

grant create session to DPVCORE;

grant create table  to DPVCORE;
grant create view  to DPVCORE;
grant create PROCEDURE  to DPVCORE;

grant delete any table to DPVCORE;
grant drop any view  to DPVCORE;
grant drop any  PROCEDURE  to DPVCORE;


Create tablespace DPV_QDATA OFFLINE
    Datafile 'D:\ORACLE\DPV_QDATA.dbf'
    size 10 m
    AUTOEXTEND on next 5M
    Maxsize 20M
    Extent management local;
    
    
ALTER TABLESPACE DPV_QDATA ONLINE;


alter user DPVCORE 
QUOTA 2m on DPV_QDATA
