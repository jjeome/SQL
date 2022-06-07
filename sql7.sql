--Subquery의 기본 사용

SELECT  salary
FROM employees
WHERE last_name = 'Grant'; -- (단일행 서브쿼리 : 결과가 하나만 반환하는 것)

SELECT *
FROM employees
WHERE salary > ( SELECT  salary                    --서브쿼리를 가지고 있는 메인쿼리
                        FROM employees
                        WHERE last_name = 'Grant') --괄호안에 쿼리가 들어있는 서브쿼리
AND hire_date < (SELECT hire_date
                        FROM employees
                        WHERE last_name = 'Grant');
                        
SELECT salary 
FROM employees
WHERE last_name = 'Abel';
SELECT *
FROM employees
WHERE salary > 11000;
SELECT *
FROM employees
WHERE salary > (SELECT salary 
                             FROM employees
                            WHERE last_name = 'Abel');
                            
--단일행 서브쿼리(Single Row Subquery)
SELECT last_name, job_id, salary
FROM   employees
WHERE  job_id =  
                             (SELECT job_id                         --각각 개별적으로 나오는 데이터가 1개니까 단일행. 
                              FROM   employees
                              WHERE  last_name = 'Matos')
AND    salary >
                             (SELECT salary
                              FROM   employees
                              WHERE  last_name = 'Matos');
SELECT MAX(salary) 
FROM employees; 
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees);  -- 급여뿐만이 아니라 급여를 받는 사람을 알고 싶을 땐 서브쿼리
SELECT   department_id, COUNT(*)
FROM     employees
GROUP BY department_id 
HAVING  COUNT(*) > (SELECT COUNT(*) --HAVING절은 group by없이 사용 불가. group안에서 고르는 절.
                                         FROM   employees
                                         WHERE  department_id = 20); -- 20번보다 많은 사원수 찾는.         
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) 
                              FROM employees
                             WHERE department_id = 60);  --60번이라는 id를 가진 사원은 1명 즉 단일행 
                             
--다중 행 서브쿼리(Multiple Row Subquery)  : 서브쿼리로 들어갈 때 다중형으로 들어감 
SELECT MAX(salary) 
FROM employees
GROUP BY department_id;
SELECT last_name, job_id, salary
FROM   employees
WHERE salary = (SELECT MAX(salary) -- =연산자 써서 단일행 서브쿼리로 인식해 오류남
                              FROM employees
                              GROUP BY department_id);    
SELECT last_name, job_id, salary
FROM   employees
WHERE salary IN (SELECT MAX(salary) --다중행 서브쿼리 쓸 때 IN
                               FROM employees
                              GROUP BY department_id);  
SELECT salary 
FROM employees
WHERE department_id = 60;              
SELECT last_name, job_id, salary
FROM   employees
WHERE salary > (SELECT salary -- >단일행 연산자
                              FROM employees
                             WHERE department_id = 60)
AND department_id <> 60;      
SELECT last_name, job_id, salary
FROM   employees
WHERE salary >ANY (SELECT salary --ANY는 아무거나 보다 크거나라는 뜻
                                      FROM employees
                                      WHERE department_id = 60)
AND department_id <> 60; --추가조건 : 60번이 또 나오니까 빼준것.
SELECT last_name, job_id, salary
FROM   employees
WHERE salary >ALL (SELECT salary --모든것 보다 크거나 라는 뜻 
                                    FROM employees
                                    WHERE department_id = 60)
AND department_id <> 60;

--Subquery 사용 시 주의사항
--1. 서브쿼리에 들어가는 쿼리들 한 번 먼저 실행해보기
SELECT last_name, job_id, salary
FROM   employees
WHERE salary > (SELECT salary
                              FROM employees
                              WHERE last_name = 'Mark');

SELECT employee_id, last_name
FROM employees 
WHERE employee_id IN (SELECT manager_id -- manager번호와 자기 사원번호가 동일한 사람 찾는
                                           FROM employees);
                                           
SELECT DISTINCT manager_id 
FROM employees;
                                           
                                           
SELECT employee_id, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id
                                                    FROM employees);    
SELECT employee_id, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id
                                                    FROM employees
                                                     WHERE manager_id IS NOT NULL);  --포함된 NULL값이 지워지게 하려면    
                                                     
DESC employees; --NOT NULL이 없다면 언제든지 NULL이 나올 수 있다는 점.