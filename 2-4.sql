--SQL Developer 추가 실행 후 인사관리로 접속 
select * from emp_temp2; --최대 데이터
insert into emp_temp2
select employee_id, last_name, salary
from employees
where department_id=60;
commit;
--global : 테이블은 존재하는데, 데이터만 달라짐
--쓰는 동안에는 테이블 동시다발적. 이름은 같지만 안에 값은 각자 다 따로
select * from emp_temp2;

drop table emp_temp1;
drop table emp_temp2;