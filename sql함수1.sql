--��¥�����Ϳ� TO_CHAR �Լ� ���
SELECT employee_id, last_name, hire_date
FROM employees;
SELECT employee_id, last_name, TO_CHAR(hire_date, 'dd-mm-yyyy') --����� ������ ��¥�� �ƴ�.
FROM employees;
SELECT employee_id, last_name, 
       TO_CHAR(hire_date, 'yyyy-mm-dd day') AS hire_date,
       TO_CHAR(hire_date, 'q') AS �б�, --������(���ʿ� �����ϱ�)
       TO_CHAR(hire_date, 'w')||'����' AS �ּ� 
FROM employees;
SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy-mm-dd hh24:mi:ss')
FROM employees;
--��¥ ���꿡 ����
SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss'), --���Ľð� ǥ��� ss�� ��.
       TO_CHAR(sysdate+3/24,'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss') --���� �ð����� 40�� ��
FROM dual;
DESC employees;

--�������α׷��� ��¥�� ��µ� DB���� �ð��� �׳� �������� ���������(���̺� ���̸� ���߱� ���ؼ�)
--�������α׷��� �ð��� ó���� �� �ֵ���� DB�� ���̰� �Ȱ��� 
SELECT employee_id, last_name, TO_CHAR(hire_date,'yyyy/mm/dd hh24:mi:ss') �Ի���
FROM employees;


