--1

create or replace procedure GET_TEACHERS (PCODE in TEACHER.PULPIT%TYPE) as cursor teacher
    is 
        select * from teacher where pulpit = PCODE;
    teacher_item TEACHER%ROWTYPE;
    begin
        open teacher;
        fetch teacher into teacher_item;
        WHILE teacher%FOUND 
        LOOP 
            dbms_output.put_line(teacher_item.teacher_name || ' ' || teacher_item.pulpit);
            FETCH teacher INTO teacher_item; 
        END LOOP; 
        CLOSE teacher; 
    end GET_TEACHERS;

exec GET_TEACHERS('ИСиТ');

--2-3

create or replace function GET_NUM_TEACHERS (PCODE TEACHER.PULPIT%TYPE) 
    RETURN NUMBER is 
   c number;
    begin
     select count(*) into c from teacher where pulpit = PCODE;
     return c;
    end GET_NUM_TEACHERS;

declare
    c number;
begin
  select GET_NUM_TEACHERS('ИСиТ') into c from dual;
  dbms_output.put_line(c);
end;

--4
select * from teacher;

create or replace procedure GET_TEACHERS (FCODE in FACULTY.FACULTY%TYPE) as cursor teacher2
    is 
        select teacher, teacher_name, pulpit.pulpit, birthday, salary from teacher inner join pulpit on teacher.pulpit = pulpit.pulpit where pulpit.faculty = FCODE;
    teacher_item TEACHER%ROWTYPE;
    begin
        open teacher2;
        fetch teacher2 into teacher_item;
        WHILE teacher2%FOUND 
        LOOP 
            dbms_output.put_line(teacher_item.teacher_name || ' ' || teacher_item.pulpit);
            FETCH teacher2 INTO teacher_item; 
        END LOOP; 
        CLOSE teacher2; 
    end GET_TEACHERS;

exec GET_TEACHERS('ИДиП');

create or replace procedure GET_SUBJECTS (PCODE in SUBJECT.PULPIT%TYPE) as cursor subj
    is 
        select subject, subject_name, subject.pulpit from subject where pulpit = PCODE;
    subject_item SUBJECT%ROWTYPE;
    begin
        open subj;
        fetch subj into subject_item;
        WHILE subj%FOUND 
        LOOP 
            dbms_output.put_line(subject_item.subject_name || ' ' || subject_item.pulpit);
            FETCH subj INTO subject_item; 
        END LOOP; 
        CLOSE subj; 
    end GET_SUBJECTS;

begin
    GET_SUBJECTS('ИСиТ');
end;

--5

create or replace function GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE) 
    RETURN NUMBER is 
   c number;
    begin
         select count(*) into c from teacher inner join pulpit on teacher.pulpit = pulpit.pulpit where pulpit.faculty = FCODE;
         return c;
end GET_NUM_TEACHERS;

declare
    c number;
begin
  select GET_NUM_TEACHERS('ИДиП') into c from dual;
  dbms_output.put_line(c);
end;

create or replace function GET_NUM_SUBJECTS (PCODE in SUBJECT.PULPIT%TYPE) RETURN NUMBER is 
   c number;
    begin
         select count(*) into c from subject where pulpit = PCODE;
         return c;
end  GET_NUM_SUBJECTS;


declare
    c number;
begin
  select GET_NUM_SUBJECTS('ИСиТ') into c from dual;
  dbms_output.put_line(c);
end;

--6

create or replace package TEACHERS as 
    procedure GET_TEACHERS (FCODE FACULTY.FACULTY%TYPE);
    procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE);
    function GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER ;
   function GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER ;
end TEACHERS;

declare
    c number;
begin
  select TEACHERS.GET_NUM_SUBJECTS('ИСиТ') into c from dual;
  dbms_output.put_line(c||' - Кол-во предметов');
  select TEACHERS.GET_NUM_TEACHERS('ИДиП') into c from dual;
  dbms_output.put_line(c||' - Кол-во преподавателей');
  TEACHERS.GET_SUBJECTS('ИСиТ');
  TEACHERS.GET_TEACHERS('ИДиП');
end;

create or replace package body TEACHERS as 
function GET_NUM_SUBJECTS (PCODE in SUBJECT.PULPIT%TYPE) RETURN NUMBER is 
   c number;
    begin
         select count(*) into c from subject where pulpit = PCODE;
         return c;
         end;
function GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE) 
    RETURN NUMBER is 
   c number;
    begin
         select count(*) into c from teacher inner join pulpit on teacher.pulpit = pulpit.pulpit where pulpit.faculty = FCODE;
         return c;
end;
procedure GET_SUBJECTS (PCODE in SUBJECT.PULPIT%TYPE) as cursor subj
    is 
        select subject, subject_name, subject.pulpit from subject where pulpit = PCODE;
    subject_item SUBJECT%ROWTYPE;
    begin
        open subj;
        fetch subj into subject_item;
        WHILE subj%FOUND 
        LOOP 
            dbms_output.put_line(subject_item.subject_name || ' ' || subject_item.pulpit);
            FETCH subj INTO subject_item; 
        END LOOP; 
        CLOSE subj; 
    end;
     procedure GET_TEACHERS (FCODE in FACULTY.FACULTY%TYPE) as cursor teacher2
    is 
        select teacher, teacher_name, pulpit.pulpit, birthday, salary from teacher inner join pulpit on teacher.pulpit = pulpit.pulpit where pulpit.faculty = FCODE;
    teacher_item TEACHER%ROWTYPE;
    begin
        open teacher2;
        fetch teacher2 into teacher_item;
        WHILE teacher2%FOUND 
        LOOP 
            dbms_output.put_line(teacher_item.teacher_name || ' ' || teacher_item.pulpit);
            FETCH teacher2 INTO teacher_item; 
        END LOOP; 
        CLOSE teacher2; 
    end;
end TEACHERS;