--Subquery�� �⺻ ���

SELECT  salary
FROM employees
WHERE last_name = 'Grant'; -- (������ �������� : ����� �ϳ��� ��ȯ�ϴ� ��)

SELECT *
FROM employees
WHERE salary > ( SELECT  salary                    --���������� ������ �ִ� ��������
                        FROM employees
                        WHERE last_name = 'Grant') --��ȣ�ȿ� ������ ����ִ� ��������
AND hire_date < (SELECT hire_date
                        FROM employees
                        WHERE last_name = 'Grant');
                        
SELECT salary 
FROM employees
WHERE last_name = 'Abel';
SELECT *
FROM employees
WHERE salary > 11000;
SELECT *
FROM employees
WHERE salary > (SELECT salary 
                             FROM employees
                            WHERE last_name = 'Abel');
                            
--������ ��������(Single Row Subquery)
SELECT last_name, job_id, salary
FROM   employees
WHERE  job_id =  
                             (SELECT job_id                         --���� ���������� ������ �����Ͱ� 1���ϱ� ������. 
                              FROM   employees
                              WHERE  last_name = 'Matos')
AND    salary >
                             (SELECT salary
                              FROM   employees
                              WHERE  last_name = 'Matos');
SELECT MAX(salary) 
FROM employees; 
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees);  -- �޿��Ӹ��� �ƴ϶� �޿��� �޴� ����� �˰� ���� �� ��������
SELECT   department_id, COUNT(*)
FROM     employees
GROUP BY department_id 
HAVING  COUNT(*) > (SELECT COUNT(*) --HAVING���� group by���� ��� �Ұ�. group�ȿ��� ���� ��.
                                         FROM   employees
                                         WHERE  department_id = 20); -- 20������ ���� ����� ã��.         
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees
                             WHERE department_id = 60);  --60���̶�� id�� ���� ����� 1�� �� ������ 
                             
--���� �� ��������(Multiple Row Subquery)  : ���������� �� �� ���������� �� 
SELECT MAX(salary) 
FROM employees
GROUP BY department_id;
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) -- =������ �Ἥ ������ ���������� �ν��� ������
                              FROM employees
                              GROUP BY department_id);    
SELECT last_name, job_id, salary
FROM   employees
WHERE salary IN (SELECT MAX(salary) --������ �������� �� �� IN
                               FROM employees
                              GROUP BY department_id);  
SELECT salary 
FROM employees
WHERE department_id = 60;              
SELECT last_name, job_id, salary
FROM   employees
WHERE salary > (SELECT salary -- >������ ������
                              FROM employees
                             WHERE department_id = 60)
AND department_id <> 60;      
SELECT last_name, job_id, salary
FROM   employees
WHERE salary >ANY (SELECT salary --ANY�� �ƹ��ų� ���� ũ�ų���� ��
                                      FROM employees
                                      WHERE department_id = 60)
AND department_id <> 60; --�߰����� : 60���� �� �����ϱ� ���ذ�.
SELECT last_name, job_id, salary
FROM   employees
WHERE salary >ALL (SELECT salary --���� ���� ũ�ų� ��� �� 
                                    FROM employees
                                    WHERE department_id = 60)
AND department_id <> 60;

--Subquery ��� �� ���ǻ���
--1. ���������� ���� ������ �� �� ���� �����غ���
SELECT last_name, job_id, salary
FROM   employees
WHERE salary > (SELECT salary
                              FROM employees
                              WHERE last_name = 'Mark');

SELECT employee_id, last_name
FROM employees 
WHERE employee_id IN (SELECT manager_id -- manager��ȣ�� �ڱ� �����ȣ�� ������ ��� ã��
                                           FROM employees);
                                           
SELECT DISTINCT manager_id 
FROM employees;
                                           
                                           
SELECT employee_id, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id
                                                    FROM employees);    
SELECT employee_id, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id
                                                    FROM employees
                                                     WHERE manager_id IS NOT NULL);  --���Ե� NULL���� �������� �Ϸ���    
                                                     
DESC employees; --NOT NULL�� ���ٸ� �������� NULL�� ���� �� �ִٴ� ��.