SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees;
--WHERE절의 기본 사용법
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id > 50;
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id = 50;
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id >= 50;
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id <> 50; -- 같지 않다

--문자데이터의 비교
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name = 'king';
--WHERE절의 만족하는 데이터가 없을때
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name = 'king';
--문자는 ' ' 사용, 대소문자 및 공백 일치 시켜야함
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name <> 'King';
--문자도 크기비교가 가능함(한글>영어)
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name >= 'King';
--날짜 데이터의 비교(날짜는 날짜데이터 타입이라고 따로 있음)
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE hire_date = '97/09/17'; 
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE hire_date = '1997/09/17'; 
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE hire_date = '97-09-17'; --테이블에 적혀진 순서로 적어줘야함
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE hire_date <>'1997/09/17';
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE hire_date > '1997/09/17'; --날짜는 과거로 가면 작아지고 미래로 갈수록 값이 커짐

--SQL비교연산자(IN/LIKE/BETWEEN/IS NULL)
--IN
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id IN(50,60);  --괄호 안에 50 또는 60, 여러값 담을 수 있음
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name IN ('De Haan','Abel');

--LIKE
--와일드카드 : 대신하는 글자
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name LIKE 'K%'; --like는 %와 같이쓰임 -> (대문자)K로 이름이 시작하는 사람 찾을 때, %자리는 0개이상
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name LIKE '%a%'; --위치상관없이 소문자 a가 들어가는 사람 
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name LIKE '%s';  -- S로 끝나는 사람
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name LIKE '_a%'; --두번째 글자가 a인 사람 
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name LIKE '____'; --언더바만 4개면 이름이 4글자인 사람
SELECT employee_id, last_name, hire_date, salary, department_id, job_id
FROM employees;
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE job_id LIKE 'IT\_%' ESCAPE '\'; --예외처리할 문자 바로 앞에 기호를 써서 와일드 카드(_)가 아니라는 것을 알려줌 딱 한글자

--BETWEEN
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE salary BETWEEN 9000 AND 6000; -- (6000이상 9000이하)
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name BETWEEN 'Abel' AND 'Fay'; --알파벳 순서대로 적어줘야함
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE hire_date BETWEEN '99/01/01' AND '99/12/31'; --99년도에 입사한 사람

--IS NULL : null을 검색하는 유일한 연산자
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id is null; -- =null로 검색하면 안되고 is null로 검색하기

--논리연산자(AND/OR/NOT)
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id IN (50,60,80)
AND salary > 9000; -- IN조건이랑 AND뒤 조건이랑 둘 다 맞는것

SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id IN (50,60,80)
OR salary > 9000; --두 조건중에 하나만 만족해서 나오는것

--연산자 우선순위 (AND > OR)
SELECT employee_id, last_name, hire_date, salary, department_id, job_id
FROM employees
WHERE department_id = 50
OR department_id = 60
AND salary > 8000; --60,8000이상 이거나 50인사람
SELECT employee_id, last_name, hire_date, salary, department_id, job_id
FROM employees
WHERE (department_id = 50
OR department_id = 60)
AND salary > 8000; --연산자 괄호쓰면 우선순위로 연산됨
--부정(반대)은 NOT붙이면 됨
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE last_name NOT LIKE 'K%'; --K로 시작하는 이름이 아닌사람
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id NOT IN(50,60,80); --50 60 80이 아닌사람

--결과를 정렬하기(ORDER BY절 사용)
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id IS NOT NULL
ORDER BY salary DESC; --DESC:내림차순 ASC:오름차순(디폴트라 굳이 안써줘도됨)
--last_name : 알파벳 Z부터 시작
--hire_date : 날짜가 늦은순서
SELECT employee_id, last_name, hire_date, salary, department_id
FROM employees
WHERE department_id IS NOT NULL
ORDER BY department_id ASC, salary DESC; --부서가 같은 사람들 안에서 salary 정렬이 됐음
-- 각각 ASC DESC 적어주면 그에 맞게 정렬됨

SELECT employee_id, last_name, hire_date, salary*12 AS 연봉, department_id
FROM employees
WHERE department_id IS NOT NULL
ORDER BY department_id, salary*12; --column이 아니라 표현식도 order by뒤에 올 수 있다

SELECT employee_id, last_name, hire_date, salary*12 AS 연봉, department_id
FROM employees
WHERE department_id IS NOT NULL
ORDER BY department_id, 연봉 DESC; --order by뒤에 별칭도 올 수 있음

SELECT employee_id, last_name, hire_date, salary*12 AS 연봉, department_id
FROM employees
WHERE department_id IS NOT NULL
ORDER BY 5,4 DESC; --order by 뒤에 select절의 열 순서 (5,4)도 올 수 있음
--order by절은 항상 한 문장의 젤 끝줄에 있어야함 마지막에 정렬하는 느낌

SELECT employee_id, last_name, hire_date, salary*12 AS 연봉, department_id
FROM employees
WHERE salary*12 > 120000 --where절에 표현식 가능하지만 별칭은 안됨
ORDER BY 5,4 DESC;
