--Create a Table For Test
drop table emp2 purge;
--copy : NOT NULL 만 복사됨(제약조건중에)
create table emp2
as
select * from employees;
select table_name, constraint_name, constraint_type, status, search_condition
from user_constraints
where table_name = 'EMP2';

--Adding a Constraints
alter table emp2
add primary key(employee_id); --primarykey만 추가해주면 됨

alter table emp2
add constraint emp2_email_uk unique (email); --constraint이름을 지어줬음

select table_name, constraint_name, constraint_type, status,search_condition
from user_constraints
where table_name = 'EMP2';

--Disable a Constraints(PRIMARY KEY)
alter table emp2
disable primary key; --테이블에 존재하지만 기능을 끄는 것 / 상태는 없는거나 똑같이보임 (데이터 검사X)

--제약조건에 위반하도록 데이터 수정(PRIMARY KEY 열에 중복데이터생성)
update emp2
set employee_id = 102
where employee_id = 101;
commit;
SELECT employee_id
FROM emp2
WHERE employee_id = 102;

--Disable a Constraints(Non Primary Key)
alter table emp2
disable constraint emp2_email_uk; --제약조건을 끄거나 부여할때 무조건 만들어준 이름을 지정해줘야함

--제약조건 상태확인
select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';
--Enabling a Constraints
alter table emp2
enable constraint emp2_email_uk; --enable되면 pk는 켜지지만 fk는 켜지지않음. 끌때는 pk와 fk둘다 꺼짐

--잘못된 데이터로 인해 제약조건 활성화에 실패한 경우 해결방법(Exception처리) -> 테이블 만들어줘야함
alter table emp2
enable primary key; 

create table exceptions(row_id rowid, --( 구성요소들 ) 들어감
	                owner varchar2(128),
	                table_name varchar2(128),
		        constraint varchar2(128));
                
alter table emp2
enable primary key
exceptions into exceptions; --만든 테이블이름을 예외

SELECT * FROM exceptions; --값으로는 누군지 식별 못하니까 rowid로 알려줌

SELECT *
FROM emp2;

SELECT employee_id, rowid
FROM emp2
WHERE rowid IN (SELECT row_id FROM exceptions); --값이 같아도 rowid는 같을 수 없음

--rowid 값 복사 
UPDATE emp2
SET employee_id = 101
WHERE rowid='AAAE9kAAEAAAAMTAAD';

--복사한 rowid 값 사용
SELECT *
FROM emp2
WHERE employee_id IN (101,102);

COMMIT;

ALTER TABLE emp2
ENABLE primary key; --기본키

select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

TRUNCATE TABLE exceptions;

--Dropping a Constraints
alter table emp2 
drop primary key;

alter table emp2
drop constraint emp2_email_uk;

select table_name, constraint_name, constraint_type, status, search_condition
from user_constraints
where table_name = 'EMP2';

--제약조건 명령문 생성해서 지우기
SELECT 'ALTER TABLE emp2 DROP CONSTRAINT ' || constraint_name || ';'
FROM user_constraints
WHERE table_name = 'EMP2';
--위 명령문으로 딕셔너리에서 이름불러와서 복붙해서 지우면됨
ALTER TABLE emp2 DROP CONSTRAINT SYS_C007112;
ALTER TABLE emp2 DROP CONSTRAINT SYS_C007113;
ALTER TABLE emp2 DROP CONSTRAINT SYS_C007114;
ALTER TABLE emp2 DROP CONSTRAINT SYS_C007115;

--Cascading Constraints
--Column Drop 시 추가 옵션
CREATE TABLE test1(
a NUMBER PRIMARY KEY, --기본키
b NUMBER,
c NUMBER,
d NUMBER,
CONSTRAINT test1_b_fk FOREIGN KEY (b) REFERENCES test1, --자기자신을 참조하는 외래키
CONSTRAINT ck1 CHECK (a > 0 and c > 0), --다중조건 a와c를 동시에 제약
CONSTRAINT ck2 CHECK (d > 0)); --다른 컬럼과 연관이 없는 독립적인 조건

desc test1

select table_name, constraint_name, constraint_type, status, search_condition
from user_constraints
where table_name = 'TEST1';

alter table test1
drop column d; --독립적인 컬럼이라 삭제 잘 됨

DESC test1
select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'TEST1';

alter table test1
drop column c; --c랑 a랑 동시조건이라 c만 삭제가 불가능

alter table test1
drop column a; --b는 a를 참조하고 있는 외래키가 있어서 a가 삭제가 안되고, c와 동시조건이라 삭제가 안됨

alter table test1
drop column a cascade constraints;

desc test1
select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'TEST1'; --a가 지워지면서, check제약 조건과 참조받는 조건들 다 지워짐 

alter table test1 
drop column c;

desc test1
select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'TEST1';

DESC test1

--Renaming Table Columns and Contraints
--column이름 변경 
DESC emp2
alter table emp2
rename column employee_id to empid; --to뒤에 변경할 이름
desc emp2
alter table emp2
add constraint emp2_pk primary key(empid);
select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';
alter table emp2
rename constraint emp2_pk to emp2_empid_pk; --제약조건 이름 바꾸기
select table_name, constraint_name, constraint_type, status
from user_constraints
where table_name = 'EMP2';

--Clean Test
drop table emp2 purge;
drop table test1 purge;