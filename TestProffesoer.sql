--������̺��� 60�� �μ� ���� ��� �޿��� 5000�̻� 9000������ ����� �����ȣ, �̸��� ��, �޿�, �μ���ȣ ���
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary BETWEEN 5000 AND 9000
AND department_id = 60;

--��� ���̺��� (4)99�� 1�� 1�� ���Ŀ� �Ի��� ����� ���, ��(last_name),  �Ի���, (1)ù ���ں��� 3���ڸ� ��µ� �̸��ϰ���, (2)�̸��Ͽ� E�� ���ԵǴ��� ����, (3) �̸��� ������ ���� ����  ����ϱ� ���Ͽ� ���� ������ �� ĭ�� �˸��� �����Լ��� ä��� WHERE ���� �ϼ��Ͻÿ�.
SELECT employee_id, last_name, hire_date, SUBSTR(email,1,3), INSTR(email, 'E'), LENGTH(email)
FROM employees
WHERE hire_date >= '99/01/01';

--4. ������̺�κ��� ����̸��� ��(last_name), �Ի���, (1)�Ի� 6���� ���� ��¥, (2)�Ի� �� ù �ݿ���, (3)�� �ٹ� ����, (4)ù �޿����� ���ʷ� ǥ���Ͻÿ�. �� �ٹ������� �� �� �̸��� �����Ͽ� ������ ǥ�� �ǵ����ϰ�, ù �޿����� �Ի��� ���� �����̴�.
SELECT last_name, hire_date, ADD_MONTHS(hire_date,6),
          NEXT_DAY(hire_date,'��'), TRUNC(MONTHS_BETWEEN(sysdate,hire_date)),
          LAST_DAY(hire_date)
FROM employees;

--5. ������̺��� �����ȣ, ��(last_name), �޿�(salary) �� ������ ǥ���ϰ��� �Ѵ�. �޿��� $��ȣ�� õ���� ���б�ȣ�� ǥ���� �� �ֵ��� �ϰ� ȭ�鿡 ǥ�õǴ� �̸��� ���޿����� �ǵ��� �ۼ��Ѵ�. ����� �޿��� �������� �������� �����ϵ��� ���� ������ �ϼ��Ͻÿ�. 
SELECT employee_id, last_name, TO_CHAR(salary,'$999,999') AS �޿�
FROM employees
ORDER BY  salary DESC;

--6. Ŀ�̼��� �޴� ��� ��� ����ID�� REP�� ���Ե� ����� ���, �̸�(first_name), ����ID, �޿�, �μ���ȣ�� ����ϱ� ���� ������ �ϼ��Ͻÿ�.
SELECT employee_id, first_name, job_id, salary, department_id
FROM employees
WHERE commission_pct IS NOT NULL
AND job_id LIKE '%REP%';

--7. �ο����� 1���� �μ��� ������ �� �μ��� �ο���, �ѱ޿�, ��ձ޿�, �ּұ޿�, �ִ�޿��� �μ���ȣ�� �Բ� ����Ͻÿ�.
SELECT department_id, COUNT(*), SUM(salary), AVG(salary), MIN(salary), MAX(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(*) <> 1;

--8. ������̺��� �����ȣ, ����̸�, �μ���ȣ �� �ٹ������� ǥ���Ͻÿ�. CASE ������ Ȯ���Ͽ� �ٹ������� 20�� �μ��� ����̸� 'Canada', 80�μ��� �����̸� 'UK'�� ǥ���ϰ� ������ �������� 'USA'�� ǥ���Ͻÿ�.
SELECT employee_id, last_name, department_id, CASE department_id WHEN 20 THEN 'Canada'
                                                                                             WHEN 80 THEN 'UK'
                                                                                             ELSE 'USA' END �ٹ�����
FROM employees;

--9. EMPLOYEES, DEPARTMENTS ���̺�κ��� ���, ����̸�(LAST_NAME), �ҼӺμ���ȣ, �ҼӺμ� �̸��� ǥ���ϵ� �μ��� �������� ���� ����� �Բ� ǥ���Ͻÿ�.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d --using�� ����ص� ������.
ON(e.department_id = d.department_id);

--10. ���������� Ȱ���Ͽ� 50�� �μ����� ���� ���� �޿��� �ް� �ִ� ����� �����ȣ, �̸�(last_name), �޿�, ����ID�� ����Ͻÿ�.
SELECT employee_id, last_name, salary, job_id
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees
                        WHERE department_id = 50);
