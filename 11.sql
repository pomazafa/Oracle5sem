--1, 2, 3, 4
declare
    faculty_rec faculty%rowtype;
    b1 boolean;
    b2 boolean;
    b3 boolean;
    n pls_integer;
begin
    select * into faculty_rec from faculty where faculty = 'ХТиТ' or faculty = 'ИДиП';
    b1 := sql%found;
    b2 := sql%isopen;
    b3 := sql%notfound;
    n := sql%rowcount;
    if b1 then     dbms_output.put_line ('b1 = true'); end if;
    if b2 then     dbms_output.put_line ('b2 = true'); end if;
    if b3 then     dbms_output.put_line ('b3 = true'); end if;
    dbms_output.put_line ('n = '||n);
    
    dbms_output.put_line(faculty_rec.faculty || ' ' || faculty_rec.faculty_name);
exception
    when no_data_found
    then
        dbms_output.put_line('данные не найдены (ORA '||sqlcode||')');
        dbms_output.put_line(sqlerrm);
    when too_many_rows
    then dbms_output.put_line('результат состоит из нескольких строк (ORA '||sqlcode||')');
    when others
    then dbms_output.put_line(sqlerrm);
end;

--5
declare
    b1 boolean;
    b2 boolean;
    b3 boolean;
    s pls_integer;
    auditorium_our auditorium%rowtype;
begin
update auditorium set auditorium = '314-1',
            auditorium_name = '314-1',
            auditorium_capacity = 90,
            auditorium_type = 'ЛК'
        where auditorium = '301-1';
rollback;
b1 := sql%found;
b2 := sql%isopen;
b3 := sql%notfound;
s := sql%rowcount;
if b1 then     dbms_output.put_line ('b1 = true'); end if;
if b2 then     dbms_output.put_line ('b2 = true'); end if;
if b3 then     dbms_output.put_line ('b3 = true'); end if;
dbms_output.put_line ('s = '||s);
--commit;
    exception
    when others
        then     dbms_output.put_line(sqlerrm);
end;


select * from auditorium;



--6
declare
    b1 boolean;
    b2 boolean;
    b3 boolean;
    s pls_integer;
begin
update auditorium set auditorium = '314-1',
            auditorium_name = '314-1',
            auditorium_capacity = 90,
            auditorium_type = 'UYU'
        where auditorium = '301-1';
--rollback;
b1 := sql%found;
b2 := sql%isopen;
b3 := sql%notfound;
s := sql%rowcount;
if b1 then     dbms_output.put_line ('b1 = true'); end if;
if b2 then     dbms_output.put_line ('b2 = true'); end if;
if b3 then     dbms_output.put_line ('b3 = true'); end if;
dbms_output.put_line ('s = '||s);
--commit;
rollback;
exception
    when others
        then     dbms_output.put_line(sqlerrm);
end;

--7-8

declare
    b1 boolean;
    b2 boolean;
    b3 boolean;
    s pls_integer;
    auditorium_our auditorium%rowtype;
begin
insert into auditorium(auditorium, auditorium_name, auditorium_capacity, auditorium_type ) 
values ('301-1', '301-1', 90, 'ЛК');
--rollback;
b1 := sql%found;
b2 := sql%isopen;
b3 := sql%notfound;
s := sql%rowcount;
if b1 then     dbms_output.put_line ('b1 = true'); end if;
if b2 then     dbms_output.put_line ('b2 = true'); end if;
if b3 then     dbms_output.put_line ('b3 = true'); end if;
dbms_output.put_line ('s = '||s);
--DBMS_OUTPUT.PUT_LINE(auditorium_cur.auditorium_name|| ' ' || auditorium_cur.auditorium_capacity|| ' ' || auditorium_cur.auditorium_type);
--commit;
rollback;
    exception
    when others
        then     dbms_output.put_line(sqlerrm);
end;

--9-10

declare
    b1 boolean;
    b2 boolean;
    b3 boolean;
    s pls_integer;
