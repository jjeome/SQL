--ġȯ����: ������ �ִٰ� �����ϸ� ���� �Է��ؼ� ������ ��. �����̸��տ� &���̸� �� ex.&�����̸�
SELECT employee_id, last_name, salary
FROM employees
WHERE department_id = &�μ���ȣ;

--���ڿ��� ������ �������� '&���ڿ�'�� �ؾ���
SELECT employee_id, last_name, salary
FROM employees
WHERE last_name = '&����̸�';

--SELECT���� column�����̸��� ���� �� ����(������ column��)
SELECT employee_id, last_name, salary, &column_name
FROM employees
ORDER BY &column_name; --�� ����ȿ� ġȯ���� ������ ��� ����(���� ��Ÿ��)

--&& ���� ���� ������ �� ���� ������ �����鼭 �������� ���� �������� �� ���� ������
SELECT employee_id, last_name, salary, &&column_name
FROM employees
ORDER BY &column_name;

--���� undefine �ϱ� ������ ������ �ְ� undefine�ϸ� ���� ������
DEFINE column_name
UNDEFINE column_name
DEFINE column_name

