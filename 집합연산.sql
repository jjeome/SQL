--UNION
SELECT *
FROM job_history;

SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, job_id FROM job_history;

SELECT employee_id �����ȣ , department_id FROM employees
UNION
SELECT employee_id, department_id �μ���ȣ FROM job_history
ORDER BY 1;

SELECT employee_id �����ȣ , department_id FROM employees
UNION ALL
SELECT employee_id, department_id �μ���ȣ FROM job_history;

--������ ���ߴ� �μ��� �ٽ� �� �����
SELECT employee_id, department_id FROM employees
INTERSECT
SELECT employee_id, department_id FROM job_history;

--�Ի��� ���� �μ� ������ ������ �����
SELECT employee_id, last_name, job_id
FROM employees
WHERE employee_id IN (SELECT employee_id FROM employees
                                  MINUS
                                  SELECT employee_id FROM job_history);

--����� ����                                
SELECT employee_id FROM job_history
MINUS
SELECT employee_id FROM employees;

--coulmn�� ���� ���߱�
--������ Ÿ�Ը� �����ִ� TO_CHAR
SELECT employee_id, job_id FROM job_history
UNION
SELECT employee_id, TO_CHAR(null) FROM employees;

SELECT department_id, job_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id, job_id
UNION
SELECT department_id, TO_CHAR(null), COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id
UNION
SELECT TO_NUMBER(null), TO_CHAR(null), COUNT(*), SUM(salary)
FROM employees
ORDER BY 1,2;