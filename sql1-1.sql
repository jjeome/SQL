SELECT *
FROM employees;
SELECT *
FROM departments;
SELECT location_ID, department_NAME
FROM departments;
SELECT location_id, department_name FROM departments;
select location_id, department_name from departments;
--표현식(expression)
SELECT employee_id, last_name, salary, salary*12
FROM employees;
SELECT employee_id, last_name, salary, salary+100*12, (salary+100)*12
FROM employees;
SELECT employee_id, last_name, salary, salary*12 연봉
FROM employees;
--AS:별칭 생략 가능, 한글 영문 다 가능
--공백 특수문자 취급->'_'사용(공백 역할)
SELECT employee_id, last_name, salary, salary*12 annual_salary
FROM employees;
--별칭을 큰따옴표 안에 넣으면 원하는대로 표현 가능
SELECT employee_id, last_name, salary, salary*12 "Annual Salary"
FROM employees;
SELECT employee_id empno, last_name empname, salary, salary*12
FROM employees;
--일반 column들도 별칭으로 출력할 수 있음
SELECT employee_id, last_name, salary,
           salary*12 "Annual Salary"
FROM employees;
--들여쓰기하면 좋음
--연결연산자(||) DB에서만 사용
SELECT employee_id, first_name, last_name
FROM employees;
SELECT employee_id, first_name||last_name full_name
FROM employees;
SELECT employee_id, first_name||' '||last_name full_name
FROM employees;
--연결연산자 사이에 공백 넣는 법,  문자 추가하는 법
SELECT employee_id, first_name||' '||last_name, email || '@yd.com' AS email
FROM employees;
SELECT last_name ||' : '|| salary
FROM employees;
--''두개만 쓰면 오류 발생
--'추가 해주면 실행됨 or q'[]로 명확하게 표시
--q연산자 -> 가독성
SELECT last_name ||'''s salary : '|| salary
FROM employees;
SELECT last_name ||q'['s salary : ]'|| salary
FROM employees;

--DISTINCT
--중복도가 높은 column 경우 중복도를 제거해줌
SELECT department_id
FROM employees;
SELECT DISTINCT department_id
FROM employees;
--SELECT 바로 뒤에서 한번만 사용 가능
SELECT DISTINCT department_id, job_id
FROM employees;

--NULL값(아무것도 저장하지 않은 상태, 0 또는 공백과 다른 상태)
SELECT employee_id, last_name, manager_id, commission_pct, department_id
FROM employees;
--영업사원만 commission 값 다른 사람은 null 값
SELECT employee_id, last_name, salary, commission_pct,
            salary + salary*commission_pct AS 실급여
FROM employees;
--표현식에 null값이 들어가면 무조건 null로 나온다

--테이블구조(열구조)
DESCRIBE employees;
--추가명령어 DESCRIBE:coloumn에 대한 설명 나옴
--약어:DESC
--NOT NULL:필수로 입력해야함
DESC deparments;