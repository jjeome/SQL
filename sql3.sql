SELECT ROUND(45.923,2), ROUND(45.923), ROUND(45.923,-1) --����� �Ҽ��� �Ʒ�, ������ �����ڸ� �̻�
FROM   DUAL;
SELECT TRUNC(45.923,2), TRUNC(45.923), TRUNC(45.923,-1)
FROM   DUAL;
SELECT last_name, salary, MOD(salary, 5000) --�������� ���ϴ� �Լ�
FROM   employees
WHERE  job_id = 'SA_REP';

--��¥����
SELECT sysdate --���ó�¥�� ��ȯ�ϴ� system�Լ�(�����ͺ��̽��� ��¥)
FROM dual;
SELECT sysdate, sysdate+10 --���� ��¥ ���ϱ� 10 , ��¥���ϱ� ��¥�� X
FROM dual;
SELECT employee_id, last_name, hire_date, sysdate-hire_date AS �ٹ��ϼ� --�ð��� �� ����� ��
FROM employees;
SELECT employee_id, last_name, hire_date, 
              TRUNC(sysdate-hire_date, 0) AS �ٹ��ϼ� --�ι�° �μ��� ���� ����
FROM employees;
SELECT last_name, ROUND((SYSDATE-hire_date)/7) AS WEEKS 
FROM   employees
WHERE  department_id = 90;
--��¥�Լ�
SELECT employee_id, last_name, 
              TRUNC(MONTHS_BETWEEN(sysdate, hire_date))AS �ٹ��Ⱓ
FROM employees;
SELECT employee_id, last_name, 
              TRUNC(MONTHS_BETWEEN(sysdate, hire_date))AS �ٹ��Ⱓ
FROM employees;
SELECT ADD_MONTHS(sysdate, 3), LAST_DAY(sysdate) 
FROM dual;
SELECT NEXT_DAY(sysdate, '�ݿ���'), NEXT_DAY(sysdate, '��'), 
               NEXT_DAY(sysdate, 6) --�Ͽ����� 1 �������7
FROM dual;      
SELECT NEXT_DAY(sysdate, 'FRIDAY' ) 
FROM dual;

SELECT sysdate, ROUND(sysdate, 'year'), ROUND(sysdate, 'month'), 
              ROUND(sysdate, 'dd'), ROUND(sysdate, 'day')
FROM dual;       

--TRUNC�� ������ ����
SELECT sysdate, TRUNC(sysdate, 'year'), TRUNC(sysdate, 'month'), 
       TRUNC(sysdate, 'dd'), TRUNC(sysdate, 'day')
FROM dual;