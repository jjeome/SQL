
����� 3 �࿡�� �����ϴ� �� ���� �߻� -
MINUS
���� ���� -
�� �� ���� ���


Table MY_EMPLOYEE��(��) �����Ǿ����ϴ�.

�̸�         ��?       ����           
---------- -------- ------------ 
ID         NOT NULL NUMBER(4)    
LAST_NAME           VARCHAR2(25) 
FIRST_NAME          VARCHAR2(25) 
USERID              VARCHAR2(8)  
SALARY              NUMBER(9,2)  

����� 44 �࿡�� �����ϴ� �� ���� �߻� -
INSERT INTO my_employee
VALUE (1, 'Patel', 'Ralph', 'rpatel', 895)
���� �߻� �����: 45 ��: 8
���� ���� -
SQL ����: ORA-00928: missing SELECT keyword
00928. 00000 -  "missing SELECT keyword"
*Cause:    
*Action:

1 �� ��(��) ���ԵǾ����ϴ�.


1 �� ��(��) ���ԵǾ����ϴ�.


����� 56 �࿡�� �����ϴ� �� ���� �߻� -
UPDATE my_employee
SET last_name = 'Drexler'
WHERE id _ 3
���� �߻� �����: 58 ��: 10
���� ���� -
SQL ����: ORA-00911: invalid character
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

����� 56 �࿡�� �����ϴ� �� ���� �߻� -
UPDATE my_employee
SET last_name = 'Drexler'
WHERE id _ 3
���� �߻� �����: 58 ��: 10
���� ���� -
SQL ����: ORA-00911: invalid character
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

0�� �� ��(��) ������Ʈ�Ǿ����ϴ�.


0�� �� ��(��) ������Ʈ�Ǿ����ϴ�.


2�� �� ��(��) ������Ʈ�Ǿ����ϴ�.


0�� �� ��(��) ������Ʈ�Ǿ����ϴ�.


1 �� ��(��) �����Ǿ����ϴ�.

Ŀ�� �Ϸ�.
