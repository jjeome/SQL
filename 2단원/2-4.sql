--SQL Developer �߰� ���� �� �λ������ ���� 
select * from emp_temp2; --�ִ� ������
insert into emp_temp2
select employee_id, last_name, salary
from employees
where department_id=60;
commit;
--global : ���̺��� �����ϴµ�, �����͸� �޶���
--���� ���ȿ��� ���̺� ���ôٹ���. �̸��� ������ �ȿ� ���� ���� �� ����
select * from emp_temp2;

drop table emp_temp1;
drop table emp_temp2;