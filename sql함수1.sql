--날짜데이터에 TO_CHAR 함수 사용
SELECT employee_id, last_name, hire_date
FROM employees;
SELECT employee_id, last_name, TO_CHAR(hire_date, 'dd-mm-yyyy') --결과는 문자임 날짜가 아님.
FROM employees;
SELECT employee_id, last_name, 
       TO_CHAR(hire_date, 'yyyy-mm-dd day') AS hire_date,
       TO_CHAR(hire_date, 'q') AS 분기, --문자임(왼쪽에 있으니까)
       TO_CHAR(hire_date, 'w')||'주차' AS 주수 
FROM employees;
SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy-mm-dd hh24:mi:ss')
FROM employees;
--날짜 연산에 응용
SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss'), --오후시간 표기법 ss는 초.
       TO_CHAR(sysdate+3/24,'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss') --현재 시간에서 40분 후
FROM dual;
DESC employees;

--응용프로그램이 날짜만 줬는데 DB에서 시간을 그냥 자정으로 맞춰놓은거(테이블 길이만 맞추기 위해서)
--응용프로그램이 시간을 처리할 수 있든없든 DB는 길이가 똑같음 
SELECT employee_id, last_name, TO_CHAR(hire_date,'yyyy/mm/dd hh24:mi:ss') 입사일
FROM employees;


