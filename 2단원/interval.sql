DROP TABLE orders_20 PURGE;
DROP TABLE prod_period PURGE;
DROP TABLE emp5 PURGE;
--DB SYSTEM �ð�����
SELECT sysdate, systimestamp FROM dual;
--systimestamp:�ú���+����

--CLIENT �����ð�����
SELECT current_date, current_timestamp, localtimestamp
FROM dual;
--current_date = sysdate�� �����
--current_timestamp:�ú���+ASIA/SEOUL(=+9)
--local_timestamp:�ú���

--������ ���� ���� �� �ð����� �ٽ� �ǽ�
ALTER SESSION SET time_zone='-10:00';
--Ÿ������ �Ͽ��̷� ����
SELECT sysdate, systimestamp FROM dual;
--DB�� �ѱ�
SELECT current_date, current_timestamp, localtimestamp
FROM dual;
--�Ͽ��̷� �����
ALTER SESSION SET time_zone='+09:00';
--�ٽ� �ѱ�

--TIMESTAMP ������Ÿ�� �ǽ�
CREATE TABLE orders_20
(ord_id number(8),
 ord_date date,
 payment_date timestamp,
 delivery_date timestamp with time zone,
 receipt_date timestamp with local time zone);
 --���� �ٸ� ��¥ ������Ÿ�� ���
INSERT INTO orders_20
VALUES(12345678,  sysdate, sysdate+1/24, sysdate+1, sysdate+3);
--1�ð� �� ����, 1�� �� ���, 3�� �� ����
--dateŸ���� to_charŸ������ ��ȯ�ؾ���
COMMIT;
SELECT * FROM orders_20;
ALTER SESSION SET time_zone='-10:00';
--�Ͽ��̿� �ִ� ����� �ѱ��� ������ Ȯ��
SELECT current_date, current_timestamp, localtimestamp
FROM dual;

ALTER SESSION SET time_zone='+09:00';
--�ٽ� �ѱ����� 
SELECT * FROM orders_20;
ALTER SESSION SET time_zone='+01:00';
SELECT current_date, current_timestamp, localtimestamp
FROM dual;
SELECT * FROM orders_20;
--���� ������ ������
ALTER SESSION SET time_zone='+09:00';

SELECT sysdate+10, sysdate-10
FROM dual;
--10�ð� ���� �ð�
SELECT TO_CHAR(sysdate+10/24, 'yyyy/mm/dd hh24:mi:ss')
FROM dual;
--���ú��� 5���� ���� ��¥
SELECT ADD_MONTHS(sysdate, 5) FROM dual;
--5������ ��¥
SELECT ADD_MONTHS(sysdate, 60) FROM dual;

--INTERVAL TYPE Test
CREATE TABLE prod_period
(p_id NUMBER(2), 
 exchange_period INTERVAL DAY TO SECOND, --��ȯ���� �Ⱓ
 warrant_period INTERVAL YEAR TO MONTH); --��ȯ�����Ⱓ
DESC prod_period;


INSERT INTO prod_period
VALUES(1, INTERVAL '15' DAY, INTERVAL '3' YEAR); --15�ϰ� ��ȯ����, 3�Ⱓ ��������
INSERT INTO prod_period
VALUES(2, INTERVAL '7 12:30:00' DAY TO SECOND, INTERVAL '10-6' YEAR TO MONTH); --7�� 12��30�оȿ� / �����Ⱓ 10��6����
COMMIT;
SELECT * FROM prod_period;

--�ֹ��������� ��ȯ�������� �� ���������� ��ȸ(�����ϱ���)
SELECT ord_id, receipt_date, receipt_date+exchange_period, receipt_date+warrant_period --�ֹ���ȣ, ������¥ .....
FROM orders_20 , prod_period 
WHERE p_id = 1; --��ǰ�� 1���̶�� 

--������ ������?
SELECT ord_id, receipt_date,  receipt_date+15, ADD_MONTHS(receipt_date, 36) --(������¥�� 3��)
FROM order_20;

SELECT ord_id, receipt_date, receipt_date+exchange_period, receipt_date+warrant_period
FROM orders_20 , prod_period 
WHERE p_id = 2;

--�����Լ��� Ȱ��
--�ǽ��� ���� EMP5 ���̺� ���� 

SELECT employee_id, last_name, hire_date+TO_YMINTERVAL('5-0') AS hire_date, department_id --TO_YMINTERVAL: year to month�� ��ȯ���ִ� ��ȯ�Լ�
FROM employees;

