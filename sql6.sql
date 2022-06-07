--JOIN : ���� ���� ã�Ƽ� ������ (column�̸��� �޶� �� �� ����)
SELECT employee_id, last_name, salary, department_id, department_name
FROM employees JOIN departments --����ϰ� �μ��� ���ļ� ������, ���̺��� ������ ���� ������ �ٿ��� ������
USING(department_id); --���� �����͸� �� column�� ������ �־�� ��

--NATURAL JOIN : departments�� location����Ǵ� columnã�Ƽ� ������, column�� �� �ϳ��� join������ �� ��� ����.
--�ַ� ���ʿ� join������ column�� �� �� �� �� ��밡��. column�� ���� �� ����(���� column�� �ϳ��ۿ� ���� �� �� ����)
SELECT * 
FROM departments;
SELECT * 
FROM locations;
SELECT department_id, department_name, location_id, city
FROM departments NATURAL JOIN locations;
SELECT employee_id, last_name, department_id, department_name
FROM employees NATURAL JOIN departments;


--USING ���� ����ϴ� JOIN : column�� ���� �� ���� �������� �� Ư�� column�� �����ؼ� ������
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id);
SELECT department_id, department_name, location_id, city
FROM departments JOIN locations
USING (location_id);

--ON���� ����ϴ� JOIN : ���� ���̺��� column���� �ٸ� �� ���
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments --���� ���� : select���� column���� ���� �ְ� ������ �򰥷��� �׷��� ���� ��
ON (employees.department_id = departments.department_id);
SELECT employee_id, last_name, employees.department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);