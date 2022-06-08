--사원테이블에서 60번 부서 직원 가운데 급여가 5000이상 9000이하인 사원의 사원번호, 이름의 성, 급여, 부서번호 출력
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE salary BETWEEN 5000 AND 9000
AND department_id = 60;

--사원 테이블에서 (4)99년 1월 1일 이후에 입사한 사원의 사번, 성(last_name),  입사일, (1)첫 문자부터 3문자만 출력된 이메일계정, (2)이메일에 E가 포함되는지 여부, (3) 이메일 계정의 글자 수를  출력하기 위하여 다음 문장의 빈 칸에 알맞은 문자함수를 채우고 WHERE 절을 완성하시오.
SELECT employee_id, last_name, hire_date, SUBSTR(email,1,3), INSTR(email, 'E'), LENGTH(email)
FROM employees
WHERE hire_date >= '99/01/01';

--4. 사원테이블로부터 사원이름의 성(last_name), 입사일, (1)입사 6개월 후의 날짜, (2)입사 후 첫 금요일, (3)총 근무 개월, (4)첫 급여일을 차례로 표시하시오. 총 근무개월은 한 달 미만은 절삭하여 정수로 표시 되도록하고, 첫 급여일은 입사한 달의 말일이다.
SELECT last_name, hire_date, ADD_MONTHS(hire_date,6),
          NEXT_DAY(hire_date,'금'), TRUNC(MONTHS_BETWEEN(sysdate,hire_date)),
          LAST_DAY(hire_date)
FROM employees;

--5. 사원테이블에서 사원번호, 성(last_name), 급여(salary) 및 업무를 표시하고자 한다. 급여는 $기호와 천단위 구분기호를 표시할 수 있도록 하고 화면에 표시되는 이름이 “급여”가 되도록 작성한다. 결과는 급여를 기준으로 내림차순 정렬하도록 다음 문장을 완성하시오. 
SELECT employee_id, last_name, TO_CHAR(salary,'$999,999') AS 급여
FROM employees
ORDER BY  salary DESC;

--6. 커미션을 받는 사원 가운데 업무ID에 REP가 포함된 사원의 사번, 이름(first_name), 업무ID, 급여, 부서번호를 출력하기 위해 문장을 완성하시오.
SELECT employee_id, first_name, job_id, salary, department_id
FROM employees
WHERE commission_pct IS NOT NULL
AND job_id LIKE '%REP%';

--7. 인원수가 1명인 부서를 제외한 각 부서별 인원수, 총급여, 평균급여, 최소급여, 최대급여룰 부서번호와 함께 출력하시오.
SELECT department_id, COUNT(*), SUM(salary), AVG(salary), MIN(salary), MAX(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(*) <> 1;

--8. 사원테이블에서 사원번호, 사원이름, 부서번호 및 근무지역을 표시하시오. CASE 구문을 확용하여 근무지역은 20번 부서의 사원이면 'Canada', 80부서의 직원이면 'UK'를 표시하고 나머지 직원들은 'USA'로 표시하시오.
SELECT employee_id, last_name, department_id, CASE department_id WHEN 20 THEN 'Canada'
                                                                                             WHEN 80 THEN 'UK'
                                                                                             ELSE 'USA' END 근무지역
FROM employees;

--9. EMPLOYEES, DEPARTMENTS 테이블로부터 사번, 사원이름(LAST_NAME), 소속부서번호, 소속부서 이름을 표시하되 부서가 정해지지 않은 사원도 함께 표시하시오.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d --using절 사용해도 괜찮음.
ON(e.department_id = d.department_id);

--10. 서브쿼리를 활용하여 50번 부서에서 가장 높은 급여를 받고 있는 사원의 사원번호, 이름(last_name), 급여, 업무ID를 출력하시오.
SELECT employee_id, last_name, salary, job_id
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees
                        WHERE department_id = 50);
