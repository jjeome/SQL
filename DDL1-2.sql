--2�� HR 
--TRANSACTION�� Ư¡ (��������)
SELECT * FROM departments; --�������� transaction�� ����(��������)�� ����
INSERT INTO	departments (department_id, department_name)
VALUES		(30, 'Purchasing'); --������ �������� ���� column���� ������ null���� ��
INSERT INTO	departments
VALUES		(100, 'Finance', NULL, NULL); --��������� null���� ������
SELECT * FROM departments;
COMMIT; --Ŀ���� ���� ����� transaction�� �����Ǿ� -> �ϰ��� �ִ� �����͸� ������
SELECT * FROM employees;

SELECT employee_id, last_name, salary, commission_pct
FROM   employees
WHERE  job_id LIKE '%REP%';

INSERT INTO sales_reps --�ѹ��� �������� �����ؼ� ���� �� ����.
SELECT employee_id, last_name, salary, commission_pct
FROM   employees
WHERE  job_id LIKE '%REP%';
SELECT * FROM sales_reps;
COMMIT;
SELECT * FROM sales_reps;

--UPDATE
--2�� HR
UPDATE employees
SET salary= salary*1.1
WHERE employee_id = 104;
ROLLBACK;