SELECT last_name, email, job_id
FROM employees;

--���ڸ� ���� �����Լ�
SELECT UPPER(last_name), LOWER(email), INITCAP(job_id) 
FROM employees;

--dual���̺� : �������̺� �� �ƹ��ǹ� ���� ������. ����� �޾ƺ��� ��
SELECT UPPER('oracle database'), LOWER('ORACLE DATABASE'), INITCAP('ORACLE DATABASE') 
FROM dual;

SELECT 1234+1234
FROM dual;

--CONCAT: �μ��� �� 2������ ��.
SELECT employee_id, CONCAT(first_name, lsat_name) AS fullname, salary
FROM employees;
--CONCAT�� ����� �� �� ��(�߰��� ����־) �ϱ�. �Լ��� ��ø�ؼ� ���.
SELECT employee_id, CONCAT(CONCAT(first_name,' '), lsat_name) AS fullname, salary
FROM employees;
--���ڿ� ���̱⵵ ����
SELECT employee_id, last_name, CONCAT(email,'@yd.com') AS email_addr
FROM employees;

--SUBSTR: �μ��� �� 3��
SELECT SUBSTR('oracle database',1,6) --ù��° ���ں��� 6���ڸ� ���
FROM dual;
SELECT SUBSTR('oracle database',8,4) --8��° ���ں��� 4���ڸ� ���
FROM dual;
SELECT SUBSTR('oracle database',8,4)
FROM dual;
SELECT SUBSTR('oracle database',8,4), SUBSTR('oracle database',1,6), SUBSTR('oracle database',8),
            SUBSTR('oracle database',-4,4)
FROM dual;


SELECT employee_id, last_name, SUBSTR(last_name,1,3)
FROM employees
WHERE SUBSTR(last_name, -1,1)='s'; --s�� ������ ����� ���. �˻��� �� �� ���� ���� 

SELECT employee_id, last_name, SUBSTR(last_name,1,3)
FROM employees
WHERE last_name LIKE'%s'; --���� ������ ����

--�����Լ� -> ����� ���������� �μ��� ����.
SELECT employee_id, last_name, LENGTH(last_name) --���ڼ�
FROM employees;

--���� �����ؼ� ���� �� ��ȸ
SELECT LENGTH('oracle database'), LENGTH('����Ŭ �����ͺ��̽�')
FROM dual;

--byte�� 
SELECT LENGTHB('oracle database'), LENGTHB('����Ŭ �����ͺ��̽�')
FROM dual;

--INSTR : ������� ���ڰ��Ǵ� �Լ�/ ' ' �ȿ� ���ڰ� �տ��ִ� �ҽ����� ���°�� �ִ��� ��Ÿ����
SELECT employee_id, last_name, INSTR(last_name, 'a')
FROM employees;

SELECT *
FROM employees
WHERE INSTR(last_name, 'a') = 0; --�̸��� �ҹ��� a�� ���»��

SELECT *
FROM employees
WHERE last_name NOT LIKE '%a%'; --���� ���� ���.( �̸��� �ҹ���a�� ���� ���.)

--LPAD | RPAD : ����(left, right) 
--PAD�� ä��ٴ� ��, L : �������� ������ ä��� | R : �������� �������� ä���
SELECT employee_id, RPAD(last_name, 9, '*'), LPAD(salary, 15, '*') --���ڴ� ����Ʈ, ����Ʈ�� ��ä������(���°�) ' '�ȿ� �ִ� �ɷ� ä��
FROM employees;

--TRIM : ���ξ ���̾ �߶� �� ���� ex.��ȭ��ȣ
SELECT TRIM('o' FROM 'oracle database')
FROM dual;

SELECT TRIM('w' FROM 'window'),
        TRIM(LEADING 'w' FROM 'window'), --�տ� �ִ°͸� �߶󳻱�
        TRIM(TRAILING 'w' FROM 'window') --�ڵ� �ִ°͸� �߶󳻱�
FROM dual;

SELECT employee_id, last_name,
          CONCAT('+82',TRIM(LEADING '0' FROM phone_number))
FROM employees;


SELECT TRIM ('0' FROM '000000123001122')
FROM dual;

SELECT  RTRIM(LTRIM ('01010101101101' , '01') ,'01')
FROM dual;

--replace : ���ڸ� ��ü��
SELECT REPLACE('Jack and Jue', 'J','Bl') FROM dual; --1���ڸ� 2���ڷ� �ٲٴ� �͵� ����
SELECT employee_id, last_name, REPLACE (last_name, SUBSTR(last_name, 2,2) , '**') --�̸����� 2��° ���ں��� 2���� *�̰ɷ� ��ü��
FROM employees;

SELECT *
FROM employees
WHERE LOWER(last_name) = 'king'; --king�� King���� �ٲٰ� ����