--���̺� ������ ����
CREATE TABLE dept (deptno   NUMBER(2),
         dname       VARCHAR2(14),
         loc         VARCHAR2(13));
DESC dept;

--�⺻�� �׽�Ʈ 
--�⺻Ű ������ ��� �߰���(������) -������ ���
INSERT INTO dept(deptno, dname)
VALUES(10, '��ȹ��');
INSERT INTO dept
VALUES(20, '������', '����');
COMMIT;
SELECT * FROM dept;

DESC employees
--rowid��� ������� ���ϱ� ���� ����
--rowid : �� ������ �����ϰ� �ĺ��ϰ� �� �� 
--rowid : ������ �ĺ���ȣ�� ���� ó���� ������� �� �ο��� -> ���� �����ɶ����� �� ���� ����������(���� �����ϰ� �˷��ִ� ��)
SELECT employee_id, rowid
FROM employees;

SELECT *
FROM employees
WHERE rowid = 'AAAE5oAAEAAAADNAAr'; --rowid (�� ��ġ��)

SELECT * FROM dept;

SELECT deptno, dname, rowid
FROM dept;

DROP TABLE dept PURGE;

















