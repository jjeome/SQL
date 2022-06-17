--Multiple Column Subquery 실습에 필요한 EMPL_DEMO 테이블 생성
@C:\db_test\sql_labs\cre_empl.sql 
SELECT COUNT(*) FROM empl_demo;

--쌍비교 서브쿼리 실행 : 컬럼2개를 둘 다 만족하는 비교
SELECT manager_id, department_id --서브쿼리에 컬럼이 2개 들어감
FROM empl_demo
WHERE first_name = 'John';
SELECT employee_id, manager_id, department_id
FROM empl_demo
WHERE (manager_id, department_id) IN --괄호로 묶어서 컬럼2개를 붙였음(쌍비교)
                                                     (SELECT manager_id, department_id
                                                      FROM empl_demo
                                                      WHERE first_name = 'John')
AND first_name <> 'John';

--비쌍비교 서브쿼리 실행 : 두개의 컬럼에서 각 컬럼의 값이 하나라도 있으면 출력하는 비쌍비교.
SELECT employee_id, manager_id, department_id
FROM empl_demo
WHERE manager_id IN 
                               (SELECT manager_id
                                FROM empl_demo
                                WHERE first_name = 'John')
AND department_id IN
                               (SELECT department_id
                                FROM empl_demo
                                WHERE first_name = 'John')
AND first_name <> 'John'; --john스스로가 메인쿼리에 나올 수 있어서 제외함


--쌍비교와비쌍비교 쿼리결과 다름 -> 비쌍비교가 더 많이 나옴
--위 쌍비교 했던것에 없던 결과도 나오기 때문. ex)100-50

--CASE 문에 사용된 서브쿼리
SELECT employee_id, last_name,
           (CASE WHEN department_id = (SELECT department_id FROM departments
                                                      WHERE location_id = 1800)
            THEN 'Canada' 
            ELSE 'USA' END)  AS location
FROM employees;

--ORDER BY 절에 사용된 서브쿼리
SELECT employee_id, last_name
FROM employees e
ORDER BY (SELECT department_name FROM departments d --사원이근무하는 부서 이름을 가지고 정렬
                WHERE e.department_id = d.department_id);
                
--Correlated(상호관련) Subquery 실습 : 값대신에 컬럼명이 오면 상호관련.
--메인쿼리와 서브쿼리가 독립적으로 실행하지 못함 (메인쿼리 하나가 서브쿼리에서 사용되기도 함)
--자신의 소속부서의 평균급여와 비교해서 자신의 급여가 부서의 평균급여보다 많은 직원 구하기
--원래 코드
SELECT employee_id, salary, department_id
FROM employees;

SELECT AVG(salary)
FROM employees
WHERE department_id = &deptid; --이렇게 평균구하는 것을 계속 해야함(쿼리보고 부서번호 넣고 평균보기)

--상호관련 쓰면? ->하지만 row갯수만큼 돌아가서 cost가 좋진않음
SELECT last_name, salary, department_id --department_id가 서브쿼리의 오른편에 채워짐
FROM employees o
WHERE salary > (SELECT AVG(salary) FROM employees i  --서브쿼리 따로 실행 안됨
                       WHERE i.department_id = o.department_id); --메인쿼리랑 서브쿼리의 번호가 같은 것
                       
--위 문장을 인라인뷰(In-line view)로 대체 -> from절에 서브쿼리로 테이블이나 뷰를 대체하는것 
--서브쿼리가 한번만 돌아가서 효율이 좋음 
SELECT a.last_name,  a.department_id, a.salary, b.avgsal
FROM employees a JOIN (SELECT department_id, AVG(salary) avgsal --그리고 만든것을 JOIN
                                    FROM employees
                                    GROUP BY department_id) b --서브쿼리의 결과를 b라는 이름의 뷰나 테이블처럼 만든것
ON (a.department_id = b.department_id)
WHERE a.salary > b.avgsal;

--EXISTS/NOT EXISTS 연산자 실습 -> 데이터 중복이 많을 때 사용하면 좋음 
SELECT employee_id, manager_id
FROM employees;

