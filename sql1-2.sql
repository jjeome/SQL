SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees;
--WHERE���� �⺻ ����
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id > 50;
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id = 50;
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id >= 50;
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id <> 50; -- ���� �ʴ�

--���ڵ������� ��
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name = 'king';
--WHERE���� �����ϴ� �����Ͱ� ������
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name = 'king';
--���ڴ� ' ' ���, ��ҹ��� �� ���� ��ġ ���Ѿ���
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name <> 'King';
--���ڵ� ũ��񱳰� ������(�ѱ�>����)
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name >= 'King';
--��¥ �������� ��(��¥�� ��¥������ Ÿ���̶�� ���� ����)
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE hire_date = '97/09/17'; 
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE hire_date = '1997/09/17'; 
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE hire_date = '97-09-17'; --���̺� ������ ������ ���������
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE hire_date <>'1997/09/17';
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE hire_date > '1997/09/17'; --��¥�� ���ŷ� ���� �۾����� �̷��� ������ ���� Ŀ��

--SQL�񱳿�����(IN/LIKE/BETWEEN/IS NULL)
--IN
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id IN(50,60);  --��ȣ �ȿ� 50 �Ǵ� 60, ������ ���� �� ����
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name IN ('De Haan','Abel');

--LIKE
--���ϵ�ī�� : ����ϴ� ����
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name LIKE 'K%'; --like�� %�� ���̾��� -> (�빮��)K�� �̸��� �����ϴ� ��� ã�� ��, %�ڸ��� 0���̻�
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name LIKE '%a%'; --��ġ������� �ҹ��� a�� ���� ��� 
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name LIKE '%s';  -- S�� ������ ���
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name LIKE '_a%'; --�ι�° ���ڰ� a�� ��� 
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name LIKE '____'; --����ٸ� 4���� �̸��� 4������ ���
SELECT employee_id, last_name, hire_date, salary, department_id, job_id
FROM employees;
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE job_id LIKE 'IT\_%' ESCAPE '\'; --����ó���� ���� �ٷ� �տ� ��ȣ�� �Ἥ ���ϵ� ī��(_)�� �ƴ϶�� ���� �˷��� �� �ѱ���

--BETWEEN
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE salary BETWEEN 9000 AND 6000; -- (6000�̻� 9000����)
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name BETWEEN 'Abel' AND 'Fay'; --���ĺ� ������� ���������
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE hire_date BETWEEN '99/01/01' AND '99/12/31'; --99�⵵�� �Ի��� ���

--IS NULL : null�� �˻��ϴ� ������ ������
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id is null; -- =null�� �˻��ϸ� �ȵǰ� is null�� �˻��ϱ�

--��������(AND/OR/NOT)
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id IN (50,60,80)
AND salary > 9000; -- IN�����̶� AND�� �����̶� �� �� �´°�

SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id IN (50,60,80)
OR salary > 9000; --�� �����߿� �ϳ��� �����ؼ� �����°�

--������ �켱���� (AND > OR)
SELECT employee_id, last_name, hire_date, salary, department_id, job_id
FROM employees
WHERE department_id = 50
OR department_id = 60
AND salary > 8000; --60,8000�̻� �̰ų� 50�λ��
SELECT employee_id, last_name, hire_date, salary, department_id, job_id
FROM employees
WHERE (department_id = 50
OR department_id = 60)
AND salary > 8000; --������ ��ȣ���� �켱������ �����
--����(�ݴ�)�� NOT���̸� ��
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name NOT LIKE 'K%'; --K�� �����ϴ� �̸��� �ƴѻ��
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id NOT IN(50,60,80); --50 60 80�� �ƴѻ��

--����� �����ϱ�(ORDER BY�� ���)
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id IS NOT NULL
ORDER BY salary DESC; --DESC:�������� ASC:��������(����Ʈ�� ���� �Ƚ��൵��)
--last_name : ���ĺ� Z���� ����
--hire_date : ��¥�� ��������
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id IS NOT NULL
ORDER BY department_id ASC, salary DESC; --�μ��� ���� ����� �ȿ��� salary ������ ����
-- ���� ASC DESC �����ָ� �׿� �°� ���ĵ�

SELECT employee_id, last_name, hire_date, salary*12 AS ����, department_id
FROM employees
WHERE department_id IS NOT NULL
ORDER BY department_id, salary*12; --column�� �ƴ϶� ǥ���ĵ� order by�ڿ� �� �� �ִ�

SELECT employee_id, last_name, hire_date, salary*12 AS ����, department_id
FROM employees
WHERE department_id IS NOT NULL
ORDER BY department_id, ���� DESC; --order by�ڿ� ��Ī�� �� �� ����

SELECT employee_id, last_name, hire_date, salary*12 AS ����, department_id
FROM employees
WHERE department_id IS NOT NULL
ORDER BY 5,4 DESC; --order by �ڿ� select���� �� ���� (5,4)�� �� �� ����
--order by���� �׻� �� ������ �� ���ٿ� �־���� �������� �����ϴ� ����

SELECT employee_id, last_name, hire_date, salary*12 AS ����, department_id
FROM employees
WHERE salary*12 > 120000 --where���� ǥ���� ���������� ��Ī�� �ȵ�
ORDER BY 5,4 DESC;
