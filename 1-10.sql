--테이블 복사 하기
SELECT  employee_id, last_name, salary*12 ANNSAL, hire_date --테이블안에 salary*12같이 없는 column은 무조건 별칭이 필수임 
FROM    employees 
WHERE   department_id = 80;

CREATE TABLE 	dept80
AS  SELECT  employee_id, last_name, salary*12 ANNSAL, hire_date --테이블과 안에 데이터까지 그대로 SELECT절 복사됨
FROM    employees 
WHERE   department_id = 80;
SELECT * FROM dept80;

--테이블 읽기 전용 설정 테스트
ALTER TABLE emp READ ONLY; --읽기전용 만들고 난 후 dml하려고 하면 안됌 
UPDATE emp
SET salary = salary*1.1;
ALTER TABLE emp READ WRITE; --다시 dml풀어줌

--테이블 삭제 : 무조건 DROP사용하기 ex.drop user
DROP TABLE dept; --emp를 먼저 지우면 dept도 지워짐
DROP TABLE emp;
DROP TABLE dept;
SELECT * FROM emp;
SELECT table_name, index_name
FROM user_indexes
WHERE table_name IN ('DEPT','EMP');

--ON DELETE 절 실습을 위한 테이블 생성 : 
CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY, --부서가 부모, 사원이 자식테이블
         dname       VARCHAR2(14),
         loc         VARCHAR2(13),
         create_date DATE DEFAULT SYSDATE);
INSERT INTO dept(deptno, dname)
VALUES(10, '기획부');
INSERT INTO dept
VALUES(20, '영업부', '서울', '19/03/14');
COMMIT;
SELECT * FROM dept;

-- ON DELETE CASCADE Test
CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4),
CONSTRAINT emp_deptno_fk FOREIGN KEY(deptno) REFERENCES dept(deptno) ON DELETE CASCADE); --ON DELETE CASCADE를 쓴 이유는, 부모키가 지워지면 자식키도 지워지게하기 위해서.

--constraint는 테이블이 만들어진
INSERT INTO emp
VALUES(1234, '김수현','shkim@naver.com','01023456789','회사원',3500, 10);
INSERT INTO emp
VALUES(1223, '박나래','nrpark@gmail.com','01054359876',null,7800, 20);
COMMIT;
DELETE FROM dept
WHERE deptno = 20;
SELECT * FROM dept;
SELECT * FROM emp;
ROLLBACK;
DROP TABLE emp;

--ON DELETE SET NULL Test
CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4),
CONSTRAINT emp_deptno_fk FOREIGN KEY(deptno) REFERENCES dept(deptno) ON DELETE SET NULL);
INSERT INTO emp
VALUES(1234, '김수현','shkim@naver.com','01023456789','회사원',3500, 10);
INSERT INTO emp
VALUES(1223, '박나래','nrpark@gmail.com','01054359876',null,7800, 20);
COMMIT;
DELETE FROM dept
WHERE deptno = 20;
SELECT * FROM dept;
SELECT * FROM emp; -- 자동으로 사원이 null값이 됨
ROLLBACK;

--CASCADE CONSTRAINTS Test : 자식을 지워야 부모도 지워짐(테이블)
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints --제약 조건을 확인하는 절
WHERE table_name = 'EMP';
DROP TABLE dept;
DROP TABLE dept CASCADE CONSTRAINTS;
SELECT * FROM dept; -- 부서를 지웠기때문에
SELECT * FROM emp; -- 회사에 있는 부서인지 아닌지 모르게됐음
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP'; -- 이 부모를 참조하던 외래키를 다 지움(자식키와 부모키의 관계 지움)
DROP TABLE emp;