begin
delete auditorium_type where auditorium_type = 'ЛК';
b1 := sql%found;
b2 := sql%isopen;
b3 := sql%notfound;
s := sql%rowcount;
if b1 then     dbms_output.put_line ('b1 = true'); end if;
if b2 then     dbms_output.put_line ('b2 = true'); end if;
if b3 then     dbms_output.put_line ('b3 = true'); end if;
dbms_output.put_line ('s = '||s);
commit;
--rollback;
    exception
    when others
        then     dbms_output.put_line(sqlerrm);
end;

--11

declare 
    cursor curs_subject is select subject, subject_name, pulpit from subject;
    s_subject subject.subject%type;
    s_subject_name subject.subject_name%type;
    s_pulpit subject.pulpit%type;
begin
    open curs_subject;
    DBMS_OUTPUT.PUT_LINE('rowcount = '||curs_subject%rowcount);
    loop
    fetch curs_subject into s_subject, s_subject_name, s_pulpit;
    exit when curs_subject%notfound;
    DBMS_OUTPUT.PUT_LINE(' '||curs_subject%rowcount||' '
        ||s_subject|| ' '
        ||s_subject_name||' '
        ||s_pulpit);
    end loop;
    DBMS_OUTPUT.PUT_LINE('rowcount = '||curs_subject%rowcount);
    close curs_subject;
exception
when others
        then     dbms_output.put_line(sqlerrm);
end;
select * from teacher;
--12

declare 
    cursor curs_subject is select subject, subject_name, pulpit from subject;
    rec_subject subject%rowtype;
begin
    open curs_subject;
    DBMS_OUTPUT.PUT_LINE('rowcount = '||curs_subject%rowcount);
    fetch curs_subject into rec_subject;
    while curs_subject%found
    loop
    DBMS_OUTPUT.PUT_LINE(' '||curs_subject%rowcount||' '
        ||rec_subject.subject|| ' '
        ||rec_subject.subject_name||' '
        ||rec_subject.pulpit);   
    fetch curs_subject into rec_subject;
    end loop;
    DBMS_OUTPUT.PUT_LINE('rowcount = '||curs_subject%rowcount);
    close curs_subject;
exception
when others
        then     dbms_output.put_line(sqlerrm);
end;

--13

declare 
    cursor curs_pulpit_teachers is select pulpit.pulpit, pulpit.pulpit_name, teacher.teacher_name from pulpit inner join teacher on pulpit.pulpit = teacher.pulpit;
begin
    for curs in curs_pulpit_teachers
    loop
    DBMS_OUTPUT.PUT_LINE(' '
        ||curs.pulpit|| ' '
        ||curs.pulpit_name||' '
        ||curs.teacher_name);
    end loop;
end;

--14

declare
    cursor curs_auditorium ( capacity1 auditorium.auditorium%type, capacity2 auditorium.auditorium%type) is select auditorium, auditorium_capacity
                from auditorium
                where auditorium_capacity >= capacity1 and auditorium_capacity <=capacity2;
begin
    
    for aud in curs_auditorium (30, 70)
    loop
    dbms_output.put_line(' '||aud.auditorium||' '||aud.auditorium_capacity);
    end loop;
    
exception
    when others
    then dbms_output.put_line(sqlerrm);
end;

--15

declare
    type  taud_type  is ref cursor ;
    xcurs  taud_type;
    rec_taud  auditorium%rowtype;
begin
    open xcurs for select * from auditorium;
    loop
    fetch xcurs into rec_taud;
    dbms_output.put_line(rec_taud.auditorium || ' - '||rec_taud.auditorium_capacity);
    exit when xcurs%notfound;
    end loop;
    close xcurs;
exception
    when others
    then dbms_output.put_line(sqlerrm);
end;

--16
declare 
    cursor curs_aut
    is select auditorium_type,
      cursor (
          select auditorium
          from auditorium aum
          where aut.auditorium_type = aum.auditorium_type
      )
    from auditorium_type aut;
   curs_aum sys_refcursor;
   aut auditorium_type.auditorium_type%type;
   txt varchar2(1000);
   aum auditorium.auditorium%type;
