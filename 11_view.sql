--�� ������ ���
CREATE VIEW 	empvu80
AS SELECT  employee_id, last_name, salary
FROM    employees
WHERE   department_id = 80;

--view
SELECT * 
FROM empvu80;
--table
SELECT *
FROM dept80;

--�������̺�� �� �ٸ���? 
--���̺��� ����� ������ �����͸� ���� �����ؼ� ����Ǵµ�, ��� SELECT������ DB�� ������ SELECT�� �����ؼ� ���°Ŷ� �Ȱ���.
--view�� ���� : ������ ª�� ����� ������
--���̺��� ī�ǵ� ���̺� ������ �����ѵ�, ��� �����ؼ� �����ϸ� ������ ������ 
UPDATE employees
SET salary = salary*1.2
WHERE department_id = 80;

DELETE FROM empvu80
WHERE employee_id=176;
DELETE FROM dept80
WHERE employee_id=149;

SELECT employee_id, salary,salary*12
FROM employees
WHERE department_id = 80;

SELECT *
FROM employees
WHERE department_id=80;

ROLLBACK;

--�ܼ��� : dml�� ���ؼ� ���� ����
--ex. enpv80
--���պ� : ��¥ ���̺� ���� ���� �÷�(ǥ�����̳� �Լ��� ����)�� ������ �־ ������ �������� ����
--�並 ���鶧 ǥ�������� ���� ����� �����ѵ�, �� ��� �������̺��� ���� ���̺��̱⶧���� ������ �Ұ�

CREATE VIEW 	salvu50
AS SELECT  employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY --���̺� ���� ���� ���(ǥ���ĵ� �� �� ����)
FROM    employees
WHERE   department_id = 50;
DESC empvu80
SELECT * FROM empvu80;
DESC salvu50
SELECT * FROM salvu50;

--��� ����� ���̺� ��
SELECT * FROM dept80;
SELECT * FROM empvu80;
SELECT * FROM salvu50;
SELECT employee_id, last_name, salary*12, hire_date, department_id
FROM employees
WHERE department_ID IN (50, 80);
UPDATE employees
SET salary = salary*1.1;
COMMIT;
SELECT * FROM dept80;
SELECT * FROM empvu80;
SELECT * FROM salvu50;

--�� ���� �����͵�ųʸ� ���� Ȯ��
SELECT view_name, text
FROM user_views; --���� ��ųʸ� ����

--������ϱ� : ��� ����ȭ���� ���� ��ü. (���̺��� ���� ��ü) -> oracle������ ALTER�� �並 �������� X
-- oracel  : create of replace view 
CREATE OR REPLACE VIEW 	salvu50
AS SELECT  employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY, hire_date           
FROM    employees
WHERE   department_id = 50;
SELECT view_name, text
FROM user_views;

--COMPLEX VIEW ����

--�μ��� ��� JOIN 
SELECT   d.department_name, MIN(e.salary), --���̺� ���� ���� column�̴ϱ� ��Ī �ʼ�
            MAX(e.salary),TRUNC(AVG(e.salary))
   FROM     employees e JOIN departments d
   ON       (e.department_id = d.department_id)
   GROUP BY d.department_name;

CREATE OR REPLACE VIEW dept_sum_vu
  (name, minsal, maxsal, avgsal) --1)view��ɹ� �� ��ȣ�ȿ� ��Ī�� �Ѳ����� ���� / 2)�������� ���� AS�Ἥ ����
AS SELECT   d.department_name, MIN(e.salary), 
            MAX(e.salary),TRUNC(AVG(e.salary))
   FROM     employees e JOIN departments d
   ON       (e.department_id = d.department_id)
   GROUP BY d.department_name;
SELECT * FROM dept_sum_vu;

SELECT * FROM dept_sum_vu --view
WHERE minsal > 8000;

--VIEW�� ���� DML 
desc empvu80
INSERT INTO empvu80
VALUES(250, 'Test', 4000); --���õ��� ���� �÷��� not null�̶�. (���õ��� ���� �÷����� null���� ������)
SELECT employee_id, salary
FROM employees
WHERE employee_id = 149;
SELECT * FROM empvu80;
UPDATE empvu80 --view���� ������Ʈ�ϴ� ��
SET salary=20000
WHERE employee_id = 149;
SELECT employee_id, salary --Ȯ���� ��¥ ���̺� ����
FROM employees
WHERE employee_id = 149;
SELECT * FROM empvu80;
ROLLBACK;

--WITH CHECK OPTION ���
CREATE OR REPLACE VIEW empvu80 --view�� ���ۼ�
AS SELECT  employee_id, last_name, salary, department_id --�ܼ�view
FROM    employees
WHERE   department_id = 80;
SELECT * FROM empvu80;
UPDATE empvu80
SET salary = 9800
WHERE employee_id = 176;
SELECT * FROM empvu80;
ROLLBACK;
UPDATE empvu80
SET department_id = 60
WHERE employee_id = 176;
SELECT * FROM empvu80;
ROLLBACK;

CREATE OR REPLACE VIEW empvu80
AS SELECT  employee_id, last_name, salary, department_id
FROM    employees
WHERE   department_id = 80
WITH CHECK OPTION; -- view�� ���� �� where���� ������ ���ǵ帲 (view�� ������ WHERE����)

UPDATE empvu80
SET department_id = 60
WHERE employee_id = 176;
UPDATE empvu80
SET salary = 9800
WHERE employee_id = 176;
ROLLBACK;

--WITH READ ONLY �ɼ� : �ܼ����̱� ������ dml�� ���ϰ� �ϴ� �� -> ������ ���� ���̺��� ��
CREATE OR REPLACE VIEW empvu80
AS SELECT  employee_id, last_name, salary, department_id
FROM    employees
WHERE   department_id = 80
WITH READ ONLY;
UPDATE empvu80
SET salary = 9800
WHERE employee_id = 176;

--���� ���� -> table�� ����������  dictionary��Ͽ����� ���̻� view�� ������� �ʰ� �����ϴ� ��
SELECT view_name, text
FROM user_views;
DROP VIEW empvu80;
SELECT view_name, text
FROM user_views;
SELECT * FROM empvu80;

DROP VIEW salvu50;
DROP VIEW dept_sum_vu;