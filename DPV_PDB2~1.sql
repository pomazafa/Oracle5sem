select * from dba_tablespaces;

--2


Create tablespace DPV_QDATA OFFLINE
    Datafile 'D:\ORACLE\DPV_QDATA.dbf'
    size 10 m
    AUTOEXTEND on next 5M
    Maxsize 20M
    Extent management local;
    
    
ALTER TABLESPACE DPV_QDATA ONLINE;

create table MySecondTable(Fir varchar(20), sec varchar(20))
tablespace DPV_QDATA;

insert into MySecondTable values ('123','456');
insert into MySecondTable values ('111','444');
insert into MySecondTable values ('100','132');

select * from MySecondTable;

alter user DPV
QUOTA 2m on DPV_QDATA

select * from user_tables where table_name = 'HELPME';

drop table MySecondTable;

select * from user_recyclebin;

flashback table MySecondTable to before drop;

select * from MySecondTable;

--6
BEGIN
  for k in 1..10000
  loop
    insert into MySecondTable(Fir, Sec) values ('k', 't');
end loop
commit;
END;

--7

select count(*) from dba_segments where TABLESPACE_NAME = 'DPV_QDATA';
select * from dba_segments where TABLESPACE_NAME = 'DPV_QDATA';

--8
drop tablespace DPV_QDATA including contents and datafiles;

--9
select * from V$LOGFILE;
select * from V$LOG;

--10
select * from V$LOGMNR_LOGS;

--системное время
select systimestamp from dual;

--11
alter system switch logfile;
select * from V$LOG;

--12

alter database add logfile group 4 'D:\ORACLE\logfiles.LOG'
size 50m BLoCKSIZE 512;

alter database add logfile member 'D:\ORACLE\logfiles1.LOG' to group 4;
alter database add logfile member 'D:\ORACLE\logfiles2.LOG' to group 4;
alter database add logfile member 'D:\ORACLE\logfiles3.LOG' to group 4;

--13
alter database drop logfile member 'D:\ORACLE\logfiles1.LOG';
alter database drop logfile member 'D:\ORACLE\logfiles2.LOG';
alter database drop logfile member 'D:\ORACLE\logfiles3.LOG';
alter database drop logfile group 4;

--14

select name, log_mode from V$database;

--15 
select * from V$archived_log


--17

SHOW PARAMETER DB_RECOVERY

archive log list;

select * from V$LOG;


--19
show parameter control;

select NAME from v$controlfile;

--20

select * from v$controlfile_record_section;

--21
select * from v$parameter;
show parameter spfile;

--22
create PFILE = 'p1.ora' from spfile;

--23
--oracle_home/dbs/

--24
select * from v$diag_info;