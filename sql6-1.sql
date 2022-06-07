--NATURAL JOIN / JOIN : ����ȭ �� ����
SELECT * 
FROM departments;
SELECT * 
FROM locations;
SELECT department_id, department_name, location_id, city, street_address
FROM departments NATURAL JOIN locations; --���̺� �̸� ���̿� natural join / ��(column) �̸��� ���ƾ� join�� ��
SELECT employee_id, last_name, department_id, department_name
FROM employees NATURAL JOIN departments;

--USING ���� ����ϴ� JOIN : �� column�� �����ؼ� ��� �� �� ����
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id); --column���� ���� join�� �� ��.(column���� �Ȱ��ƾ� ��)
SELECT department_id, department_name, location_id, city
FROM departments JOIN locations
USING (location_id);

--ON���� ����ϴ� JOIN : 
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id); 
SELECT employee_id, last_name, employees.department_id, department_name -- column���� ������ ���̺��� ���� ���ξ�� ���ش�.
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);

--���̺� �̸� ��Ī ��� 
SELECT employees.employee_id, employees.last_name, 
               employees.department_id, departments.department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);
--�������� JOIN ����(JOIN���� ��� ����)
SELECT e.employee_id, e.last_name, 
       e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);

--WHERE �� �߰�
SELECT e.employee_id, e.last_name, e.salary,
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
WHERE e.salary > 9000;
SELECT e.employee_id, e.last_name, e.salary,
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
AND e.salary > 9000; --�߰�����

--INNER JOIN�� OUTER JOIN
--JOIN ����� : INNERJOIn
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d 
ON (e.department_id = d.department_id);
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id);
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);

--USING���� OUTER �����ϱ�
SELECT employee_id, last_name, department_id, department_name
FROM employees LEFT OUTER JOIN departments
USING (department_id);
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id);

--SELF JOIN : �����̺��� join. (������) ��, ���׺��ΰ�ó�� ���� + ���̺� ��Ī(�ʼ�)
SELECT employee_id, last_name, manager_id
FROM employees;

SELECT e.employee_id, e.last_name, e.manager_id, m.last_name
FROM employees e JOIN employees m --���� ���̺��� �ι� �о����� �ٸ� ���̺��� �о��� ���� . ��Ī �ٸ���. ���� ���̺��� �ι� FROM�� ����
ON (e.manager_id = m.employee_id);
SELECT e.employee_id, e.last_name, e.manager_id, m.last_name 
FROM employees e LEFT OUTER JOIN employees m
ON (e.manager_id = m.employee_id);

--NON-EQUI JOIN : ���� JOIN 
SELECT * 
FROM job_grades;
SELECT e.employee_id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON (e.salary BETWEEN j.lowest_sal AND j.highest_sal);

--3Way JOIN : join�ϴ� ���� �� select���� ���� �ʿ� X 
SELECT e.employee_id, e.last_name, d.department_id, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);
SELECT e.employee_id, e.last_name, d.department_id, l.city
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);

--Cartesian Products : ��ü ����� ��
SELECT employee_id, city
FROM employees NATURAL JOIN locations; -- Cartesian Products �Ϻη� ��Ŵ
SELECT employee_id, department_name
FROM employees CROSS JOIN departments; --��ü��츦 ������

--GROUP�Լ��� JOIN ����
SELECT   d.department_name, MIN(e.salary), 
                MAX(e.salary),TRUNC(AVG(e.salary))
FROM     employees e JOIN departments d
ON       (e.department_id = d.department_id)
GROUP BY d.department_name;