--���̺� ���� �ϱ�
SELECT  employee_id, last_name, salary*12 ANNSAL, hire_date --���̺�ȿ� salary*12���� ���� column�� ������ ��Ī�� �ʼ��� 
FROM    employees 
WHERE   department_id = 80;

CREATE TABLE 	dept80
AS  SELECT  employee_id, last_name, salary*12 ANNSAL, hire_date --���̺�� �ȿ� �����ͱ��� �״�� SELECT�� �����
FROM    employees 
WHERE   department_id = 80;
SELECT * FROM dept80;

--���̺� �б� ���� ���� �׽�Ʈ
ALTER TABLE emp READ ONLY; --�б����� ����� �� �� dml�Ϸ��� �ϸ� �ȉ� 
UPDATE emp
SET salary = salary*1.1;
ALTER TABLE emp READ WRITE; --�ٽ� dmlǮ����

--���̺� ���� : ������ DROP����ϱ� ex.drop user
DROP TABLE dept; --emp�� ���� ����� dept�� ������
DROP TABLE emp;
DROP TABLE dept;
SELECT * FROM emp;
SELECT table_name, index_name
FROM user_indexes
WHERE table_name IN ('DEPT','EMP');

--ON DELETE �� �ǽ��� ���� ���̺� ���� : 
CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY, --�μ��� �θ�, ����� �ڽ����̺�
         dname       VARCHAR2(14),
         loc         VARCHAR2(13),
         create_date DATE DEFAULT SYSDATE);
INSERT INTO dept(deptno, dname)
VALUES(10, '��ȹ��');
INSERT INTO dept
VALUES(20, '������', '����', '19/03/14');
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
CONSTRAINT emp_deptno_fk FOREIGN KEY(deptno) REFERENCES dept(deptno) ON DELETE CASCADE); --ON DELETE CASCADE�� �� ������, �θ�Ű�� �������� �ڽ�Ű�� ���������ϱ� ���ؼ�.

--constraint�� ���̺��� �������
INSERT INTO emp
VALUES(1234, '�����','shkim@naver.com','01023456789','ȸ���',3500, 10);
INSERT INTO emp
VALUES(1223, '�ڳ���','nrpark@gmail.com','01054359876',null,7800, 20);
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
VALUES(1234, '�����','shkim@naver.com','01023456789','ȸ���',3500, 10);
INSERT INTO emp
VALUES(1223, '�ڳ���','nrpark@gmail.com','01054359876',null,7800, 20);
COMMIT;
DELETE FROM dept
WHERE deptno = 20;
SELECT * FROM dept;
SELECT * FROM emp; -- �ڵ����� ����� null���� ��
ROLLBACK;

--CASCADE CONSTRAINTS Test : �ڽ��� ������ �θ� ������(���̺�)
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints --���� ������ Ȯ���ϴ� ��
WHERE table_name = 'EMP';
DROP TABLE dept;
DROP TABLE dept CASCADE CONSTRAINTS;
SELECT * FROM dept; -- �μ��� �����⶧����
SELECT * FROM emp; -- ȸ�翡 �ִ� �μ����� �ƴ��� �𸣰Ե���
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP'; -- �� �θ� �����ϴ� �ܷ�Ű�� �� ����(�ڽ�Ű�� �θ�Ű�� ���� ����)
DROP TABLE emp;