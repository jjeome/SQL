--ID ST_CLERK �������� �ʴºμ��� ID ����
SELECT department_id FROM departments
MINUS
SELECT department_id FROM employees
WHERE job_id = 'ST_CLERK';

--SET������ ����� �ش� ������ �μ��� ���� ���� ID�� ���� �̸��� ǥ���Ͻÿ�.
SELECT country_id, country_name FROM countries
MINUS 
SELECT l.country_id, c.country_name
FROM locations l JOIN countries c
ON(l.country_id = c.country_id);

--�Ի� ���� ���� ������ ���� ������ ����� ���� �ִ� ���(������ ����Ǿ��ٰ� ������ ������ ���͵� ���)�� 
--��� ID�� ���� ID�� �����Ͻÿ�.
SELECT employee_id, job_id 
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history;

--�Ҽӵ� �μ��� ������� EMPLOYEES ���̺� �ִ� ��� ����� �̸��� �μ� ID
--�Ҽӵ� ����� ������� DEPARTMENTS ���̺� �ִ� ��� �μ��� �μ� ID�� �μ� �̸�
SELECT last_name, department_id, TO_CHAR(null)
FROM employees
UNION
SELECT TO_CHAR(null), department_id, department_name
FROM departments;

CREATE TABLE my_employee
 (id NUMBER(4) CONSTRAINT my_employee_id_nn NOT NULL,
 last_name VARCHAR2(25),
 first_name VARCHAR2(25),
 userid VARCHAR2(8),
 salary NUMBER(9,2));




--���� ���� �������� ù��° ������ ��(row)�� MY_EMPLOYEE ���̺� �߰��Ͻÿ�. 
--�̶� INSERT ���� ���� �������� ���ÿ�.
DESCRIBE my_employee

INSERT INTO my_employee
VALUES (1, 'Patel', 'Ralph', 'rpatel', 895);

--���� ��Ͽ� �ִ� ���� �������� �� ��° ���� MY_EMPLOYEE ���̺� �߰��Ͻÿ�. 
--�̹����� INSERT ���� ������������� �����Ͻÿ�. 
INSERT INTO my_employee (id, last_name, first_name, userid, salary)
VALUES (2, 'Dancs', 'Betty', 'bdancs', 860);

-- ���̺� �߰��� �׸��� Ȯ��
SELECT * FROM my_employee;

--��� 3�� ���� Drexler�� ����
UPDATE my_employee
SET last_name = 'Drexler'
WHERE id = 3;

--�޿��� 900 �̸��� ��� ����� �޿��� 1000���� �����ϰ� ���̺��� ���� ������ Ȯ��
UPDATE my_employee
SET salary = 1000
WHERE salary<900;
SELECT last_name, salary
FROM my_employee;

--MY_EMPLOYEE ���̺��� Betty Dancs�� �����ϰ� ���̺��� ���� ������ Ȯ��
DELETE FROM my_employee
WHERE last_name = 'Dancs';

SELECT * FROM my_employee;

COMMIT;

