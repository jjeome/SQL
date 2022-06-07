--GROUP 함수의 기본 사용
--그룹함수는 그룹함수를 가질 수 있는 애들끼리 사용 가능
SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM   employees;
SELECT AVG(salary), MAX(salary), MIN(salary), SUM(salary)
FROM   employees
WHERE  department_id = 60;
SELECT MIN(last_name), MAX(last_name)
FROM employees;
SELECT MIN(hire_date), MAX(hire_date)
FROM employees;

--count : 행의 수를 셈 , DISTINCT는 중복되는거 제외하고 셈
SELECT COUNT(*), COUNT(department_id), COUNT(DISTINCT department_id) 
FROM employees;
SELECT AVG(commission_pct), AVG(NVL(commission_pct, 0)) --??
FROM employees;

--GROUP BY 절의 사용 : 서브그룹을 만들어줌 
SELECT department_id, SUM(salary), COUNT(*)
FROM employees;
SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id; --grou by절에 있는 column만 select절에 올 수 있음.
SELECT department_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id
ORDER BY 1; --order by 줄은 항상 마지막줄에 써야함. 1은 부서번호로 정렬./ null은 제일 큰 값X 그냥 null이라 젤 밑으로감
SELECT department_id, job_id,  SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id, job_id
ORDER BY 1,2;
SELECT department_id, job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE department_id >= 50 --where절 : from절 뒤에 group by절 앞에 위치, 행을 먼저 골라냄 
GROUP BY department_id, job_id
ORDER BY 1,2;

--HAVING 절의 사용
SELECT department_id,job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE COUNT(*) <> 1 --인원수가 1이 아닌. group선택은 where이 못함. where절은 조건을 가질 수 없다.
GROUP BY department_id, job_id
ORDER BY 1,2;

SELECT department_id,job_id,  SUM(salary), COUNT(*)
FROM employees
WHERE department_id <> 90
GROUP BY department_id, job_id
HAVING COUNT(*) <> 1 --위의 where절을 Having절로 바꿔적어야함 group by가 있어야지 having이 나올 수 있음.
--group by 와 having은 짝꿍
ORDER BY 1,2;


--GROUP 함수의 중첩 
SELECT MAX(SUM(salary))
FROM employees
GROUP BY department_id;

SELECT department_id, MAX(SUM(salary))
FROM employees
GROUP BY department_id;