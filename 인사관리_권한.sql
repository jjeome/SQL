GRANT select on hr.employees TO demo; --객체의 권한이름은 그냥 지어주면 됨

GRANT select on hr.locations TO r1; --권한을 테이블에 줬음

--vu만들기
CREATE VIEW emp_list_vu
AS
SELECT employee_id 사원번호, first_name || ' ' || last_name 사원이름, email, 
        phone_number 전화번호, department_id 부서번호
FROM employees
WHERE department_id<>90;

--테이블에 대한 권한 회수
REVOKE select on hr.employees FROM demo;

--vu에 대한 권한 주기
GRANT select on hr.emp_list_vu TO demo;

--vu다시 만들기
CREATE OR REPLACE VIEW emp_list_vu
AS
SELECT employee_id 사원번호, first_name || ' ' || last_name 사원이름, email, 
        phone_number 전화번호, department_id 부서번호, job_id 직급
FROM employees
WHERE department_id<>90;

--데모의 권한 회수하기
REVOKE select on hr.emp_list_vu FROM demo;

--departments와 locations를 조인하여 부서번호, 부서이름, 도시이름이 출력되는 SELECT문을 작성
SELECT department_id 부서번호, department_name 부서이름, city 도시이름
FROM departments JOIN locations
USING(location_id);

--departments와 locations를 조인하여 부서번호, 부서이름, 도시이름이 출력되는 SELECT문의 결과를
--dept_loc_join_vu라는 이름의 뷰로 정의
CREATE OR REPlaCE VIEW dept_loc_join_vu
AS SELECT department_id 부서번호, department_name 부서이름, city 도시이름
FROM departments JOIN locations
USING(location_id);

--dept_loc_join_vu 뷰에 PUBLIC 권한 부여
GRANT select on hr.dept_loc_join_vu TO PUBLIC;

--권한 종류 보기
SELECT *
FROm session_privs;

CREATE PUBLIC SYNONYM d 
FOR dept_loc_join_vu;


