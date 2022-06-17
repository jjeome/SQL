--Flashback Query Test : �ð��� �� ���������
SELECT salary FROM employees
WHERE employee_id = 178; --���� �� undo���Ϸ� �Ѿ
UPDATE employees
SET salary = 12000
WHERE employee_id = 178;
COMMIT;
SELECT salary FROM employees
WHERE employee_id = 178;
SELECT salary FROM employees
AS OF  TIMESTAMP sysdate-5/(24*60) --�ð����� : 5��
WHERE employee_id = 178; --178���� 5���� ���� ���ڴٴ� ��

UPDATE employees --���������� ������Ʈ �ϱ�
SET salary = (SELECT salary FROM employees
                  AS OF  TIMESTAMP sysdate-5/(24*60)
                  WHERE employee_id = 178)
WHERE employee_id = 178;

SELECT salary FROM employees
WHERE employee_id = 178;
COMMIT;

--Flashback Versions Query Test
UPDATE employees
SET salary = 10000
WHERE employee_id = 178;
COMMIT;
SELECT salary FROM employees
WHERE employee_id = 178;
SELECT versions_starttime, versions_endtime, salary, versions_xid
FROM employees
versions BETWEEN timestamp minvalue AND maxvalue --�ð��� �� �����ź��� �����Ȱͱ��� ���� ��
WHERE employee_id = 178;

--Flashback Transaction Query
--Flashback Versions Query ����� �޿� 12000�� versions_xid �� ����
--���� 0A001B004C020000
SELECT undo_sql FROM flashback_transaction_query --undo sql�� ������ �� �� 
WHERE xid = '01001300C2010000'; ----���� ����� transaction �־��ֱ�
--��ȸ����� undo_sql ������ ���翡�� ���� �� ������ �� Ȯ��
--����
update "HR"."EMPLOYEES" set "SALARY" = '12000' where ROWID = 'AAAE5oAAEAAAADNABO';
SELECT salary FROM employees
WHERE employee_id = 178;
COMMIT;