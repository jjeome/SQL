--���Ǿ� ����
SELECT * FROM dept_sum_vu;
CREATE SYNONYM d_sum FOR dept_sum_vu; -- SYNONYM �����̸� FOR������ �����̸� �־���
SELECT * FROM d_sum;

--���Ǿ� ���� �����͵�ųʸ� ����
SELECT synonym_name, table_owner, table_name
FROM user_synonyms;

--���Ǿ� ����
DROP SYNONYM d_sum;
DROP TABLE emp;

--���̺� ���� �� ��Ÿ ��ü�鿡 ���� ���� Ȯ���ϱ�
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