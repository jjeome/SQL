DROP TABLE orders_20 PURGE;
DROP TABLE prod_period PURGE;
DROP TABLE emp5 PURGE;
--DB SYSTEM 시간보기
SELECT sysdate, systimestamp FROM dual;
--systimestamp:시분초+시차

--CLIENT 지역시간보기
SELECT current_date, current_timestamp, localtimestamp
FROM dual;
--current_date = sysdate와 비슷함
--current_timestamp:시분초+ASIA/SEOUL(=+9)
--local_timestamp:시분초

--세션의 지역 변경 후 시간보기 다시 실습
ALTER SESSION SET time_zone='-10:00';
--타임존을 하와이로 변경
SELECT sysdate, systimestamp FROM dual;
--DB는 한국
SELECT current_date, current_timestamp, localtimestamp
FROM dual;
--하와이로 변경됨
ALTER SESSION SET time_zone='+09:00';
--다시 한국

--TIMESTAMP 데이터타입 실습
CREATE TABLE orders_20
(ord_id number(8),
 ord_date date,
 payment_date timestamp,
 delivery_date timestamp with time zone,
 receipt_date timestamp with local time zone);
 --서로 다른 날짜 데이터타입 사용
INSERT INTO orders_20
VALUES(12345678,  sysdate, sysdate+1/24, sysdate+1, sysdate+3);
--1시간 후 결제, 1일 후 배송, 3일 후 받음
--date타입은 to_char타입으로 변환해야함
COMMIT;
SELECT * FROM orders_20;
ALTER SESSION SET time_zone='-10:00';
--하와이에 있는 사람이 한국의 데이터 확인
SELECT current_date, current_timestamp, localtimestamp
FROM dual;

ALTER SESSION SET time_zone='+09:00';
--다시 한국으로 
SELECT * FROM orders_20;
ALTER SESSION SET time_zone='+01:00';
SELECT current_date, current_timestamp, localtimestamp
FROM dual;
SELECT * FROM orders_20;
--고정 값으로 보여줌
ALTER SESSION SET time_zone='+09:00';

SELECT sysdate+10, sysdate-10
FROM dual;
--10시간 후의 시간
SELECT TO_CHAR(sysdate+10/24, 'yyyy/mm/dd hh24:mi:ss')
FROM dual;
--오늘부터 5개월 후의 날짜
SELECT ADD_MONTHS(sysdate, 5) FROM dual;
--5년후의 날짜
SELECT ADD_MONTHS(sysdate, 60) FROM dual;

--INTERVAL TYPE Test
CREATE TABLE prod_period
(p_id NUMBER(2), 
 exchange_period INTERVAL DAY TO SECOND, --교환가능 기간
 warrant_period INTERVAL YEAR TO MONTH); --교환보증기간
DESC prod_period;


INSERT INTO prod_period
VALUES(1, INTERVAL '15' DAY, INTERVAL '3' YEAR); --15일간 교환가능, 3년간 보증가능
INSERT INTO prod_period
VALUES(2, INTERVAL '7 12:30:00' DAY TO SECOND, INTERVAL '10-6' YEAR TO MONTH); --7일 12시30분안에 / 보증기간 10년6개월
COMMIT;
SELECT * FROM prod_period;

--주문데이터의 교환가능일자 및 보증만료일 조회(수령일기준)
SELECT ord_id, receipt_date, receipt_date+exchange_period, receipt_date+warrant_period --주문번호, 받은날짜 .....
FROM orders_20 , prod_period 
WHERE p_id = 1; --제품이 1번이라면 

--간격이 없으면?
SELECT ord_id, receipt_date,  receipt_date+15, ADD_MONTHS(receipt_date, 36) --(받은날짜와 3년)
FROM order_20;

SELECT ord_id, receipt_date, receipt_date+exchange_period, receipt_date+warrant_period
FROM orders_20 , prod_period 
WHERE p_id = 2;

--관련함수의 활용
--실습을 위한 EMP5 테이블 생성 

SELECT employee_id, last_name, hire_date+TO_YMINTERVAL('5-0') AS hire_date, department_id --TO_YMINTERVAL: year to month로 변환해주는 변환함수
FROM employees;

