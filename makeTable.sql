--테이블 생성과 삭제
CREATE TABLE dept (deptno   NUMBER(2),
         dname       VARCHAR2(14),
         loc         VARCHAR2(13));
DESC dept;

--기본값 테스트 
--기본키 없으면 계속 추가됨(데이터) -제약이 없어서
INSERT INTO dept(deptno, dname)
VALUES(10, '기획부');
INSERT INTO dept
VALUES(20, '영업부', '서울');
COMMIT;
SELECT * FROM dept;

DESC employees
--rowid라고 명시적을 쓰니까 정보 나옴
--rowid : 행 정보를 고유하게 식별하게 쓸 때 
--rowid : 고유한 식별번호를 행이 처음에 만들어질 때 부여됨 -> 행이 삭제될때까지 이 값을 가지고있음(행을 고유하게 알려주는 값)
SELECT employee_id, rowid
FROM employees;

SELECT *
FROM employees
WHERE rowid = 'AAAE5oAAEAAAADNAAr'; --rowid (행 위치값)

SELECT * FROM dept;

SELECT deptno, dname, rowid
FROM dept;

DROP TABLE dept PURGE;

















