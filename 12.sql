
--1
alter table teacher add birthday date;
alter table teacher add salary number;
select * from teacher;
update teacher set birthday = '11-11-1987' where id = 1; 
update teacher set birthday = '11-11-1999' where id = 2; 
update teacher set birthday = '11-11-1974' where id = 3; 
update teacher set birthday = '11-12-1943' where teacher = '√–ÃÕ'; 
update teacher set birthday = '11-12-1975' where id = 6; 
update teacher set salary = 2100; 

update teacher set birthday 

--2

DECLARE 
    Z1 VARCHAR2(100); 
    Z2 VARCHAR2(100); 
    Z3 VARCHAR2(100); 
    K1 INT:=0; 
    K2 INT:=0; 
    CURSOR CUR_TEACH 
        IS SELECT TEACHER,TEACHER_NAME,PULPIT,BIRTHDAY,SALARY FROM TEACHER; 
    CC_SUB TEACHER%ROWTYPE; 
BEGIN 
    OPEN CUR_TEACH; 
    FETCH CUR_TEACH INTO CC_SUB; 
    WHILE CUR_TEACH%FOUND 
    LOOP 
        K1:=INSTR(CC_SUB.TEACHER_NAME, ' '); 
        K2:=INSTR(CC_SUB.TEACHER_NAME, ' ',1,2); 
        Z1:=SUBSTR(CC_SUB.TEACHER_NAME,1,K1); 
        Z2:=SUBSTR(CC_SUB.TEACHER_NAME,K1,K2); 
        Z2:=SUBSTR(Z2,1,2); 
        Z3:=SUBSTR(CC_SUB.TEACHER_NAME,K2); 
        Z3:=SUBSTR(Z3,1,2); 
        DBMS_OUTPUT.PUT_LINE(Z1||' '||Z2||'.'||Z3||'.'); 
        FETCH CUR_TEACH INTO CC_SUB; 
    END LOOP; 
    CLOSE CUR_TEACH; 
END;

--3

DECLARE 
    CURSOR CUR_TEACH 
        IS SELECT TEACHER,TEACHER_NAME,PULPIT,BIRTHDAY,SALARY FROM TEACHER; 
    CC_SUB TEACHER%ROWTYPE; 
BEGIN 
    OPEN CUR_TEACH; 
    FETCH CUR_TEACH INTO CC_SUB; 
    WHILE CUR_TEACH%FOUND 
    LOOP 
        if NEXT_DAY(CC_SUB.BIRTHDAY,'œŒÕ≈ƒ≈À‹Õ» ')=CC_SUB.BIRTHDAY+7
        then DBMS_OUTPUT.PUT_LINE(CC_SUB.TEACHER_NAME); end if;
        FETCH CUR_TEACH INTO CC_SUB; 
    END LOOP; 
    CLOSE CUR_TEACH; 
END;

--4

DECLARE 
    months_count INT; 
    CURSOR CUR_TEACH 
        IS SELECT TEACHER,TEACHER_NAME,PULPIT,BIRTHDAY,SALARY FROM TEACHER; 
    CC_SUB TEACHER%ROWTYPE; 
BEGIN 
OPEN CUR_TEACH; 
FETCH CUR_TEACH INTO CC_SUB; 
WHILE CUR_TEACH%FOUND 
    LOOP 
    months_count:=MONTHS_BETWEEN(ADD_MONTHS(SYSDATE, 1),CC_SUB.BIRTHDAY); 
    WHILE months_count>12 
        LOOP 
            months_count:=months_count-12; 
        END LOOP; 
    IF months_count=12 THEN DBMS_OUTPUT.PUT_LINE(CC_SUB.TEACHER_NAME||' '||CC_SUB.BIRTHDAY); END IF;  
    FETCH CUR_TEACH INTO CC_SUB; 
    END LOOP; 
    CLOSE CUR_TEACH; 
END; 

CREATE VIEW lab12_4 AS
select * from teacher where EXTRACT(month from (BIRTHDAY))=EXTRACT(month from (ADD_MONTHS(sysdate, 1)));

select * from lab12_4;

--5