SELECT employee_id, last_name, job_id, department_id
FROM employees o
-- 서브쿼리에서 읽다가 중단됨 : 만족하는 행이나오면 검색을 멈추고 다음으로 넘어감 -> 다 하면 X를 반환
WHERE EXISTS ( SELECT 'X' FROM employees --구분지어주는 키워드 : X (있으면 X표시) -> 문자 아무거나 넣어두면 됨
                       WHERE manager_id = o.employee_id); --exists : ~있으면 -> 값이 있으면 넘어가버림(1개라도 나오면 끝남) 즉, 있냐없냐만.
                       
SELECT employee_id, last_name, job_id, department_id
FROM employees o
WHERE NOT EXISTS ( SELECT 'X' FROM employees -- 똑같이수행하고 나중에 X가 없는 걸 반환
                       WHERE manager_id = o.employee_id);
                       
--상호관련 UPDATE와 상호관련 DELETE
DROP TABLE emp6;
CREATE TABLE emp6
AS
SELECT employee_id, last_name, salary
FROM employees
WHERE department_id IN (50,60,80);
ALTER TABLE emp6
ADD job_id VARCHAR2(10); --추가된 컬럼은 null값으로 되어있음
SELECT * FROM emp6;
UPDATE emp6 
SET job_id = (SELECT job_id
              FROM employees 
              WHERE emp6.employee_id = employee_id); --job_id가 뭐냐에 따라 행 마다 따로 바꿔줘야함(job_id)
SELECT * FROM emp6;
COMMIT;
DELETE FROM emp6 
WHERE employee_id IN (SELECT employee_id FROM job_history --상호관련 : job_history에서 하나하나 봐야함
                     WHERE employee_id = emp6.employee_id);         
COMMIT;

--WITH 절 예제 -> 이전 인라인뷰를 사용하는 문장을  WITH 절로 변환
--with : 인라인뷰를 때로 빼주어 쿼리블록으로 지정해줌
--장점 : 밑의 쿼리블록이 위의 쿼리블록을 참조할 수 있음
WITH 
avg_sal AS (SELECT department_id, TRUNC(AVG(salary)) avgsal
                  FROM employees
                 GROUP BY department_id), --쿼리블록을 구분 : , -> 쿼리블록 총 2개
emp_sal AS (SELECT employee_id, last_name, salary, department_id
                 FROM employees)
SELECT employee_id, last_name, salary, avgsal
FROM avg_sal JOIN emp_sal
USING (department_id)
WHERE avg_sal.avgsal < emp_sal.salary;

--WITH 문을 사용하여 부서별 평균급여 및 관리 리전을 함께 표시
WITH 
avgsal AS (SELECT department_id, TRUNC(AVG(salary)) avgsal
                  FROM employees
                 GROUP BY department_id),
dept_loc AS (SELECT department_id, department_name, city
              FROM departments JOIN locations
              USING (location_id)),
region_list AS (SELECT city, country_name AS country, region_name AS region
                FROM locations JOIN countries
                USING (country_id)
                JOIN regions
                 USING (region_id))
SELECT department_id, avgsal, r.region
FROM avgsal JOIN (SELECT department_id, region --인라인뷰 안에 쿼리블록을 넣어줌
                   FROM dept_loc JOIN region_list
                   USING (city)) r
USING (department_id);  


--employee와 department를 join, department_id가 같은데, 이 데이터를 department_name을 기준으로 그룹화시켜줌
SELECT d.department_name, SUM(e.salary) AS dept_total
FROM employees e JOIN departments d --사용할 수 있게 선언되어짐
ON e.department_id = d.department_id
GROUP BY d.department_name;


WITH
dept_costs AS (
SELECT d.department_name, SUM(e.salary) AS dept_total
FROM employees e JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name),
avg_cost AS (
SELECT SUM(dept_total)/COUNT(*) AS dept_avg
FROM dept_costs) -- 쿼리블록의 from절이 쓰일 수 있게 (쿼리블록 이름을 사용할수 있게 with문에 이름 쿼리블록 이름 선언해줌)
SELECT *
FROM dept_costs
WHERE dept_total >
(SELECT dept_avg 
FROM avg_cost)
ORDER BY department_name;

--Clear Test
DROP TABLE empl_demo PURGE;
DROP TABLE emp6 PURGE;