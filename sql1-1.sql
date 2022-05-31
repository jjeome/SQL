SELECT *
FROM employees;
SELECT *
FROM departments;
SELECT location_ID, department_NAME
FROM departments;
SELECT location_id, department_name FROM departments;
select location_id, department_name from departments;
--ǥ����(expression)
SELECT employee_id, last_name, salary, salary*12
FROM employees;
SELECT employee_id, last_name, salary, salary+100*12, (salary+100)*12
FROM employees;
SELECT employee_id, last_name, salary, salary*12 ����
FROM employees;
--AS:��Ī ���� ����, �ѱ� ���� �� ����
--���� Ư������ ���->'_'���(���� ����)
SELECT employee_id, last_name, salary, salary*12 annual_salary
FROM employees;
--��Ī�� ū����ǥ �ȿ� ������ ���ϴ´�� ǥ�� ����
SELECT employee_id, last_name, salary, salary*12 "Annual Salary"
FROM employees;
SELECT employee_id empno, last_name empname, salary, salary*12
FROM employees;
--�Ϲ� column�鵵 ��Ī���� ����� �� ����
SELECT employee_id, last_name, salary,
           salary*12 "Annual Salary"
FROM employees;
--�鿩�����ϸ� ����
--���Ῥ����(||) DB������ ���
SELECT employee_id, first_name, last_name
FROM employees;
SELECT employee_id, first_name||last_name full_name
FROM employees;
SELECT employee_id, first_name||' '||last_name full_name
FROM employees;
--���Ῥ���� ���̿� ���� �ִ� ��,  ���� �߰��ϴ� ��
SELECT employee_id, first_name||' '||last_name, email || '@yd.com' AS email
FROM employees;
SELECT last_name ||' : '|| salary
FROM employees;
--''�ΰ��� ���� ���� �߻�
--'�߰� ���ָ� ����� or q'[]�� ��Ȯ�ϰ� ǥ��
--q������ -> ������
SELECT last_name ||'''s salary : '|| salary
FROM employees;
SELECT last_name ||q'['s salary : ]'|| salary
FROM employees;

--DISTINCT
--�ߺ����� ���� column ��� �ߺ����� ��������
SELECT department_id
FROM employees;
SELECT DISTINCT department_id
FROM employees;
--SELECT �ٷ� �ڿ��� �ѹ��� ��� ����
SELECT DISTINCT department_id, job_id
FROM employees;

--NULL��(�ƹ��͵� �������� ���� ����, 0 �Ǵ� ����� �ٸ� ����)
SELECT employee_id, last_name, manager_id, commission_pct, department_id
FROM employees;
--��������� commission �� �ٸ� ����� null ��
SELECT employee_id, last_name, salary, commission_pct,
            salary + salary*commission_pct AS �Ǳ޿�
FROM employees;
--ǥ���Ŀ� null���� ���� ������ null�� ���´�

--���̺���(������)
DESCRIBE employees;
--�߰���ɾ� DESCRIBE:coloumn�� ���� ���� ����
--���:DESC
--NOT NULL:�ʼ��� �Է��ؾ���
DESC deparments;