--Unconditional Insert Test
SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200;

INSERT  ALL --괄호 없이 서브쿼리가 써짐 , 양쪽 테이블에 다 들어감
INTO sal_history VALUES(EMPID,HIREDATE,SAL) --컬럼명만 넣은것 
INTO mgr_history VALUES(EMPID,MGR,SAL)
SELECT employee_id EMPID, hire_date HIREDATE, salary SAL, manager_id MGR 
FROM  employees
WHERE employee_id > 200; --한번읽고 다 넣어줌

SELECT * FROM sal_history;
SELECT * FROM mgr_history;
ROLLBACK;

--조건 ALL INSERT :when절이 여러개 있어도 만족하면 ALL 다 넣으라는 뜻
INSERT ALL
WHEN SAL > 10000 THEN
INTO sal_history VALUES(EMPID,HIREDATE,SAL) --when을 만족하면then into를 실행하라는 것
WHEN MGR > 200   THEN 
INTO mgr_history VALUES(EMPID,MGR,SAL)  --when절 둘 다 만족하면 두군데 다 실행하라는 것
SELECT employee_id EMPID,hire_date HIREDATE,  
           salary SAL, manager_id MGR 
FROM   employees
WHERE  employee_id > 200;

SELECT * FROM sal_history;
SELECT * FROM mgr_history;
COMMIT;

--조건 FIRST INSERT

--그룹연산한것
SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
FROM   employees
GROUP BY department_id;

INSERT FIRST   
WHEN SAL  > 25000  THEN    
INTO special_sal VALUES(DEPTID, SAL) --첫번째 when절을 만족하는 행은 첫번째테이블에만 들어갈수있음 
WHEN HIREDATE like ('10%') THEN    --두번째 조건부터 나머지는 insert all과 똑같이 됨
INTO hiredate_history_10 VALUES(DEPTID,HIREDATE)  
WHEN HIREDATE like ('09%') THEN
INTO hiredate_history_09 VALUES(DEPTID, HIREDATE)
ELSE  INTO hiredate_history VALUES(DEPTID, HIREDATE)--아무것도 만족하지 못하는 else구문. 안써주면 그냥 사라짐
SELECT department_id DEPTID, SUM(salary) SAL, MAX(hire_date) HIREDATE  
FROM   employees
GROUP BY department_id;

SELECT * FROM special_sal; --sal >25000은 첫번째 테이블에만 들어감(90)나머지엔 나타나면 안됨
SELECT * FROM hiredate_history_10;
SELECT * FROM hiredate_history_09;
SELECT * FROM hiredate_history;
COMMIT;

--피벗 INSERT 
DESC sales_source_data
--성질이 동일한 컬럼은 행으로 저장(반복되는 것은 열이 아니라 행으로 간주해야함)
SELECT * FROM sales_source_data; 


--피벗구조의 새로운 테이블 생성 ->틀만 만들기 /피벗:가로세로 바꾸기
CREATE TABLE sales_data
(sales_no NUMBER(8), --한건 한건을 행으로 넣기
employee_id NUMBER(6),
WEEK_ID	NUMBER(2),
SALES	NUMBER(8,2));

SELECT * FROM sales_data;

--피벗 INSERT 실행하기
INSERT ALL
INTO sales_data VALUES (1, employee_id,week_id,sales_MON)  
INTO sales_data VALUES (1, employee_id,week_id,sales_TUE)
INTO sales_data VALUES (1, employee_id,week_id,sales_WED)
INTO sales_data VALUES (1, employee_id,week_id,sales_THUR)
INTO sales_data VALUES (1, employee_id,week_id, sales_FRI)
SELECT EMPLOYEE_ID, week_id, sales_MON, sales_TUE,
       sales_WED, sales_THUR,sales_FRI 
FROM sales_source_data;
SELECT * 
FROM sales_data;
--기본키가 될 만한 컬럼이 없어서 sales_no만들어줌

--시퀀스생성 및 sales 번호(sales_no) 변경
CREATE SEQUENCE sales_data_seq
START WITH 101
INCREMENT BY 1
NOCACHE
NOCYCLE;
UPDATE sales_data
SET sales_no = sales_data_seq.nextval; --시퀀스이름.다음값
commit;
SELECT * FROM sales_data; 
--정규화가 완료된 테이블 활용
SELECT employee_id, SUM(sales) FROM sales_data
WHERE week_id=6
GROUP BY employee_id
ORDER by 1;
COMMIT;

--다시하려면
@c:\db_test\sql_labs\cre_minstab.sql 
UPDATE employees
SET salary = 10500
WHERE employee_id = 206;
COMMIT;
SELECT * FROM tab;