--뷰 생성과 사용
CREATE VIEW 	empvu80
AS SELECT  employee_id, last_name, salary
FROM    employees
WHERE   department_id = 80;

--view
SELECT * 
FROM empvu80;
--table
SELECT *
FROM dept80;

--원본테이블과 뷰 다른점? 
--테이블을 만드는 시점에 데이터를 따로 생성해서 복사되는데, 뷰는 SELECT문장을 DB에 저장후 SELECT를 실행해서 보는거랑 똑같음.
--view의 장점 : 쿼리를 짧게 만들기 가능함
--테이블은 카피된 테이블만 수정이 가능한데, 뷰로 저장해서 수정하면 원본이 수정됨 
UPDATE employees
SET salary = salary*1.2
WHERE department_id = 80;

DELETE FROM empvu80
WHERE employee_id=176;
DELETE FROM dept80
WHERE employee_id=149;

SELECT employee_id, salary,salary*12
FROM employees
WHERE department_id = 80;

SELECT *
FROM employees
WHERE department_id=80;

ROLLBACK;

--단순뷰 : dml을 통해서 수정 가능
--ex. enpv80
--복합뷰 : 진짜 테이블에 있지 않은 컬럼(표현식이나 함수식 같은)을 가지고 있어서 수정이 용이하지 않음
--뷰를 만들때 표현식으로 열을 만들기 가능한데, 이 뷰는 원본테이블에는 없는 테이블이기때문에 수정이 불가

CREATE VIEW 	salvu50
AS SELECT  employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY --테이블에 없는 쿼리 사용(표현식도 쓸 수 있음)
FROM    employees
WHERE   department_id = 50;
DESC empvu80
SELECT * FROM empvu80;
DESC salvu50
SELECT * FROM salvu50;

--뷰와 복사된 테이블 비교
SELECT * FROM dept80;
SELECT * FROM empvu80;
SELECT * FROM salvu50;
SELECT employee_id, last_name, salary*12, hire_date, department_id
FROM employees
WHERE department_ID IN (50, 80);
UPDATE employees
SET salary = salary*1.1;
COMMIT;
SELECT * FROM dept80;
SELECT * FROM empvu80;
SELECT * FROM salvu50;

--뷰 관련 데이터딕셔너리 정보 확인
SELECT view_name, text
FROM user_views; --나의 딕셔너리 정보

--뷰수정하기 : 뷰는 구조화되지 않은 객체. (테이블을 보는 객체) -> oracle에서는 ALTER로 뷰를 수정하지 X
-- oracel  : create of replace view 
CREATE OR REPLACE VIEW 	salvu50
AS SELECT  employee_id ID_NUMBER, last_name NAME, salary*12 ANN_SALARY, hire_date           
FROM    employees
WHERE   department_id = 50;
SELECT view_name, text
FROM user_views;

--COMPLEX VIEW 생성

--부서랑 사원 JOIN 
SELECT   d.department_name, MIN(e.salary), --테이블에 원래 없던 column이니까 별칭 필수
            MAX(e.salary),TRUNC(AVG(e.salary))
   FROM     employees e JOIN departments d
   ON       (e.department_id = d.department_id)
   GROUP BY d.department_name;

CREATE OR REPLACE VIEW dept_sum_vu
  (name, minsal, maxsal, avgsal) --1)view명령문 옆 괄호안에 별칭을 한꺼번에 써줌 / 2)서브쿼리 옆에 AS써서 써줌
AS SELECT   d.department_name, MIN(e.salary), 
            MAX(e.salary),TRUNC(AVG(e.salary))
   FROM     employees e JOIN departments d
   ON       (e.department_id = d.department_id)
   GROUP BY d.department_name;
SELECT * FROM dept_sum_vu;

SELECT * FROM dept_sum_vu --view
WHERE minsal > 8000;

--VIEW에 대한 DML 
desc empvu80
INSERT INTO empvu80
VALUES(250, 'Test', 4000); --선택되지 않은 컬럼이 not null이라. (선택되지 않은 컬럼에는 null값이 들어가야함)
SELECT employee_id, salary
FROM employees
WHERE employee_id = 149;
SELECT * FROM empvu80;
UPDATE empvu80 --view한테 업데이트하는 것
SET salary=20000
WHERE employee_id = 149;
SELECT employee_id, salary --확인은 진짜 테이블에 했음
FROM employees
WHERE employee_id = 149;
SELECT * FROM empvu80;
ROLLBACK;

--WITH CHECK OPTION 사용
CREATE OR REPLACE VIEW empvu80 --view를 재작성
AS SELECT  employee_id, last_name, salary, department_id --단순view
FROM    employees
WHERE   department_id = 80;
SELECT * FROM empvu80;
UPDATE empvu80
SET salary = 9800
WHERE employee_id = 176;
SELECT * FROM empvu80;
ROLLBACK;
UPDATE empvu80
SET department_id = 60
WHERE employee_id = 176;
SELECT * FROM empvu80;
ROLLBACK;

CREATE OR REPLACE VIEW empvu80
AS SELECT  employee_id, last_name, salary, department_id
FROM    employees
WHERE   department_id = 80
WITH CHECK OPTION; -- view를 만들 때 where절의 수정은 못건드림 (view를 정의한 WHERE절의)

UPDATE empvu80
SET department_id = 60
WHERE employee_id = 176;
UPDATE empvu80
SET salary = 9800
WHERE employee_id = 176;
ROLLBACK;

--WITH READ ONLY 옵션 : 단순뷰이긴 하지만 dml을 못하게 하는 것 -> 수정은 원본 테이블에서 함
CREATE OR REPLACE VIEW empvu80
AS SELECT  employee_id, last_name, salary, department_id
FROM    employees
WHERE   department_id = 80
WITH READ ONLY;
UPDATE empvu80
SET salary = 9800
WHERE employee_id = 176;

--뷰의 삭제 -> table과 마찬가지로  dictionary목록에서도 더이상 view를 사용하지 않게 삭제하는 것
SELECT view_name, text
FROM user_views;
DROP VIEW empvu80;
SELECT view_name, text
FROM user_views;
SELECT * FROM empvu80;

DROP VIEW salvu50;
DROP VIEW dept_sum_vu;