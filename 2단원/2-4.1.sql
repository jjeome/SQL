--Using a Temporary Table
select * from emp_temp1;
select * from emp_temp2;

--������ copy
insert into emp_temp1
select employee_id, last_name, salary
from employees
where department_id = 50;
insert into emp_temp2
select employee_id, last_name, salary
from employees
where department_id in (80,90);

select * from emp_temp1;
select * from emp_temp2;

commit;

select * from emp_temp1; --commit�ϸ� ������
select * from emp_temp2;

drop table emp_temp2;