CREATE TABLE emp5
AS
SELECT employee_id, last_name, hire_date+TO_YMINTERVAL('5-0') AS hire_date, department_id
FROM employees;
SELECT * FROM emp5;

--입사일로부터 연도/월/ 추출 EXTRACT:날짜로부터 from앞의 단위를 추출함(ex. EXTRACT(year from~) date부터 year까지
SELECT employee_id, last_name, EXTRACT(year from hire_date) --날짜데이터를 문자데이터로 변환하지 않음 
FROM emp5;
SELECT employee_id, last_name, EXTRACT(month from hire_date) 
FROM emp5;
--day 추출시 날짜 반환
SELECT employee_id, last_name, EXTRACT(day from hire_date) 
FROM emp5;
--변환함수 사용과 비교
SELECT employee_id, last_name, TO_CHAR(hire_date, 'YYYY') --글자2002를 추출(문자열로 변환해서 출력)
FROM emp5;
--변환함수 사용에서 day로 변환 시 요일 반환
SELECT employee_id, last_name, TO_CHAR(hire_date, 'day') 
FROM emp5;

--TZ_OFFSET 함수로 오프셋 정보보기 
--OFFSET : 시차적으로 +2 같은
SELECT TZ_OFFSET('Asia/Seoul') FROM dual; --시차가 계산되어 출력됨
SELECT * FROM v$timezone_names
WHERE tzname LIKE '%Seoul%'; --국제시간 이름 출력
SELECT TZ_OFFSET('Asia/Seoul') FROM dual; 
SELECT * FROM v$timezone_names
WHERE tzname LIKE '%Japan%'; 
SELECT TZ_OFFSET('Japan') FROM dual;

--EMP5의 hire_date 열의 데이터타입을 timestamp 타입으로 수정
ALTER TABLE emp5
MODIFY hire_date timestamp(0); --hire_date를 timestamp로 바꾼것. (0)->ss(초)밑에 정밀도 -쵀대 9까지 올 수 있음
DESC emp5;
SELECT * FROM emp5;

--FROM_TZ함수를 사용하여 날짜데이터 옆에 timezone 표시 
SELECT employee_id, last_name, FROM_TZ(hire_date, '+09:00') AS hire_date
FROM emp5;

--TIMESTAMP 데이터유형관련 변환함수
--TO_TIMESTAMP 함수를 사용하여 문자를 timestamp 타입 데이터로 변환
SELECT * FROM emp5
WHERE hire_date > TO_TIMESTAMP('01.01.2000 09:00:00','dd.mm.yyyy hh24:mi:ss'); -- TO_TIMESTAMP: timestamp타입의 변환함수 =TO_DATE
--TO_YMINTERVAL 함수사용으로 주문일로부터 보증기간 구하기
SELECT ord_id, ord_date, ord_date+TO_YMINTERVAL('3-0') 
FROM orders_20;

--TO_DSINTERVAL 함수사용으로 주문일로부터 결제가능시간 및 교환가능기간 구하기
SELECT ord_id, TO_CHAR(ord_date,'yyyy/mm/dd hh24:mi:ss'), 
       TO_CHAR(ord_date+TO_DSINTERVAL('0 02:30:00'),'yyyy/mm/dd hh24:mi:ss') AS 결제가능시간, --주문한 시간에서 2시산30분안에 결제가능
       ord_date+TO_DSINTERVAL('10 00:00:00') AS 교환가능기간 --10일안에 교환 가능(간격을 쿼리안에서만 해줌)
FROM orders_20; 

--TO_DSINTERVAL  대신의 방법
SELECT ord_id, ord_date,ADD_MONTHS(ord_date, 36)
FROM orders_20;
SELECT ord_id, TO_CHAR(ord_date,'yyyy/mm/dd hh24:mi:ss'), 
       TO_CHAR(ord_date+150/(24*60),'yyyy/mm/dd hh24:mi:ss') AS 결제가능시간 --위의 예제를 바꾼것
FROM orders_20;  

--Clear Test
DROP TABLE orders_20 PURGE;
DROP TABLE prod_period PURGE;
DROP TABLE emp5 PURGE;