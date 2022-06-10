--기본키와 기본값 열을 포함하는 테이블 생성
CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY,
                                      dname       VARCHAR2(14),
                                      loc         VARCHAR2(13),
                                      create_date DATE DEFAULT SYSDATE);
DROP TABLE dept;
CREATE TABLE dept (deptno   NUMBER(2) PRIMARY KEY, --primary key 정함
                                      dname       VARCHAR2(14),
                                      loc         VARCHAR2(13),
                                      create_date DATE DEFAULT SYSDATE); --기본값 지정 : sysdate
--기본값 테스트
INSERT INTO dept(deptno, dname)
VALUES(10, '기획부'); --제약조건 허용하지 않아서 2번넣으면 오류(중복x)
INSERT INTO dept
VALUES(20, '영업부', '서울', '19/03/14'); --지정해준날짜가 기본값보다 우선시됨 (기본값:sysdate 같은)
COMMIT;
SELECT * FROM dept;
--여러가지 제약조건을 포함하는 테이블 생성
CREATE TABLE emp
(empno NUMBER(6) PRIMARY KEY, --이름없이 key만 정해줌 -> oracle이 알아서 이름붙여줌
ename VARCHAR2(25) NOT NULL, --규칙만 정해줌
email VARCHAR2(50) CONSTRAINT emp_mail_nn NOT NULL --제약조건 2개 notnull, unique/  이름을 emp_mail_nn , emp_mail_uk로 정해줌
                   CONSTRAINT emp_mail_uk UNIQUE,
phone_no CHAR(11) NOT NULL,
job VARCHAR2(20),
salary NUMBER(8) CHECK(salary>2000),
deptno NUMBER(4)REFERENCES dept(deptno)); --column 옆에 지정해줄땐 foreign key 는 TABLE에서 지정해줌
--제약조건 관련 딕셔너리 정보 보기
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints --제약조건들을 보고 싶으면 user_constraints 테이블정보를 보고싶으면 user_tables
WHERE table_name = 'EMP'; --딕셔너리는 보통 where로 지정해줌 -> 다 대문자로 지정해줘야함
SELECT cc.column_name, c.constraint_name
FROM user_constraints c JOIN user_cons_columns cc -- column이 뭔지 안나오니까 join해서 보기 
ON (c.constraint_name = cc.constraint_name) 
WHERE c.table_name = 'EMP';
SELECT table_name, index_name
FROM user_indexes
WHERE table_name IN ('DEPT','EMP');

--DML을 수행하며 제약조건 테스트하기 : 부섵테이블의 기본키 부서번호 / 사원테이블의 기본키 사원번호 / 사원번호를 참조하는 참조키
INSERT INTO emp
VALUES(null, '김수현','shkim@naver.com','01023456789','회사원',3500, null); --기본키가 null값이라 오류
INSERT INTO emp
VALUES(1234, '김수현','shkim@naver.com','01023456789','회사원',3500, null); --부서번호는 nullㄱㅊ
INSERT INTO emp
VALUES(1223, '박나래','nrpark@gmail.com','01054359876',null,1800, 20); -- 급여 제약 조건이 때문에 안들어감(2000이상이여야 함)
INSERT INTO emp
VALUES(1223, '박나래','nrpark@gmail.com','01054359876',null,7800, 20);
COMMIT;
SELECT * FROM emp;
UPDATE emp
SET deptno=30 --없는 부서번호엔 안들어감
WHERE empno=1234;
UPDATE emp
SET deptno=10
WHERE empno=1234;
COMMIT;
DELETE FROM dept --자식있어서 삭제가 안됨
WHERE deptno=10;
SELECT * FROM emp;