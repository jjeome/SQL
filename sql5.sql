--GROUP �Լ��� �⺻ ���
--�׷��Լ��� �׷��Լ��� ���� �� �ִ� �ֵ鳢�� ��� ����
SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM   employees;
SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM   employees
WHERE  department_id = 60;
SELECT MIN(last_name), MAX(last_name)
FROM employees;
SELECT MIN(hire_date), MAX(hire_date)
FROM employees;

--count : ���� ���� �� , DISTINCT�� �ߺ��Ǵ°� �����ϰ� ��
SELECT COUNT(*), COUNT(department_id), COUNT(DISTINCT department_id) 
FROM employees;
SELECT AVG(commission_pct), AVG(NVL(commission_pct, 0)) --??
FROM employees;

--GROUP BY ���� ��� : ����׷��� ������� 
SELECT department_id, SUM(salary), COUNT(*)
FROM employees;
SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id; --grou by���� �ִ� column�� select���� �� �� ����.
SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id
ORDER BY 1; --order by ���� �׻� �������ٿ� �����. 1�� �μ���ȣ�� ����./ null�� ���� ū ��X �׳� null�̶� �� �����ΰ�
SELECT department_id, job_id,  SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY 1,2;
SELECT department_id, job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE department_id >= 50 --where�� : from�� �ڿ� group by�� �տ� ��ġ, ���� ���� ��� 
GROUP BY department_id, job_id
ORDER BY 1,2;

--HAVING ���� ���
SELECT department_id,job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE COUNT(*) <> 1 --�ο����� 1�� �ƴ�. group������ where�� ����. where���� ������ ���� �� ����.
GROUP BY department_id, job_id
ORDER BY 1,2;

SELECT department_id,job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE department_id <> 90
GROUP BY department_id, job_id
HAVING COUNT(*) <> 1 --���� where���� Having���� �ٲ�������� group by�� �־���� having�� ���� �� ����.
--group by �� having�� ¦��
ORDER BY 1,2;


--GROUP �Լ��� ��ø 
SELECT MAX(SUM(salary))
FROM employees
GROUP BY department_id;

SELECT department_id, MAX(SUM(salary))
FROM employees
GROUP BY department_id;