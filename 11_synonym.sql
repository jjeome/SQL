--�ڵ� �ε��� ����
DROP TABLE emp;

CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY, --�̸� ����x : sys___��� ����
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4)); --�� �������� 6��

--�������� ���� ��ųʸ� ���� ����
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP';

SELECT table_name, index_name -- index�̸��� �������� �̸��� ���� �������  : �ڵ����� ������ index
FROM user_indexes
WHERE table_name = 'EMP';

--�������� �ε��� ����
CREATE INDEX emp_ename_idx ON emp(ename); --ON ���̺��̸� (�÷���)

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP';

--�ε��� ���� : �������� ����͸� ���� ����
DROP INDEX emp_email_uk; -- �ڵ����� ������� index�� ���� �� ����

DROP INDEX emp_ename_idx;

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMPLOYEES';

SELECT *
FROM employees
WHERE employee_id = 101;
