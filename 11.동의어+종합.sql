--동의어 생성
SELECT * FROM dept_sum_vu;
CREATE SYNONYM d_sum FOR dept_sum_vu; -- SYNONYM 만들이름 FOR다음에 원본이름 넣어줌
SELECT * FROM d_sum;

--동의어 관련 데이터딕셔너리 보기
SELECT synonym_name, table_owner, table_name
FROM user_synonyms;

--동의어 삭제
DROP SYNONYM d_sum;
DROP TABLE emp;

--테이블 삭제 시 기타 객체들에 대한 정보 확인하기
CREATE TABLE test
(empno NUMBER(6) PRIMARY KEY,
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4));

CREATE INDEX test_job_ix 
ON test(job);

CREATE SEQUENCE test_no_seq
INCREMENT BY 1
START WITH 301
NOCACHE
NOCYCLE;

CREATE VIEW test_sum_vu
AS
SELECT empno, ename, job, deptno
FROM test;

CREATE SYNONYM t
FOR test_sum_vu;

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'TEST';

SELECT object_name,object_type, status FROM user_objects
WHERE object_name LIKE 'TEST%' OR object_name ='T';

DROP TABLE test;

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'TEST';

SELECT object_name,object_type, status FROM user_objects
WHERE object_name LIKE 'TEST%' OR object_name ='T';

DROP sequence test_no_seq;

DROP VIEW test_sum_vu;

DROP SYNONYM t;