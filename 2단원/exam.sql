--ID ST_CLERK 포함하지 않는부서의 ID 나열
SELECT department_id FROM departments
MINUS
SELECT department_id FROM employees
WHERE job_id = 'ST_CLERK';

--SET연산자 사용해 해당 지역에 부서가 없는 지역 ID와 지역 이름을 표시하시오.
SELECT country_id, country_name FROM countries
MINUS 
SELECT l.country_id, c.country_name
FROM locations l JOIN countries c
ON(l.country_id = c.country_id);

--입사 이후 현재 업무와 같은 업무를 담당한 적이 있는 사원(업무가 변경되었다가 현재의 업무로 복귀된 사원)의 
--사원 ID와 업무 ID를 나열하시오.
SELECT employee_id, job_id 
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history;

--소속된 부서에 상관없이 EMPLOYEES 테이블에 있는 모든 사원의 이름과 부서 ID
--소속된 사원에 상관없이 DEPARTMENTS 테이블에 있는 모든 부서의 부서 ID와 부서 이름
SELECT last_name, department_id, TO_CHAR(null)
FROM employees
UNION
SELECT TO_CHAR(null), department_id, department_name
FROM departments;

CREATE TABLE my_employee
 (id NUMBER(4) CONSTRAINT my_employee_id_nn NOT NULL,
 last_name VARCHAR2(25),
 first_name VARCHAR2(25),
 userid VARCHAR2(8),
 salary NUMBER(9,2));




--다음 예제 데이터의 첫번째 데이터 행(row)을 MY_EMPLOYEE 테이블에 추가하시오. 
--이때 INSERT 절에 열을 나열하지 마시오.
DESCRIBE my_employee

INSERT INTO my_employee
VALUES (1, 'Patel', 'Ralph', 'rpatel', 895);

--위의 목록에 있는 예제 데이터의 두 번째 행을 MY_EMPLOYEE 테이블에 추가하시오. 
--이번에는 INSERT 절에 열을명시적으로 나열하시오. 
INSERT INTO my_employee (id, last_name, first_name, userid, salary)
VALUES (2, 'Dancs', 'Betty', 'bdancs', 860);

-- 테이블에 추가한 항목을 확인
SELECT * FROM my_employee;

--사원 3의 성을 Drexler로 변경
UPDATE my_employee
SET last_name = 'Drexler'
WHERE id = 3;

--급여가 900 미만인 모든 사원의 급여를 1000으로 변경하고 테이블의 변경 내용을 확인
UPDATE my_employee
SET salary = 1000
WHERE salary<900;
SELECT last_name, salary
FROM my_employee;

--MY_EMPLOYEE 테이블에서 Betty Dancs를 삭제하고 테이블의 변경 내용을 확인
DELETE FROM my_employee
WHERE last_name = 'Dancs';

SELECT * FROM my_employee;

COMMIT;

