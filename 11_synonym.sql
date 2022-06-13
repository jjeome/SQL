--자동 인덱스 생성
DROP TABLE emp;

CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY, --이름 지정x : sys___라고 나옴
ename VARCHAR2(25) NOT NULL,
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4)); --총 제약조건 6개

--제약조건 관련 딕셔너리 정보 보기
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'EMP';

SELECT table_name, index_name -- index이름은 제약조건 이름과 같게 만들어짐  : 자동으로 생성된 index
FROM user_indexes
WHERE table_name = 'EMP';

--수동으로 인덱스 생성
CREATE INDEX emp_ename_idx ON emp(ename); --ON 테이블이름 (컬럼명)

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP';

--인덱스 삭제 : 수동으로 만든것만 삭제 가능
DROP INDEX emp_email_uk; -- 자동으로 만들어진 index라 지울 수 없음

DROP INDEX emp_ename_idx;

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMP';

SELECT table_name, index_name
FROM user_indexes
WHERE table_name = 'EMPLOYEES';

SELECT *
FROM employees
WHERE employee_id = 101;
