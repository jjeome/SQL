--Create Index with the Create Table statement
DROP TABLE emp2 PURGE;

create table emp2
(empid number(6) primary key,
empname varchar2(30),
salary number(6),
department_id number(3));

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

SELECT table_name, index_name --자동으로 만들어진 index -> 수동으로 drop안됨 -> 제약조건을 없애거나 비활성화하면 index사라짐
FROM user_indexes
WHERE table_name = 'EMP2';

ALTER TABLE emp2 DISABLE primary key; --index끄기

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

SELECT table_name, index_name --제약조건 상태에 따라서 생겼다 지웠다 함
FROM user_indexes
WHERE table_name = 'EMP2';

ALTER TABLE emp2 ENABLE primary key;

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP2';

drop table emp2 purge;

create table emp2
(empid number(6) primary key using index --primary key때문에 만든는index이지만 수동으로 만든것 처럼 .
            (create index emp2_empid_idx on emp2(empid)),
empname varchar2(30),
salary number(6),
department_id number(3));

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP2';

ALTER TABLE emp2 DISABLE primary key;

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP2'; --인덱스 유지

ALTER TABLE emp2 ENABLE primary key; 

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP2';

--Function Based Indexes 썼는지 안썼는지 구분됨
create index emp_sal_ix on employees(salary);

alter index emp_sal_ix monitoring usage;

select * from employees
where salary*12 > 80000;

select * from v$object_usage;

drop index emp_sal_ix;

create index emp_annsal_ix on employees(salary*12);
alter index emp_annsal_ix monitoring usage;

select * from employees
where salary*12 > 80000;

select * from v$object_usage;


--Clear Test
drop index emp_annsal_ix;


--Drop Table with Recyclebin

show recyclebin;

PURGE recyclebin;

show recyclebin;
drop table emp2;
desc emp2
select * from emp2;
show recyclebin;
flashback table emp2 to before drop; 
desc emp2
select * from emp2;
show recyclebin; --휴지통에보관해 되돌려주는 기능(테이블을 리네임한것) -> 그자치에 객체는 그대로저장하되 이름을 바꿔서 휴지통으로 만들어둠
drop table emp2 purge;
show recyclebin;
flashback table emp2 to before drop;
show recyclebin;