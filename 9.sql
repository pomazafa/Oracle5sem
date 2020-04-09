--2
create sequence MySeq1
increment by 10
start with 1000
nomaxvalue
nominvalue
nocycle
nocache
noorder;

select MySeq1.NextVAL from DUAL;
select MySeq1.CurrVAL from DUAL;

--3
create sequence MySeq2
increment by 10
start with 10
maxvalue 100
nocycle;

select MySeq2.NextVAL from DUAL;
select MySeq2.CurrVAL from DUAL;

drop sequence MySeq2;

--4

create sequence MySeq3
increment by -10
start with 10
maxvalue 100
minvalue -100
nocycle
order;

select MySeq3.NextVAL from DUAL;
select MySeq3.CurrVAL from DUAL;

drop sequence MySeq3;
--5

create sequence MySeq4
increment by 1
start with 1
maxvalue 10
nominvalue
cycle
cache 5
noorder;

select MySeq4.NextVAL from DUAL;
select MySeq4.CurrVAL from DUAL;

--6

select * from sys.user_sequences;

--7

create table T1 (N1 number(20), N2 number(20), N3 number(20), N4 number(20));

alter table T1 storage (buffer_pool keep);

DECLARE
	i NUMBER := 0;
BEGIN
	
	LOOP			-- start loop 1
    insert into T1 values(MySeq1.NextVAL, MySeq2.NextVAL, MySeq3.NextVAL, MySeq4.NextVAL);
	i := i + 1;
	IF (i >= 7) THEN
		i := 0;
		EXIT;		-- exit when i >= 0
	END IF;
	END LOOP;			-- end loop 1

END;
/

select * from t1;

--8

CREATE CLUSTER ABC
   (X NUMBER(10), V varchar2(12))
SIZE 200
CACHE;

--9

create table A (XA number(10), VA varchar(12), proizvol number(10)) cluster ABC(XA, VA);


--10

create table B (XB number(10), VB varchar(12), proizvol2 number(10)) cluster ABC(XB, VB);


--11

create table C (XC number(10), VC varchar(12), proizvol3 number(10)) cluster ABC(XC, VC);

--12

select * from dba_clusters;

select * from dba_tables where CLUSTER_NAME = 'ABC';

CREATE INDEX MyIndex ON CLUSTER ABC;
--13

create synonym MyC for system.C;

select * from MyC;

--14

create public synonym MyPublicB for system.B;

select * from MyPublicB;

--15

create table A1 (k number(10) primary key, U number(10));

create table B1 (kk number(10) primary key, kF number(10) REFERENCES A1(k));

drop table B1;
drop table A1;

insert into A1 values (1, 10);
insert into A1 values (2, 20);

insert into B1 values (1, 1);
insert into B1 values (3, 1);


create View V1 as
select * from A1 inner join B1 on A1.k = B1.kF;

select * from V1;


--16
create materialized view MV
refresh on demand 
start with sysdate next sysdate + 1
as 
SELECT * from A1 inner join B1 on A1.k = B1.kF;

select * from MV;