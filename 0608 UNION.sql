SELECT *
FROM job_history;
--1.UNION
--�ߺ��� ���ŵ�
SELECT employee_id FROM employees
UNION
SELECT employee_id FROM job_history;

--�ߺ��� �� ���ŵ�
--ù ��° column(employee_id)�� ���� ���ĵ�
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, department_id FROM job_history;
--employee_id�� ���� ���� �����൵ ��
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, department_id FROM job_history
ORDER BY 2;

--����
--column�� �ٸ��� ����ȵ�
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id FROM job_history;
--������ �����ִ� ���
--job_id�� ������ ������Ÿ��
SELECT employee_id, job_id FROM job_history
UNION
SELECT employee_id, TO_CHAR(null) FROM employees;

--����
--department_id:����, job_id=����(������Ÿ���� ���ƾ� ��)
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, job_id FROM job_history;

--ù��° SELECT���� column ���
SELECT employee_id �����ȣ, department_id FROM employees
UNION
SELECT employee_id, department_id �μ���ȣ FROM job_history;

--2.UNION ALL
--�ߺ� ���� X
SELECT employee_id �����ȣ, department_id �μ���ȣ FROM employees
UNION ALL
SELECT employee_id, department_id FROM job_history;

--3.INTERSECT(������)
--������ ���ߴ� �μ��� �ٽ� �� �����
SELECT employee_id, department_id FROM employees
INTERSECT
SELECT employee_id, department_id FROM job_history;

--4.MINUS 
--�Ի��ϰ� ���� ��ȣ�� �μ��� ������� �ʾҴ� �����
--job_history�� ������� ����
--���������� �־ ����� �� �ִ�
SELECT employee_id FROM employees
MINUS
SELECT employee_id FROM job_history;
--����
SELECT employee_id, last_name, job_id
FROM employees
WHERE employee_id IN
                            (SELECT employee_id FROM employees
                            MINUS
                            SELECT employee_id FROM job_history);
--����� ����
--history���� �ְ� ���� employee���� ����
SELECT employee_id FROM job_history
MINUS
SELECT employee_id FROM employees;

--COLUMN���� DATATYPE ��Ī��Ű�� ����
SELECT department_id, job_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id, job_id;
SELECT department_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id;
SELECT COUNT(*), SUM(salary)
FROM employees;
--COLUMN���� DATATYPE ��Ī��Ű�� ����
--������ ���� ���鶧 ���� 
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