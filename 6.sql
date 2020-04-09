select * from v$sga;

select * from v$sgastat;

select * from v$sga_dynamic_components;

--3

--show parameter sga;
select * from v$sga_dynamic_components where current_size > 0;

--4
select * from v$sga_dynamic_free_memory;

--5

select * from v$sga_dynamic_components where component like '%cache%';

--6

create table XXX (k int) storage (buffer_pool keep) tablespace users;

commit;

select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where segment_name = 'XXX';

--7

create table CCC (k int) tablespace users;

insert into CCC values(1);

commit;

select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where segment_name = 'CCC';

--8

show parameter log_buffer;

--9

select * from (select pool, name, bytes from v$sgastat where pool = 'shared pool' ORDER BY bytes desc) where ROWNUM <= 10;

--10

select * from v$sga_dynamic_components where component = 'large pool';

--11, 12

select username, service_name, server from v$session where username is not null;

--13

select name,type,executions from v$db_object_cache  order by executions desc;
