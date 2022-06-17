
명령의 3 행에서 시작하는 중 오류 발생 -
MINUS
오류 보고 -
알 수 없는 명령


Table MY_EMPLOYEE이(가) 생성되었습니다.

이름         널?       유형           
---------- -------- ------------ 
ID         NOT NULL NUMBER(4)    
LAST_NAME           VARCHAR2(25) 
FIRST_NAME          VARCHAR2(25) 
USERID              VARCHAR2(8)  
SALARY              NUMBER(9,2)  

명령의 44 행에서 시작하는 중 오류 발생 -
INSERT INTO my_employee
VALUE (1, 'Patel', 'Ralph', 'rpatel', 895)
오류 발생 명령행: 45 열: 8
오류 보고 -
SQL 오류: ORA-00928: missing SELECT keyword
00928. 00000 -  "missing SELECT keyword"
*Cause:    
*Action:

1 행 이(가) 삽입되었습니다.


1 행 이(가) 삽입되었습니다.


명령의 56 행에서 시작하는 중 오류 발생 -
UPDATE my_employee
SET last_name = 'Drexler'
WHERE id _ 3
오류 발생 명령행: 58 열: 10
오류 보고 -
SQL 오류: ORA-00911: invalid character
00911. 00000 -  "invalid character"
*Cause:    The identifier name started with an ASCII character other than a
           letter or a number. After the first character of the identifier
           name, ASCII characters are allowed including "$", "#" and "_".
           Identifiers enclosed in double quotation marks may contain any
           character other than a double quotation. Alternate quotation
           marks (q'#...#') cannot use spaces, tabs, or carriage returns as
           delimiters. For all other contexts, consult the SQL Language
           Reference Manual.
*Action:   Check the Oracle identifier naming convention. If you are
           attempting to provide a password in the IDENTIFIED BY clause of
           a CREATE USER or ALTER USER statement, then it is recommended to
           always enclose the password in double quotation marks because
           characters other than the double quotation are then allowed.

명령의 56 행에서 시작하는 중 오류 발생 -
UPDATE my_employee
SET last_name = 'Drexler'
WHERE id _ 3
오류 발생 명령행: 58 열: 10
오류 보고 -
SQL 오류: ORA-00911: invalid character
00911. 00000 -  "invalid character"
*Cause:    The identifier name started with an ASCII character other than a
           letter or a number. After the first character of the identifier
           name, ASCII characters are allowed including "$", "#" and "_".
           Identifiers enclosed in double quotation marks may contain any
           character other than a double quotation. Alternate quotation
           marks (q'#...#') cannot use spaces, tabs, or carriage returns as
           delimiters. For all other contexts, consult the SQL Language
           Reference Manual.
*Action:   Check the Oracle identifier naming convention. If you are
           attempting to provide a password in the IDENTIFIED BY clause of
           a CREATE USER or ALTER USER statement, then it is recommended to
           always enclose the password in double quotation marks because
           characters other than the double quotation are then allowed.

0개 행 이(가) 업데이트되었습니다.


0개 행 이(가) 업데이트되었습니다.


2개 행 이(가) 업데이트되었습니다.


0개 행 이(가) 업데이트되었습니다.


1 행 이(가) 삭제되었습니다.

커밋 완료.
