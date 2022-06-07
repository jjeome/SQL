SELECT last_name, email, job_id
FROM employees;

--문자만 쓰는 문자함수
SELECT UPPER(last_name), LOWER(email), INITCAP(job_id) 
FROM employees;

--dual테이블 : 더미테이블 즉 아무의미 없는 데이터. 결과만 받아볼때 씀
SELECT UPPER('oracle database'), LOWER('ORACLE DATABASE'), INITCAP('ORACLE DATABASE') 
FROM dual;

SELECT 1234+1234
FROM dual;

--CONCAT: 인수가 딱 2개씩만 들어감.
SELECT employee_id, CONCAT(first_name, lsat_name) AS fullname, salary
FROM employees;
--CONCAT의 결과를 한 번 더(중간에 공백넣어서) 하기. 함수를 중첩해서 사용.
SELECT employee_id, CONCAT(CONCAT(first_name,' '), lsat_name) AS fullname, salary
FROM employees;
--문자열 붙이기도 가능
SELECT employee_id, last_name, CONCAT(email,'@yd.com') AS email_addr
FROM employees;

--SUBSTR: 인수가 총 3개
SELECT SUBSTR('oracle database',1,6) --첫번째 글자부터 6글자만 출력
FROM dual;
SELECT SUBSTR('oracle database',8,4) --8번째 글자부터 4글자만 출력
FROM dual;
SELECT SUBSTR('oracle database',8,4)
FROM dual;
SELECT SUBSTR('oracle database',8,4), SUBSTR('oracle database',1,6), SUBSTR('oracle database',8),
            SUBSTR('oracle database',-4,4)
FROM dual;


SELECT employee_id, last_name, SUBSTR(last_name,1,3)
FROM employees
WHERE SUBSTR(last_name, -1,1)='s'; --s로 끝나는 사람만 출력. 검색을 할 때 자주 쓰임 

SELECT employee_id, last_name, SUBSTR(last_name,1,3)
FROM employees
WHERE last_name LIKE'%s'; --위와 동일한 문장

--문자함수 -> 결과는 숫자이지만 인수는 문자.
SELECT employee_id, last_name, LENGTH(last_name) --글자수
FROM employees;

--공백 포함해서 글자 수 조회
SELECT LENGTH('oracle database'), LENGTH('오라클 데이터베이스')
FROM dual;

--byte비교 
SELECT LENGTHB('oracle database'), LENGTHB('오라클 데이터베이스')
FROM dual;

--INSTR : 결과값이 숫자가되는 함수/ ' ' 안에 글자가 앞에있는 소스에서 몇번째에 있는지 나타내줌
SELECT employee_id, last_name, INSTR(last_name, 'a')
FROM employees;

SELECT *
FROM employees
WHERE INSTR(last_name, 'a') = 0; --이름에 소문자 a가 없는사람

SELECT *
FROM employees
WHERE last_name NOT LIKE '%a%'; --위와 같은 결과.( 이름에 소문자a가 없는 사람.)

--LPAD | RPAD : 방향(left, right) 
--PAD가 채운다는 뜻, L : 데이터의 왼쪽을 채운다 | R : 데이터의 오른쪽을 채운다
SELECT employee_id, RPAD(last_name, 9, '*'), LPAD(salary, 15, '*') --숫자는 바이트, 바이트로 안채워지면(남는곳) ' '안에 있는 걸로 채움
FROM employees;

--TRIM : 접두어나 접미어만 잘라낼 수 있음 ex.전화번호
SELECT TRIM('o' FROM 'oracle database')
FROM dual;

SELECT TRIM('w' FROM 'window'),
        TRIM(LEADING 'w' FROM 'window'), --앞에 있는것만 잘라내기
        TRIM(TRAILING 'w' FROM 'window') --뒤데 있는것만 잘라내기
FROM dual;

SELECT employee_id, last_name,
          CONCAT('+82',TRIM(LEADING '0' FROM phone_number))
FROM employees;


SELECT TRIM ('0' FROM '000000123001122')
FROM dual;

SELECT  RTRIM(LTRIM ('01010101101101' , '01') ,'01')
FROM dual;

--replace : 문자를 대체함
SELECT REPLACE('Jack and Jue', 'J','Bl') FROM dual; --1글자를 2글자로 바꾸는 것도 가능
SELECT employee_id, last_name, REPLACE (last_name, SUBSTR(last_name, 2,2) , '**') --이름에서 2번째 글자부터 2개를 *이걸로 대체함
FROM employees;

SELECT *
FROM employees
WHERE LOWER(last_name) = 'king'; --king을 King으로 바꾸게 가능