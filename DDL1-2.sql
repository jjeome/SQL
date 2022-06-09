--2번 HR 
--TRANSACTION의 특징 (진행중인)
SELECT * FROM departments; --진행중인 transaction은 본인(현재유저)만 보임
INSERT INTO	departments (department_id, department_name)
VALUES		(30, 'Purchasing'); --나머지 적어주지 않은 column명은 저절로 null값이 들어감
INSERT INTO	departments
VALUES		(100, 'Finance', NULL, NULL); --명시적으로 null값을 저장함
SELECT * FROM departments;
COMMIT; --커밋한 순간 변경된 transaction은 공유되어 -> 일관성 있는 데이터만 제공함
SELECT * FROM employees;

SELECT employee_id, last_name, salary, commission_pct
FROM   employees
WHERE  job_id LIKE '%REP%';

INSERT INTO sales_reps --한번에 여러개를 복사해서 넣을 수 있음.
SELECT employee_id, last_name, salary, commission_pct
FROM   employees
WHERE  job_id LIKE '%REP%';
SELECT * FROM sales_reps;
COMMIT;
SELECT * FROM sales_reps;

--UPDATE
--2번 HR
UPDATE employees
SET salary= salary*1.1
WHERE employee_id = 104;
ROLLBACK;