--������̺��� �Ի���(hire_date)�� �̿��� ����� �Ի� �� ù �޿��ϰ� ������������ ���Ͻÿ�.
--ù �޿����� �Ի��� ������ 5�� �Դϴ�.(��Ʈ LAST_DAY)
--������������ �Ի� 3���� �� ó�� �����ϴ� �ݿ��� �Դϴ�.(��Ʈ ADD_MONTHS)

SELECT employee_id, last_name, hire_date,
          LAST_DAY(hire_date)+5 "ù �޿���",
          NEXT_DAY(ADD_MONTHS (hire_date,3),'�ݿ���') "������"
FROM employees;
