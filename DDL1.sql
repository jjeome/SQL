--1�� HR
INSERT INTO departments
VALUES (70, 'Public Relations', 100, 1700); --�μ��̸��̶� ' '���� column������� �� ��������� ��
SELECT * FROM departments; --������ DB�� Ư��, �������� ���� �߱��������� ��. ����ġ�� ������ �� ����. ������� ������ �ű⿡ ä���� �� ����(Ʃ���� ������)

--1�� HR
ROLLBACK;
SELECT * FROM departments;

--1�� HR
INSERT INTO departments
VALUES (70, 'Public Relations', 100, 1700);
SELECT * FROM departments;
COMMIT; 

--Ư���� �� �Է�
--SYSDATE �Է�
INSERT INTO employees 
VALUES		   (113,  'Louis', 'Popp', 'LPOPP', '515.124.4567', 
                        SYSDATE, 'AC_ACCOUNT', 6900,  NULL, 205, 110); --���� ��¥:SYSDATE (�ð������� ����)
--TO_DATE �Լ� ��� : ��§�� DB�� ��¥���� �𸦶� ��¥��� ���������ִ� �Լ� 
INSERT INTO employees
VALUES      (114, 'Den', 'Raphealy', 'DRAPHEAL', '515.127.4561',
                      TO_DATE('02 03, 99', 'MM DD, YY'), 'SA_REP', 11000, 0.2, 100, 60); --YY : ���� ������ ����
INSERT INTO employees
VALUES      (115, 'Mark', 'Kim', 'MKIM', '515.127.4562',
                      TO_DATE('02 03, 99', 'MM DD, RR'), --RR : ���缼�� 50�� �ȳѾ���ϱ� ��������.
                      'SA_REP', 13000, 0.25, 100, 60);             
SELECT * FROM employees;
SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy/mm/dd') AS hire_date --�⵵ �ø���
FROM employees;

--�ٸ� ���̺�� �� ����
--���̺� ���� �������� (���� �־��ָ� ���� �״�� �����) -> ������ ������ ����(������縸)
SELECT employee_id id, last_name name, salary, commission_pct
FROM employees
WHERE 1=2;

CREATE TABLE sales_reps 
AS 
SELECT employee_id id, last_name name, salary, commission_pct
FROM employees
WHERE 1=2;

DESC sales_reps;

SELECT * FROM sales_reps;

INSERT INTO sales_reps --�ѹ��� �������� �����ؼ� �ѹ��� ���� �� ����. (�ٸ����̺��� ���� ������� ����)
SELECT employee_id, last_name, salary, commission_pct
FROM   employees
WHERE  job_id LIKE '%REP%';
SELECT * FROM sales_reps;
COMMIT;

--ġȯ���� ���(40, Human Resource, 2500 �Է�)
INSERT INTO departments(department_id, department_name, location_id)
VALUES     (&department_id, '&department_name',&location); -- ���� ���� ���� �־���ϴµ� INSERT INTO�� �ѹ��� ������ ����
COMMIT;
SELECT*FROM departments;

--UPDATE
--1�� HR
UPDATE employees
SET salary= 7000;
SELECT * FROM employees;
ROLLBACK;
UPDATE employees
SET salary= 7000
WHERE employee_id = 104; --���ü��� �����ϴ� ��Ŀ������ rock��Ŀ�����̶� ��
--(DML)�� ���� ����ϰ� �ִ� ���� rock�̵Ǿ� transaction�� ������ rock�� Ǯ�� ����߿� Ÿ����ڰ� ��� ����
ROLLBACK;

--���������� ����� UPDATE
UPDATE   employees
SET      job_id  = (SELECT  job_id 
                              FROM    employees 
                              WHERE   employee_id = 205), 
             salary  = (SELECT  salary 
                             FROM    employees 
                              WHERE   employee_id = 205) 
WHERE    employee_id    =  113;

--�μ���ȣ�� �𸣰� �̸��� �ܾ ��ﳯ�� LIKE�������� ������ ������Ʈ ��
UPDATE employees
SET  department_id =
                                      (SELECT department_id
                                       FROM   departments
                                       WHERE  department_name LIKE '%Public%')
WHERE employee_id = 115;
COMMIT;

--DELETE
DELETE FROM departments
WHERE  department_name = 'Finance';
DELETE FROM employees
WHERE  department_id =
                                             (SELECT department_id
                                              FROM   departments
                                              WHERE  department_name LIKE '%Public%'); --department�̸��� public���� �� �μ��̸��� delete.
COMMIT;

DELETE FROM departments; --DB���� ���� ����

--DELETE �� TRUNCATE
SELECT * FROM sales_reps;
DELETE FROM sales_reps;
SELECT * FROM sales_reps;
ROLLBACK;
SELECT * FROM sales_reps;

--TRUNCATE -> ��ɹ��� ī�װ��� DDL��. �ڵ� commit��. ���̺��� ó�� ���Ż��·� ���ư��� delete�� ����� ���ΰ� �ȿ� ���� ������
TRUNCATE TABLE sales_reps;
SELECT * FROM sales_reps;
ROLLBACK;
SELECT * FROM sales_reps;
INSERT INTO sales_reps
SELECT employee_id, last_name, salary, commission_pct
FROM   employees
WHERE  job_id LIKE '%REP%';
SELECT * FROM sales_reps;
COMMIT;

CREATE TABLE bigemp --����� employees�� �Ȱ��� �������� ���̺�� �ٸ�.
AS
SELECT * FROM employees;
SELECT *FROM bigemp;

DELETE FROM bigemp;
ROLLBACK;

INSERT INTO bigemp
SELECT *FROM bigemp;

COMMIT;

UPDATE bigemp
SET salary = salary*1.1;
ROLLBACK;

DELETE bigemp; --�����͸��������� �뷮�� �״�� ����

TRUNCATE TABLE bigemp; --undo�� ���� ���ص� �Ǽ� delete�� �ٸ��� ������ ������
SELECT *FROM bigemp;
