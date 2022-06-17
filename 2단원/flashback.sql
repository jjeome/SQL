--Flashback Query Test : 시간을 콕 집어줘야함
SELECT salary FROM employees
WHERE employee_id = 178; --원래 값 undo파일로 넘어감
UPDATE employees
SET salary = 12000
WHERE employee_id = 178;
COMMIT;
SELECT salary FROM employees
WHERE employee_id = 178;
SELECT salary FROM employees
AS OF  TIMESTAMP sysdate-5/(24*60) --시간설정 : 5분
WHERE employee_id = 178; --178번의 5분전 값을 보겠다는 절

UPDATE employees --서브쿼리로 업데이트 하기
SET salary = (SELECT salary FROM employees
                  AS OF  TIMESTAMP sysdate-5/(24*60)
                  WHERE employee_id = 178)
WHERE employee_id = 178;

SELECT salary FROM employees
WHERE employee_id = 178;
COMMIT;

--Flashback Versions Query Test
UPDATE employees
SET salary = 10000
WHERE employee_id = 178;
COMMIT;
SELECT salary FROM employees
WHERE employee_id = 178;
SELECT versions_starttime, versions_endtime, salary, versions_xid
FROM employees
versions BETWEEN timestamp minvalue AND maxvalue --시간이 젤 적은거부터 오래된것까지 보는 것
WHERE employee_id = 178;

--Flashback Transaction Query
--Flashback Versions Query 결과의 급여 12000의 versions_xid 값 복사
--예시 0A001B004C020000
SELECT undo_sql FROM flashback_transaction_query --undo sql을 보려고 할 때 
WHERE xid = '01001300C2010000'; ----실행 취소할 transaction 넣어주기
--조회결과의 undo_sql 문장을 복사에서 실행 후 복원된 값 확인
--예시
update "HR"."EMPLOYEES" set "SALARY" = '12000' where ROWID = 'AAAE5oAAEAAAADNABO';
SELECT salary FROM employees
WHERE employee_id = 178;
COMMIT;