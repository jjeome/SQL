SELECT *
FROM job_history;
--1.UNION
--중복이 제거됨
SELECT employee_id FROM employees
UNION
SELECT employee_id FROM job_history;

--중복이 덜 제거됨
--첫 번째 column(employee_id)에 의해 정렬됨
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, department_id FROM job_history;
--employee_id로 정렬 굳이 안해줘도 됨
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, department_id FROM job_history
ORDER BY 2;

--오류
--column수 다르면 실행안됨
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id FROM job_history;
--강제로 맞춰주는 방법
--job_id와 동일한 데이터타입
SELECT employee_id, job_id FROM job_history
UNION
SELECT employee_id, TO_CHAR(null) FROM employees;

--오류
--department_id:숫자, job_id=문자(데이터타입이 같아야 함)
SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, job_id FROM job_history;

--첫번째 SELECT절의 column 사용
SELECT employee_id 사원번호, department_id FROM employees
UNION
SELECT employee_id, department_id 부서번호 FROM job_history;

--2.UNION ALL
--중복 제거 X
SELECT employee_id 사원번호, department_id 부서번호 FROM employees
UNION ALL
SELECT employee_id, department_id FROM job_history;

--3.INTERSECT(교집합)
--예전에 일했던 부서로 다시 간 사람들
SELECT employee_id, department_id FROM employees
INTERSECT
SELECT employee_id, department_id FROM job_history;

--4.MINUS 
--입사하고 나서 번호나 부서가 변경되지 않았던 사람들
--job_history에 저장되지 않음
--서브쿼리에 넣어서 사용할 수 있다
SELECT employee_id FROM employees
MINUS
SELECT employee_id FROM job_history;
--응용
SELECT employee_id, last_name, job_id
FROM employees
WHERE employee_id IN
                            (SELECT employee_id FROM employees
                            MINUS
                            SELECT employee_id FROM job_history);
--퇴사한 직원
--history에는 있고 현재 employee에는 없음
SELECT employee_id FROM job_history
MINUS
SELECT employee_id FROM employees;

--COLUMN수와 DATATYPE 매칭시키기 응용
SELECT department_id, job_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id, job_id;
SELECT department_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id;
SELECT COUNT(*), SUM(salary)
FROM employees;
--COLUMN수와 DATATYPE 매칭시키기 응용
--다차원 보고서 만들때 응용 
SELECT department_id, job_id, COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id, job_id
UNION
SELECT department_id, TO_CHAR(null), COUNT(*), SUM(salary)
FROM employees
GROUP BY department_id
UNION
SELECT TO_NUMBER(null), TO_CHAR(null), COUNT(*), SUM(salary)
FROM employees
ORDER BY 1,2;