begin
    open curs_aut;
    fetch curs_aut into aut, curs_aum;
    while(curs_aut%found)
    loop
      txt:=rtrim(aut)||':';
      loop
        fetch curs_aum into aum;
        exit when curs_aum%notfound;
        txt := txt||','||rtrim(aum);
      end loop;
      dbms_output.put_line(txt);
      fetch curs_aut into aut, curs_aum;
    end loop;
    close curs_aut;
exception
    when others
    then dbms_output.put_line(sqlerrm);
end;
    
--17
declare 
  cursor curs_auditorium(capacity system.auditorium.auditorium%type, capac system.auditorium.auditorium%type)
    is select auditorium, auditorium_capacity
      from auditorium
      where auditorium_capacity >=capacity and AUDITORIUM_CAPACITY <= capac for update;
  aum system.auditorium.auditorium%type;
  cty system.auditorium.auditorium_capacity%type;
begin
  open curs_auditorium(40,80);
  fetch curs_auditorium into aum, cty;
  while(curs_auditorium%found)
  loop
  cty := cty * 0.9;
  update auditorium
  set auditorium_capacity = cty
  where current of curs_auditorium;
  dbms_output.put_line(' '||aum||' '||cty);
  fetch curs_auditorium into aum, cty;
  end loop;
  close curs_auditorium;
  rollback;
exception
  when others
  then dbms_output.put_line(sqlerrm);
end;


--18

declare 
  cursor curs_auditorium(capacity system.auditorium.auditorium%type,capac system.auditorium.auditorium%type)
    is select auditorium, auditorium_capacity
      from auditorium
      where auditorium_capacity >=capacity and AUDITORIUM_CAPACITY <= capac for update;
  aum system.auditorium.auditorium%type;
  cty system.auditorium.auditorium_capacity%type;
begin
  open curs_auditorium(0,20);
  fetch curs_auditorium into aum, cty;
  while(curs_auditorium%found)
  loop
  delete auditorium
  where current of curs_auditorium;
  fetch curs_auditorium into aum, cty;
  end loop;
  close curs_auditorium; 
  for pp in curs_auditorium(0,120)
  loop
  dbms_output.put_line(' '||pp.auditorium||
                       ' '||pp.auditorium_capacity);
  end loop;
  rollback;
exception
  when others
  then dbms_output.put_line(sqlerrm);
end;
  
  
--19

declare
    cursor curs_auditorium(capacity system.auditorium.auditorium%type)
        is select auditorium, auditorium_capacity, rowid
        from auditorium
        where auditorium_capacity >=capacity for update;
  aum system.auditorium.auditorium%type;
  cty system.auditorium.auditorium_capacity%type;
begin
    for xxx in curs_auditorium(80)
    loop
    case
    when xxx.auditorium_capacity > 90
      then delete auditorium
      where rowid = xxx.rowid;
    when xxx.auditorium_capacity >=80
      then update auditorium
      set auditorium_capacity = auditorium_capacity + 10
      where rowid = xxx.rowid;
    end case;
  end loop;
  for yyy in curs_auditorium(80)
    loop
        dbms_output.put_line(' '||yyy.auditorium||
                         ' '||yyy.auditorium_capacity);
    end loop;
    rollback;
exception
    when others
    then dbms_output.put_line(sqlerrm);
end;


--20

declare 
    cursor curs_teacher is select teacher, teacher_name, pulpit
      from teacher;
    m_teacher system.teacher.teacher%type;
    m_teacher_name system.teacher.teacher_name%type;
    m_pulpit system.teacher.pulpit%type;
    k integer :=1;
begin
    open curs_teacher;
    loop
    fetch curs_teacher into m_teacher, m_teacher_name, m_pulpit;
    exit when curs_teacher%notfound;
    DBMS_OUTPUT.PUT_LINE(' '||curs_teacher%rowcount||' '
                          ||m_teacher||' '
                          ||m_teacher_name||' '
                          ||m_pulpit);
    if (k mod 3 = 0) then DBMS_OUTPUT.PUT_LINE('-------------------------------------------'); end if;
    k:=k+1;
    end loop;
     DBMS_OUTPUT.PUT_LINE('rowcount = '|| curs_teacher%rowcount);
     close curs_teacher;
exception
    when others
       then  DBMS_OUTPUT.PUT_LINE(sqlerrm);
end;