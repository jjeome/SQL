--Unconditional Insert Test
SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200;

INSERT  ALL --��ȣ ���� ���������� ���� , ���� ���̺� �� ��
INTO sal_history VALUES(EMPID,HIREDATE,SAL) --�÷��� ������ 
INTO mgr_history VALUES(EMPID,MGR,SAL)
SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200; --�ѹ��а� �� �־���

SELECT * FROM sal_history;
SELECT * FROM mgr_history;
ROLLBACK;

--���� ALL INSERT :when���� ������ �־ �����ϸ� ALL �� ������� ��
INSERT ALL
WHEN SAL > 10000 THEN
INTO sal_history VALUES(EMPID,HIREDATE,SAL) --when�� �����ϸ�then into�� �����϶�� ��
WHEN MGR > 200   THEN 
INTO mgr_history VALUES(EMPID,MGR,SAL)  --when�� �� �� �����ϸ� �α��� �� �����϶�� ��
SELECT employee_id EMPID,hire_date HIREDATE,  
           salary SAL, manager_id MGR 
FROM   employees
WHERE  employee_id > 200;

SELECT * FROM sal_history;
SELECT * FROM mgr_history;
COMMIT;

--���� FIRST INSERT

--�׷쿬���Ѱ�
SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
FROM   employees
GROUP BY department_id;

INSERT FIRST   
WHEN SAL  > 25000  THEN    
INTO special_sal VALUES(DEPTID, SAL) --ù��° when���� �����ϴ� ���� ù��°���̺��� �������� 
WHEN HIREDATE like ('10%') THEN    --�ι�° ���Ǻ��� �������� insert all�� �Ȱ��� ��
INTO hiredate_history_10 VALUES(DEPTID,HIREDATE)  
WHEN HIREDATE like ('09%') THEN
INTO hiredate_history_09 VALUES(DEPTID, HIREDATE)
ELSE  INTO hiredate_history VALUES(DEPTID, HIREDATE)--�ƹ��͵� �������� ���ϴ� else����. �Ƚ��ָ� �׳� �����
SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
FROM   employees
GROUP BY department_id;

SELECT * FROM special_sal; --sal >25000�� ù��° ���̺��� ��(90)�������� ��Ÿ���� �ȵ�
SELECT * FROM hiredate_history_10;
SELECT * FROM hiredate_history_09;
SELECT * FROM hiredate_history;
COMMIT;

--�ǹ� INSERT 
DESC sales_source_data
--������ ������ �÷��� ������ ����(�ݺ��Ǵ� ���� ���� �ƴ϶� ������ �����ؾ���)
SELECT * FROM sales_source_data; 


--�ǹ������� ���ο� ���̺� ���� ->Ʋ�� ����� /�ǹ�:���μ��� �ٲٱ�
CREATE TABLE sales_data
(sales_no NUMBER(8), --�Ѱ� �Ѱ��� ������ �ֱ�
employee_id NUMBER(6),
WEEK_ID	NUMBER(2),
SALES	NUMBER(8,2));

SELECT * FROM sales_data;

--�ǹ� INSERT �����ϱ�
INSERT ALL
INTO sales_data VALUES (1, employee_id,week_id,sales_MON)  
INTO sales_data VALUES (1, employee_id,week_id,sales_TUE)
INTO sales_data VALUES (1, employee_id,week_id,sales_WED)
INTO sales_data VALUES (1, employee_id,week_id,sales_THUR)
INTO sales_data VALUES (1, employee_id,week_id, sales_FRI)
SELECT EMPLOYEE_ID, week_id, sales_MON, sales_TUE,
       sales_WED, sales_THUR,sales_FRI 
FROM sales_source_data;
SELECT * 
FROM sales_data;
--�⺻Ű�� �� ���� �÷��� ��� sales_no�������

--���������� �� sales ��ȣ(sales_no) ����
CREATE SEQUENCE sales_data_seq
START WITH 101
INCREMENT BY 1
NOCACHE
NOCYCLE;
UPDATE sales_data
SET sales_no = sales_data_seq.nextval; --�������̸�.������
commit;
SELECT * FROM sales_data; 
--����ȭ�� �Ϸ�� ���̺� Ȱ��
SELECT employee_id, SUM(sales) FROM sales_data
WHERE week_id=6
GROUP BY employee_id
ORDER by 1;
COMMIT;

--�ٽ��Ϸ���
@c:\db_test\sql_labs\cre_minstab.sql 
UPDATE employees
SET salary = 10500
WHERE employee_id = 206;
COMMIT;
SELECT * FROM tab;