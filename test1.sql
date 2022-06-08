DESCRIBE employees;

SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary BETWEEN 5000 AND 9000 
AND department_id = 60;


SELECT employee_id, last_name, hire_date, SUBSTR(email,1,4), INSTR(email,'e'), LENGTH(email)
FROM employees
WHERE hire_date > '99/1/1';


SELECT last_name, hire_date, TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6))), 
            hire_date(ADD_MONTHS(LAST_DAY(hire_date), '금요일'),
            MONTHS_BETWEEN(SYSDATE, hire_date),
FROM employees;

SELECT employee_id, last_name, TO_CHAR(salary,'$999,999') 급여
FROM employees 
ORDER BY salary DESC;

SELECT employee_id, first_name, job_id, salary, department_id
FROM employees
WHERE job_id LIKE '%REP%'
AND commission_pct IS NOT NULL;

SELECT COUNT(employee), SUM(salary), AVG(salary),MIN(salary),MAX(salary)
GROUP BY department_id
WHERE COUNT(employee) <> 1;


SELECT employee_id, last_name, CASE department_id WHEN 20 THEN 'Canada'
                                                                        WHEN 80 THEN 'UK'
                                                                        ELSE 'USA' END
FROM employees;
                                                                                    
SELECT employee_id, last_name, salary, job_id
FROM employees
WHERE department_id = 50
AND salary < (SELECT MAX(salary) FROM employees);


SELECT employee_id, last_name, salary, job_id
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees WHERE department_id = 50);






           



