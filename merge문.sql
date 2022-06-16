--MERGE 문 테스트
--실습을 위한 emp13 테이블 생성
@c:\db_test\sql_labs\cre_emp13.sql --emp13table만들어짐

--정보확인(4명의 사원, 200번 부서, commission_pct가 모두 0.4)
SELECT * FROM emp13;
SELECT * FROM employees; 
SELECT employee_id, commission_pct, department_id
FROM employees
WHERE employee_id IN (200,149,174, 176); --양쪽에 다 있는 애들이지만 정보가 다른애들

--MERGE 문 실행
MERGE INTO emp13 c
     USING employees e
     ON (c.employee_id = e.employee_id) --컬럼이름 같아서 구분해주기위해서c,e씀 (중복행 식별하는 on절)
   WHEN MATCHED THEN --동일한 애들이 있으면
     UPDATE SET --업데이트(c정보를 e정보로 업데이트 하는것)
       c.last_name      = e.last_name,
       c.job_id         = e.job_id,
       c.salary         = e.salary,
       c.department_id  = e.department_id
      DELETE WHERE (e.commission_pct IS NULL) --employees에서 commission_pct가 null인 행은 제외됨
   WHEN NOT MATCHED THEN --그렇지 않으면
     INSERT VALUES(e.employee_id, e.last_name,e.job_id, --employee절 insert하라는 것
          e.salary, e.commission_pct, e.department_id);
COMMIT;
SELECT * FROM emp13; 

