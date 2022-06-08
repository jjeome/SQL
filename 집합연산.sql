--UNION
SELECT *
FROM job_history;

SELECT employee_id, department_id FROM employees
UNION
SELECT employee_id, job_id FROM job_history;

SELECT employee_id 사원번호 , department_id FROM employees
UNION
SELECT employee_id, department_id 부서번호 FROM job_history
ORDER BY 1;

SELECT employee_id 사원번호 , department_id FROM employees
UNION ALL
SELECT employee_id, department_id 부서번호 FROM job_history;

--예전에 일했던 부서로 다시 간 사람들
SELECT employee_id, department_id FROM employees
INTERSECT
SELECT employee_id, department_id FROM job_history;

--입사후 업무 부서 변동이 없었던 사람들
SELECT employee_id, last_name, job_id
FROM employees
WHERE employee_id IN (SELECT employee_id FROM employees
                                  MINUS
                                  SELECT employee_id FROM job_history);

--퇴사한 직원                                
SELECT employee_id FROM job_history
MINUS
SELECT employee_id FROM employees;

--coulmn명 갯수 맞추기
--데이터 타입만 맞춰주는 TO_CHAR
SELECT employee_id, job_id FROM job_history
UNION
SELECT employee_id, TO_CHAR(null) FROM employees;

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