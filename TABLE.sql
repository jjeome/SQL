--�⺻Ű�� �⺻�� ���� �����ϴ� ���̺� ����
CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY,
                                      dname       VARCHAR2(14),
                                      loc         VARCHAR2(13),
                                      create_date DATE DEFAULT SYSDATE);
DROP TABLE dept;
CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY, --primary key ����
                                      dname       VARCHAR2(14),
                                      loc         VARCHAR2(13),
                                      create_date DATE DEFAULT SYSDATE); --�⺻�� ���� : sysdate
--�⺻�� �׽�Ʈ
INSERT INTO dept(deptno, dname)
VALUES(10, '��ȹ��'); --�������� ������� �ʾƼ� 2�������� ����(�ߺ�x)
INSERT INTO dept
VALUES(20, '������', '����', '19/03/14'); --�������س�¥�� �⺻������ �켱�õ� (�⺻��:sysdate ����)
COMMIT;
SELECT * FROM dept;
--�������� ���������� �����ϴ� ���̺� ����
CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY, --�̸����� key�� ������ -> oracle�� �˾Ƽ� �̸��ٿ���
ename VARCHAR2(25) NOT NULL, --��Ģ�� ������
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL --�������� 2�� notnull, unique/  �̸��� emp_mail_nn , emp_mail_uk�� ������
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4)REFERENCES dept(deptno)); --column ���� �������ٶ� foreign key �� TABLE���� ��������
--�������� ���� ��ųʸ� ���� ����
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints --�������ǵ��� ���� ������ user_constraints ���̺������� ��������� user_tables
WHERE table_name = 'EMP'; --��ųʸ��� ���� where�� �������� -> �� �빮�ڷ� �����������
SELECT cc.column_name, c.constraint_name
FROM user_constraints c JOIN user_cons_columns cc -- column�� ���� �ȳ����ϱ� join�ؼ� ���� 
ON (c.constraint_name = cc.constraint_name) 
WHERE c.table_name = 'EMP';
SELECT table_name, index_name
FROM user_indexes
WHERE table_name IN ('DEPT','EMP');

--DML�� �����ϸ� �������� �׽�Ʈ�ϱ� : �ΙD���̺��� �⺻Ű �μ���ȣ / ������̺��� �⺻Ű �����ȣ / �����ȣ�� �����ϴ� ����Ű
INSERT INTO emp
VALUES(null, '�����','shkim@naver.com','01023456789','ȸ���',3500, null); --�⺻Ű�� null���̶� ����
INSERT INTO emp
VALUES(1234, '�����','shkim@naver.com','01023456789','ȸ���',3500, null); --�μ���ȣ�� null����
INSERT INTO emp
VALUES(1223, '�ڳ���','nrpark@gmail.com','01054359876',null,1800, 20); -- �޿� ���� ������ ������ �ȵ�(2000�̻��̿��� ��)
INSERT INTO emp
VALUES(1223, '�ڳ���','nrpark@gmail.com','01054359876',null,7800, 20);
COMMIT;
SELECT * FROM emp;
UPDATE emp
SET deptno=30 --���� �μ���ȣ�� �ȵ�
WHERE empno=1234;
UPDATE emp
SET deptno=10
WHERE empno=1234;
COMMIT;
DELETE FROM dept --�ڽ��־ ������ �ȵ�
WHERE deptno=10;
SELECT * FROM emp;