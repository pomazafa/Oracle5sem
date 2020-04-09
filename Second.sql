create table MyTable(Fir varchar(20), sec varchar(20));

insert into MyTable values ('123','456');

CREATE VIEW MyView AS
  SELECT *
  FROM MyTable;
  
create table MySecondTable(Fir varchar(20), sec varchar(20))
tablespace DPV_QDATA;

insert into MySecondTable values ('123','456');
insert into MySecondTable values ('111','444');
insert into MySecondTable values ('100','132');

select * from MySecondTable;