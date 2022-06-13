GRANT select on hr.employees TO demo; --��ü�� �����̸��� �׳� �����ָ� ��

GRANT select on hr.locations TO r1; --������ ���̺� ����

--vu�����
CREATE VIEW emp_list_vu
AS
SELECT employee_id �����ȣ, first_name || ' ' || last_name ����̸�, email, 
        phone_number ��ȭ��ȣ, department_id �μ���ȣ
FROM employees
WHERE department_id<>90;

--���̺� ���� ���� ȸ��
REVOKE select on hr.employees FROM demo;

--vu�� ���� ���� �ֱ�
GRANT select on hr.emp_list_vu TO demo;

--vu�ٽ� �����
CREATE OR REPLACE VIEW emp_list_vu
AS
SELECT employee_id �����ȣ, first_name || ' ' || last_name ����̸�, email, 
        phone_number ��ȭ��ȣ, department_id �μ���ȣ, job_id ����
FROM employees
WHERE department_id<>90;

--������ ���� ȸ���ϱ�
REVOKE select on hr.emp_list_vu FROM demo;

--departments�� locations�� �����Ͽ� �μ���ȣ, �μ��̸�, �����̸��� ��µǴ� SELECT���� �ۼ�
SELECT department_id �μ���ȣ, department_name �μ��̸�, city �����̸�
FROM departments JOIN locations
USING(location_id);

--departments�� locations�� �����Ͽ� �μ���ȣ, �μ��̸�, �����̸��� ��µǴ� SELECT���� �����
--dept_loc_join_vu��� �̸��� ��� ����
CREATE OR REPlaCE VIEW dept_loc_join_vu
AS SELECT department_id �μ���ȣ, department_name �μ��̸�, city �����̸�
FROM departments JOIN locations
USING(location_id);

--dept_loc_join_vu �信 PUBLIC ���� �ο�
GRANT select on hr.dept_loc_join_vu TO PUBLIC;

--���� ���� ����
SELECT *
FROm session_privs;

CREATE PUBLIC SYNONYM d 
FOR dept_loc_join_vu;


