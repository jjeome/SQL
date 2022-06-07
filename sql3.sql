SELECT ROUND(45.923,2), ROUND(45.923), ROUND(45.923,-1) --양수는 소수점 아래, 음수는 일의자리 이상
FROM   DUAL;
SELECT TRUNC(45.923,2), TRUNC(45.923), TRUNC(45.923,-1)
FROM   DUAL;
SELECT last_name, salary, MOD(salary, 5000) --나머지를 구하는 함수
FROM   employees
WHERE  job_id = 'SA_REP';

--날짜연산
SELECT sysdate --오늘날짜를 반환하는 system함수(데이터베이스의 날짜)
FROM dual;
SELECT sysdate, sysdate+10 --오늘 날짜 더하기 10 , 날짜더하기 날짜는 X
FROM dual;
SELECT employee_id, last_name, hire_date, sysdate-hire_date AS 근무일수 --시간이 다 계산이 됨
FROM employees;
SELECT employee_id, last_name, hire_date, 
              TRUNC(sysdate-hire_date, 0) AS 근무일수 --두번째 인수는 생략 가능
FROM employees;
SELECT last_name, ROUND((SYSDATE-hire_date)/7) AS WEEKS 
FROM   employees
WHERE  department_id = 90;
--날짜함수
SELECT employee_id, last_name, 
              TRUNC(MONTHS_BETWEEN(sysdate, hire_date))AS 근무기간
FROM employees;
SELECT employee_id, last_name, 
              TRUNC(MONTHS_BETWEEN(sysdate, hire_date))AS 근무기간
FROM employees;
SELECT ADD_MONTHS(sysdate, 3), LAST_DAY(sysdate) 
FROM dual;
SELECT NEXT_DAY(sysdate, '금요일'), NEXT_DAY(sysdate, '금'), 
               NEXT_DAY(sysdate, 6) --일요일이 1 토요일이7
FROM dual;      
SELECT NEXT_DAY(sysdate, 'FRIDAY' ) 
FROM dual;

SELECT sysdate, ROUND(sysdate, 'year'), ROUND(sysdate, 'month'), 
              ROUND(sysdate, 'dd'), ROUND(sysdate, 'day')
FROM dual;       

--TRUNC는 무조건 버림
SELECT sysdate, TRUNC(sysdate, 'year'), TRUNC(sysdate, 'month'), 
       TRUNC(sysdate, 'dd'), TRUNC(sysdate, 'day')
FROM dual;