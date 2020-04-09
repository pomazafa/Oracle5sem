--3
create or replace trigger auditorium_before_insert
before insert on auditorium
begin
    dbms_output.put_line('auditorium_before_insert');
end;

create or replace trigger auditorium_before_update
before update on auditorium
begin
    dbms_output.put_line('auditorium_before_update');
end;

create or replace trigger auditorium_before_delete
before delete on auditorium
begin
    dbms_output.put_line('auditorium_before_delete');
end;

--5
create or replace trigger auditorium_before_insert_row
before insert on auditorium
for each row
begin
    dbms_output.put_line('auditorium_before_insert_row');
end;

create or replace trigger auditorium_before_update_row
before update on auditorium
for each row
begin
    dbms_output.put_line('auditorium_before_update_row');
end;

create or replace trigger auditorium_before_delete_row
before delete on auditorium
for each row
begin
    dbms_output.put_line('auditorium_before_delete_row');
end;

--предикаты
create or replace trigger auditorium_after_1
after insert or update or delete on auditorium
begin
    if inserting then
        dbms_output.put_line('auditorium_after_insert_1');
    elsif updating then
        dbms_output.put_line('auditorium_after_update_1');
    elsif deleting then
        dbms_output.put_line('auditorium_after_delete_1');
    end if;
end;

--7

create or replace trigger auditorium_after_insert
after insert on auditorium
begin
    dbms_output.put_line('auditorium_after_insert');
end;

create or replace trigger auditorium_after_update
after update on auditorium
begin
    dbms_output.put_line('auditorium_after_update');
end;

create or replace trigger auditorium_after_delete
after delete on auditorium
begin
    dbms_output.put_line('auditorium_after_delete');
end;

--8
create or replace trigger auditorium_after_insert_row
after insert on auditorium
for each row
begin
    dbms_output.put_line('auditorium_after_insert_row');
end;

create or replace trigger auditorium_after_update_row
after update on auditorium
for each row
begin
    dbms_output.put_line('auditorium_after_update_row');
end;

create or replace trigger auditorium_after_delete_row
after delete on auditorium
for each row
begin
    dbms_output.put_line('auditorium_after_delete_row');
end;

describe auditorium;
insert into auditorium values ('102-2', '102-5', 65, 'ЛК');
update auditorium set auditorium_name = '102-2' where auditorium = '102-2';
delete auditorium where auditorium = '102-2';

select * from AUDIT_A;
drop table audit_a;
drop trigger tr_drop_table;
drop table auditorium;

SELECT * from user_triggers;
commit;
--9

create table AUDIT_A (OperationDate date, OperationType varchar2(15), TriggerName varchar2 (30), Data varchar2 (50));

--10

create or replace trigger auditorium_before_insert_row
before insert on auditorium
for each row
begin
    insert into AUDIT_A values (sysdate, 'insert', 'auditorium_before_insert_row', :old.auditorium_name|| ' ' || :new.auditorium_name);
end;

create or replace trigger auditorium_before_update_row
before update on auditorium
for each row
begin
    insert into AUDIT_A values (sysdate, 'update', 'auditorium_before_update_row', :old.auditorium_name|| ' ' || :new.auditorium_name);
end;

create or replace trigger auditorium_before_delete_row
before delete on auditorium
for each row
begin
    insert into AUDIT_A values (sysdate, 'delete', 'auditorium_before_delete_row', :old.auditorium_name|| ' ' || :new.auditorium_name);
end;

create or replace trigger auditorium_after_insert_row
after insert on auditorium
for each row
begin
    insert into AUDIT_A values (sysdate, 'insert', 'auditorium_after_insert_row', :old.auditorium_name|| ' ' || :new.auditorium_name);
end;

create or replace trigger auditorium_after_update_row
after update on auditorium
for each row
begin
    insert into AUDIT_A values (sysdate, 'update', 'auditorium_after_update_row', :old.auditorium_name|| ' ' || :new.auditorium_name);
end;

create or replace trigger auditorium_after_delete_row
after delete on auditorium
for each row
begin
    insert into AUDIT_A values (sysdate, 'delete', 'auditorium_after_delete_row', :old.auditorium_name|| ' ' || :new.auditorium_name);
end;

--12
create or replace trigger tr_drop_table
before drop on SCHEMA
begin
    raise_application_error(-20000, 'Do not drop table - '||ORA_DICT_OBJ_TYPE||' '||ORA_DICT_OBJ_NAME);
end;
drop trigger tr_drop_table;
create view vauditorium
    as select * from auditorium;
    
select * from vauditorium;

create or replace trigger trauditorium
    instead of insert on vauditorium
    for each row
        begin
            dbms_output.put_line('insert'||:new.auditorium_name);
            insert into auditorium values (:new.auditorium,:new.auditorium_name, :new.auditorium_capacity, :new.auditorium_type);
        end trauditorium;
        
insert into vauditorium values ('a', 'aaa', 15, 'ЛК-К');

select * from vauditorium;
select * from auditorium;