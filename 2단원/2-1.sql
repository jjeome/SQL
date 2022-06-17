--Create a Table For Test
drop table dept80 purge;

create table dept80
as
select employee_id, last_name, salary*12 as annsal, hire_date
from employees
where department_id = 80;

desc dept80

select * from dept80;

--Adding a Column
alter table dept80
add email varchar2(30);

SELECT * FROM dept80;

--null값을 변경하려면 UPDATE쓰면 됨

--Adding a Column with DEFAULT value
alter table dept80
add job varchar2(10) DEFAULT 'Not Yet'; --컬럼을 추가하면서 바로 기본값 정의됨

desc dept80

select * from dept80;

--modifying a Column
alter table dept80
modify last_name varchar2(30);

desc dept80;

ALTER TABLE dept80
MODIFY email DEFAULT 'None'; --컬럼 만든 후에 기본값 넣으려면 UPDATE해줘야 함

SELECT * FROM dept80;

UPDATE dept80
SET email=default;

SELECT * FROM dept80;

COMMIT;

--Dropping a Column
alter table dept80
drop column hire_date;

select * from dept80;

DESC dept80;

--삭제는 아니지만 사용자에게 안보이게 하고 싶을때 set unused 사용
alter table dept80
set unused column annsal;

alter table dept80
set unused column email;

desc dept80
select * from dept80;

alter table dept80
drop unused columns;

--Clear Test
drop table dept80 purge;