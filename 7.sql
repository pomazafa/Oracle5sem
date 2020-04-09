--1

select * from v$bgprocess;

--2

SELECT * FROM v$bgprocess where paddr!=hextoraw('00') order by name;

--3

SELECT spid, pname, username, program, tracefile FROM v$process WHERE pname LIKE 'DBW%';

--4, 5

select username, service_name, server from v$session where username is not null;
select * from v$session where username is not null;

--6

select * from v$services;

--7

show parameter dispatcher;
show parameter log_checkpoint;

--8


