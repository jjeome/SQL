--1번 HR
INSERT INTO departments
VALUES (70, 'Public Relations', 100, 1700); --부서이름이라 ' '해줌 column순서대로 값 나열해줘야 함
SELECT * FROM departments; --관계형 DB의 특성, 삽입해준 값이 중구난방으로 들어감. 행위치를 제어할 수 없음. 빈공간이 있으면 거기에 채워질 수 있음(튜플의 무순서)

--1번 HR
ROLLBACK;
SELECT * FROM departments;

--1번 HR
INSERT INTO departments
VALUES (70, 'Public Relations', 100, 1700);
SELECT * FROM departments;
COMMIT; 

--특별한 값 입력
--SYSDATE 입력
INSERT INTO employees 
VALUES		   (113,  'Louis', 'Popp', 'LPOPP', '515.124.4567', 
                        SYSDATE, 'AC_ACCOUNT', 6900,  NULL, 205, 110); --오늘 날짜:SYSDATE (시간데이터 포함)
--TO_DATE 함수 사용 : 날짠데 DB가 날짜인지 모를때 날짜라고 인지시켜주는 함수 
INSERT INTO employees
VALUES      (114, 'Den', 'Raphealy', 'DRAPHEAL', '515.127.4561',
                      TO_DATE('02 03, 99', 'MM DD, YY'), 'SA_REP', 11000, 0.2, 100, 60); --YY : 현재 오늘의 세기
INSERT INTO employees
VALUES      (115, 'Mark', 'Kim', 'MKIM', '515.127.4562',
                      TO_DATE('02 03, 99', 'MM DD, RR'), --RR : 현재세기 50년 안넘어갔으니까 이전세기.
                      'SA_REP', 13000, 0.25, 100, 60);             
SELECT * FROM employees;
SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy/mm/dd') AS hire_date --년도 늘리기
FROM employees;

--다른 테이블로 행 복사
--테이블 구조 복사형태 (값을 넣어주면 값도 그대로 복사됨) -> 지금은 빈데이터 복사(쿼리모양만)
SELECT employee_id id, last_name name, salary, commission_pct
FROM employees
WHERE 1=2;

CREATE TABLE sales_reps 
AS 
SELECT employee_id id, last_name name, salary, commission_pct
FROM employees
WHERE 1=2;

DESC sales_reps;

SELECT * FROM sales_reps;

INSERT INTO sales_reps --한번에 여러개를 복사해서 한번에 넣을 수 있음. (다른테이블의 행을 기반으로 복사)
SELECT employee_id, last_name, salary, commission_pct
FROM   employees
WHERE  job_id LIKE '%REP%';
SELECT * FROM sales_reps;
COMMIT;

--치환변수 사용(40, Human Resource, 2500 입력)
INSERT INTO departments(department_id, department_name, location_id)
VALUES     (&department_id, '&department_name',&location); -- 원래 각각 따로 넣어야하는데 INSERT INTO로 한번에 여러개 넣음
COMMIT;
SELECT*FROM departments;

--UPDATE
--1번 HR
UPDATE employees
SET salary= 7000;
SELECT * FROM employees;
ROLLBACK;
UPDATE employees
SET salary= 7000
WHERE employee_id = 104; --동시성을 제어하는 메커니즘을 rock메커니즘이라 함
--(DML)그 행을 사용하고 있는 행이 rock이되어 transaction이 끝나면 rock이 풀림 사용중엔 타사용자가 사용 못함
ROLLBACK;

--서브쿼리를 사용한 UPDATE
UPDATE   employees
SET      job_id  = (SELECT  job_id 
                              FROM    employees 
                              WHERE   employee_id = 205), 
             salary  = (SELECT  salary 
                             FROM    employees 
                              WHERE   employee_id = 205) 
WHERE    employee_id    =  113;

--부서번호를 모르고 이름의 단어만 기억날때 LIKE문장으로 유추해 업데이트 함
UPDATE employees
SET  department_id =
                                      (SELECT department_id
                                       FROM   departments
                                       WHERE  department_name LIKE '%Public%')
WHERE employee_id = 115;
COMMIT;

--DELETE
DELETE FROM departments
WHERE  department_name = 'Finance';
DELETE FROM employees
WHERE  department_id =
                                             (SELECT department_id
                                              FROM   departments
                                              WHERE  department_name LIKE '%Public%'); --department이름에 public으로 된 부서이름을 delete.
COMMIT;

DELETE FROM departments; --DB에서 삭제 막음

--DELETE 와 TRUNCATE
SELECT * FROM sales_reps;
DELETE FROM sales_reps;
SELECT * FROM sales_reps;
ROLLBACK;
SELECT * FROM sales_reps;

--TRUNCATE -> 명령문의 카테고리가 DDL임. 자동 commit됨. 테이블이 처음 새거상태로 돌아가고 delete는 모양은 놔두고 안에 값만 삭제됨
TRUNCATE TABLE sales_reps;
SELECT * FROM sales_reps;
ROLLBACK;
SELECT * FROM sales_reps;
INSERT INTO sales_reps
SELECT employee_id, last_name, salary, commission_pct
FROM   employees
WHERE  job_id LIKE '%REP%';
SELECT * FROM sales_reps;
COMMIT;

CREATE TABLE bigemp --모양은 employees랑 똑같이 생겼지만 테이블명만 다름.
AS
SELECT * FROM employees;
SELECT *FROM bigemp;

DELETE FROM bigemp;
ROLLBACK;

INSERT INTO bigemp
SELECT *FROM bigemp;

COMMIT;

UPDATE bigemp
SET salary = salary*1.1;
ROLLBACK;

DELETE bigemp; --데이터만지워지고 용량은 그대로 남음

TRUNCATE TABLE bigemp; --undo를 생성 안해도 되서 delete와 다르게 빠르게 지워짐
SELECT *FROM bigemp;