CREATE TABLE emp5
AS
SELECT employee_id, last_name, hire_date+TO_YMINTERVAL('5-0') AS hire_date, department_id
FROM employees;
SELECT * FROM emp5;

--�Ի��Ϸκ��� ����/��/ ���� EXTRACT:��¥�κ��� from���� ������ ������(ex. EXTRACT(year from~) date���� year����
SELECT employee_id, last_name, EXTRACT(year from hire_date) --��¥�����͸� ���ڵ����ͷ� ��ȯ���� ���� 
FROM emp5;
SELECT employee_id, last_name, EXTRACT(month from hire_date) 
FROM emp5;
--day ����� ��¥ ��ȯ
SELECT employee_id, last_name, EXTRACT(day from hire_date) 
FROM emp5;
--��ȯ�Լ� ���� ��
SELECT employee_id, last_name, TO_CHAR(hire_date, 'YYYY') --����2002�� ����(���ڿ��� ��ȯ�ؼ� ���)
FROM emp5;
--��ȯ�Լ� ��뿡�� day�� ��ȯ �� ���� ��ȯ
SELECT employee_id, last_name, TO_CHAR(hire_date, 'day') 
FROM emp5;

--TZ_OFFSET �Լ��� ������ �������� 
--OFFSET : ���������� +2 ����
SELECT TZ_OFFSET('Asia/Seoul') FROM dual; --������ ���Ǿ� ��µ�
SELECT * FROM v$timezone_names
WHERE tzname LIKE '%Seoul%'; --�����ð� �̸� ���
SELECT TZ_OFFSET('Asia/Seoul') FROM dual; 
SELECT * FROM v$timezone_names
WHERE tzname LIKE '%Japan%'; 
SELECT TZ_OFFSET('Japan') FROM dual;

--EMP5�� hire_date ���� ������Ÿ���� timestamp Ÿ������ ����
ALTER TABLE emp5
MODIFY hire_date timestamp(0); --hire_date�� timestamp�� �ٲ۰�. (0)->ss(��)�ؿ� ���е� -���� 9���� �� �� ����
DESC emp5;
SELECT * FROM emp5;

--FROM_TZ�Լ��� ����Ͽ� ��¥������ ���� timezone ǥ�� 
SELECT employee_id, last_name, FROM_TZ(hire_date, '+09:00') AS hire_date
FROM emp5;

--TIMESTAMP �������������� ��ȯ�Լ�
--TO_TIMESTAMP �Լ��� ����Ͽ� ���ڸ� timestamp Ÿ�� �����ͷ� ��ȯ
SELECT * FROM emp5
WHERE hire_date > TO_TIMESTAMP('01.01.2000 09:00:00','dd.mm.yyyy hh24:mi:ss'); -- TO_TIMESTAMP: timestampŸ���� ��ȯ�Լ� =TO_DATE
--TO_YMINTERVAL �Լ�������� �ֹ��Ϸκ��� �����Ⱓ ���ϱ�
SELECT ord_id, ord_date, ord_date+TO_YMINTERVAL('3-0') 
FROM orders_20;

--TO_DSINTERVAL �Լ�������� �ֹ��Ϸκ��� �������ɽð� �� ��ȯ���ɱⰣ ���ϱ�
SELECT ord_id, TO_CHAR(ord_date,'yyyy/mm/dd hh24:mi:ss'), 
       TO_CHAR(ord_date+TO_DSINTERVAL('0 02:30:00'),'yyyy/mm/dd hh24:mi:ss') AS �������ɽð�, --�ֹ��� �ð����� 2�û�30�оȿ� ��������
       ord_date+TO_DSINTERVAL('10 00:00:00') AS ��ȯ���ɱⰣ --10�Ͼȿ� ��ȯ ����(������ �����ȿ����� ����)
FROM orders_20; 

--TO_DSINTERVAL  ����� ���
SELECT ord_id, ord_date,ADD_MONTHS(ord_date, 36)
FROM orders_20;
SELECT ord_id, TO_CHAR(ord_date,'yyyy/mm/dd hh24:mi:ss'), 
       TO_CHAR(ord_date+150/(24*60),'yyyy/mm/dd hh24:mi:ss') AS �������ɽð� --���� ������ �ٲ۰�
FROM orders_20;  

--Clear Test
DROP TABLE orders_20 PURGE;
DROP TABLE prod_period PURGE;
DROP TABLE emp5 PURGE;