create view lab12_5 as SELECT SUM(CASE WHEN EXTRACT(MONTH FROM BIRTHDAY)=1 THEN 1 ELSE 0 END)"ﬂÕ¬¿–‹", 
SUM(CASE WHEN EXTRACT(MONTH FROM BIRTHDAY)=2 THEN 1 ELSE 0 END)"‘≈¬–¿À‹", 
SUM(CASE WHEN EXTRACT(MONTH FROM BIRTHDAY)=3 THEN 1 ELSE 0 END)"Ã¿–“", 
SUM(CASE WHEN EXTRACT(MONTH FROM BIRTHDAY)=4 THEN 1 ELSE 0 END)"¿œ–≈À‹", 
SUM(CASE WHEN EXTRACT(MONTH FROM BIRTHDAY)=5 THEN 1 ELSE 0 END)"Ã¿…", 
SUM(CASE WHEN EXTRACT(MONTH FROM BIRTHDAY)=6 THEN 1 ELSE 0 END)"»ﬁÕ‹", 
SUM(CASE WHEN EXTRACT(MONTH FROM BIRTHDAY)=7 THEN 1 ELSE 0 END)"»ﬁÀ‹", 
SUM(CASE WHEN EXTRACT(MONTH FROM BIRTHDAY)=8 THEN 1 ELSE 0 END)"¿¬√”—“", 
SUM(CASE WHEN EXTRACT(MONTH FROM BIRTHDAY)=9 THEN 1 ELSE 0 END)"—≈Õ“ﬂ¡–‹", 
SUM(CASE WHEN EXTRACT(MONTH FROM BIRTHDAY)=10 THEN 1 ELSE 0 END)"Œ “ﬂ¡–‹", 
SUM(CASE WHEN EXTRACT(MONTH FROM BIRTHDAY)=11 THEN 1 ELSE 0 END)"ÕŒﬂ¡–‹", 
SUM(CASE WHEN EXTRACT(MONTH FROM BIRTHDAY)=12 THEN 1 ELSE 0 END)"ƒ≈ ¿¡–‹" 
FROM TEACHER; 

select * from lab12_5;

--6

DECLARE 
    L INT:=100; 
    Z INT:=0; 
    CURSOR CUR_TEACH 
        IS SELECT TEACHER,TEACHER_NAME,PULPIT,BIRTHDAY,SALARY FROM TEACHER; 
    CC_SUB TEACHER%ROWTYPE; 
BEGIN 
    OPEN CUR_TEACH; 
    FETCH CUR_TEACH INTO CC_SUB; 
    WHILE CUR_TEACH%FOUND 
    LOOP 
        L:=MONTHS_BETWEEN(SYSDATE+60,CC_SUB.BIRTHDAY)/11.8; 
        Z:=MOD(L,5); 
        if z = 0 then dbms_output.put_line(CC_SUB.BIRTHDAY|| ' ' || CC_SUB.TEACHER_NAME);
        END IF;  
        FETCH CUR_TEACH INTO CC_SUB; 
    END LOOP; 
    CLOSE CUR_TEACH; 
END; 

--7

DECLARE 
    Z INT:=0; 
    K INT:=0; 
    CURSOR CUR_TEACH 
        IS SELECT TEACHER,TEACHER_NAME,PULPIT,BIRTHDAY,SALARY FROM TEACHER; 
    CC_SUB TEACHER%ROWTYPE; 
BEGIN 
    OPEN CUR_TEACH; 
    FETCH CUR_TEACH INTO CC_SUB; 
    WHILE CUR_TEACH%FOUND 
    LOOP 
    IF CC_SUB.PULPIT='»—Ë“' THEN 
        Z:=Z+CC_SUB.SALARY; 
        K:=K+1; 
        END IF; 
        FETCH CUR_TEACH INTO CC_SUB; 
    END LOOP; 
    Z:=Z/K; 
    DBMS_OUTPUT.PUT_LINE('AVG SALARY='||Z); 
    CLOSE CUR_TEACH; 
END; 

--8

declare 
    recl teacher%rowtype;
    type address is record 
        (
            address1 varchar2(100),
            address2 varchar2(100),
            address3 varchar2(100)
        );
    type person is record
        (
            code teacher.teacher%type,
            name teacher.teacher_name%type,
            homeaddress address
        );
    rec2 person;
    rec3 person;
begin
    rec2.code := 'œ–’ ';
    rec2.name := 'œÂıÓ‰¸ÍÓ ŒÎÂÒˇ';
    rec2.homeaddress.address1 := '¡ÂÎ‡ÛÒ¸';
    rec2.homeaddress.address2 := 'ÃËÌÒÍ, ¡ÂÒÒÍ‡ˇ Ó·Î';
    rec2.homeaddress.address3 := 'Õ‡·ÂÂÊÌ‡ˇ 7, Í‚.77';
    rec3 := rec2;
    dbms_output.put_line(rec3.code);
    dbms_output.put_line(rec3.name);
    dbms_output.put_line(rec3.homeaddress.address1);
    dbms_output.put_line(rec3.homeaddress.address2);
    dbms_output.put_line(rec3.homeaddress.address3);
exception
    when others then dbms_output.put_line(sqlerrm);
end;