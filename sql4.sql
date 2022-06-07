--날짜데이터에 TO_CHAR 함수 사용
SELECT employee_id, last_name, hire_date
FROM employees;
SELECT employee_id, last_name, TO_CHAR(hire_date, 'dd-mm-yyyy') --dd mm yyyy는 format
FROM employees;

SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy') --결과는 문자.
FROM employees;

SELECT employee_id, last_name, 
       TO_CHAR(hire_date, 'yyyy-mm-dd day') AS hire_date,
       TO_CHAR(hire_date, 'q') AS 분기,
       TO_CHAR(hire_date, 'w')||'주차' AS 주수
FROM employees;
SELECT employee_id, last_name, TO_CHAR(hire_date, 'yyyy-mm-dd hh24:mi:ss') --사용자가 저장할때 시간데이터 없어서 DB에선 바로 0시로 맞춤.
FROM employees;

--날짜 연산에 응용

--오늘 날짜 (시간도 나오는데 보이지않음)
SELECT sysdate
FROM dual;

SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh24:mi:ss'),
       TO_CHAR(sysdate+3/24,'yyyy/mm/dd hh24:mi:ss'), -- +3시간
       TO_CHAR(sysdate+40/(24*60), 'yyyy/mm/dd hh24:mi:ss') -- +40분
FROM dual;

SELECT TO_CHAR(sysdate, 'yyyy/mm/dd hh:mi:ss am')
FROM dual;

--숫자데이터에 TO_CHAR 사용하기
SELECT employee_id, last_name, salary, 
               TO_CHAR(salary, '$999,999') --숫자 9가 아니라 6개의 자리수를 지정한 것. 자리수가 부족하면 #으로 처리됨
FROM employees;
SELECT employee_id, last_name, salary, 
       TO_CHAR(salary, '$999,999.99'),
       TO_CHAR(salary, '$099,999.99') --앞에 0을 붙여 자리수를 고정함
FROM employees;
SELECT employee_id, last_name, salary, 
       TO_CHAR(salary, 'L999,999') -- L : 각 국적의 통화기호 붙음
FROM employees;
ALTER SESSION SET nls_territory=germany; --session 을 바꾼다는 뜻, nls는 나라 ,territory는 지역 즉, 독일로 지역을 변경
SELECT employee_id, last_name, salary, 
       TO_CHAR(salary, 'L999,999')
FROM employees;
ALTER SESSION SET nls_territory=korea;
SELECT employee_id, last_name, salary, 
       TO_CHAR(salary, 'L999,999')
FROM employees;

--TO_DATE 함수 기본 형식: ('문자','format')
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > '12/31/1999';
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('12/31/1999', 'mm/dd/yyyy'); --순서는 관계없음
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('31/12/99', 'dd/mm/yy'); 
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE hire_date > TO_DATE('31/12/99', 'dd/mm/rr');
--TO_NUMBER 함수
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > $8,000; --오류 문자인데 따옴표 안해서
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > '$8,000'; --숫자 자리인데 문자쳐서 오류뜸
SELECT employee_id, last_name, salary, hire_date
FROM employees
WHERE salary > TO_NUMBER('$8,000','$9,999');

--함수중첩
SELECT last_name,
              UPPER(CONCAT(SUBSTR (LAST_NAME, 1, 8), '_US')) --lastname을 8글자까지만 출력해라
FROM   employees
WHERE  department_id = 60;

--일반함수 NVL 기능 : null값을 출력하는 동안에 다른값으로 치환시켜주는 함수
SELECT employee_id, last_name, salary, commission_pct
FROM employees;
SELECT employee_id, last_name, salary, NVL(commission_pct, 0) --column이름 그리고 0으로 치환.
FROM employees;
SELECT employee_id, last_name, salary+salary*commission_pct as monthly_sal 
FROM employees;
SELECT employee_id, last_name, 
              salary+salary*NVL(commission_pct,0) as monthly_sal 
FROM employees;

--일반함수 NVL2 : (첫번째 인수가 null이면 두번째 값, null이 아니면 세번째 값이 들어감)
SELECT employee_id, last_name, 
              salary+salary*NVL(commission_pct,0) as monthly_sal,
              NVL2(commission_pct, 'Y', 'N') AS comm_get
FROM employees;
SELECT last_name,  salary, commission_pct,
              NVL2(commission_pct, 'SAL+COMM', 'SAL') income
FROM   employees 
WHERE department_id IN (50, 80);

--일반함수 NULL IF : 두개의 인수가 같으면 null을 반환 , 다르면 앞의 인수가 출력됨
SELECT employee_id, last_name, 
               salary+salary*NVL(commission_pct,0) as monthly_sal,
               NVL2(commission_pct, 'Y', 'N') AS comm_get,
               NULLIF(salary,  salary+salary*NVL(commission_pct,0)) AS result
FROM employees;
SELECT first_name, LENGTH(first_name) "expr1", 
              last_name,  LENGTH(last_name)  "expr2",
             NULLIF(LENGTH(first_name), LENGTH(last_name)) result
FROM   employees;

--일반함수 COALESCE : 인수 갯수가 정해져 있지 않음, 첫 인수가 null이 아니면 첫 인수를 반환
-- 첫 인수가 null이면 다음인수 반환하는데, 다음인수도 null이면 그다음, 이런식으로 넘어감
SELECT employee_id, commission_pct, manager_id,
              COALESCE(commission_pct, manager_id, 1234) AS result --한 열에 들어가는 데이터 타입이 같아야함
FROM employees;  
SELECT last_name, employee_id,
                --데이터타입 맞출 때 두번째 인수인 format 생략 가능!!@@!!
              COALESCE(TO_CHAR(commission_pct),TO_CHAR(manager_id), 'No commission and no manager') 
FROM employees;

--CASE 구문 사용     
SELECT last_name, job_id, salary,
                --case부터 end까지가 표현식 revised_salary는 별칭.
                --job_id를 기준으로 WHEN_______이면 THEN_______을 출력, ELSE(기타)면 end.
              CASE job_id WHEN 'IT_PROG'  THEN  1.10*salary
                                    WHEN 'ST_CLERK' THEN  1.15*salary
                                    WHEN 'SA_REP'   THEN  1.20*salary
                                    ELSE      salary END     "REVISED_SALARY" --else생략하면 결과 null로 나옴
FROM   employees;

--위와 결과 동일하지만 아래의 CASE형식이 값을 더 다양하게 만들어줌
SELECT last_name, job_id, salary,
              CASE  WHEN job_id = 'IT_PROG'  THEN  1.10*salary
                          WHEN job_id = 'ST_CLERK' THEN  1.15*salary
                          WHEN job_id ='SA_REP'   THEN  1.20*salary
                          ELSE      salary END     "REVISED_SALARY"
FROM   employees;

--비교를 다양하게 가능
SELECT employee_id, last_name, salary,
              CASE WHEN salary < 5000 THEN 'L'
                         WHEN salary BETWEEN 5000 AND 9000 THEN 'M'
                         ELSE 'H' END AS salary_grade
FROM employees;       

--NVL2 함수 결과를 CASE 문으로 대체 
SELECT employee_id, last_name, 
              salary+salary*NVL(commission_pct,0) as monthly_sal,
              CASE WHEN commission_pct IS NOT NULL THEN 'Y'
                         ELSE 'N' END AS comm_get
FROM employees;

--DECODE 함수 : CASE와 같은 함수 (CASE가 나오기 이전의 함수 요즘은 DECODE거의 안씀)
SELECT last_name, job_id, salary,
             DECODE(job_id, 'IT_PROG',  1.10*salary,
                                          'ST_CLERK', 1.15*salary,
                                          'SA_REP',   1.20*salary,
                                                                        salary)  AS  REVISED_SALARY
FROM   employees;
SELECT last_name, salary,
               DECODE (TRUNC(salary/2000, 0), --나눗셈해서 정수가 0이 안나오면 trunc하라는 것.
                         0, 0.00,
                         1, 0.09,
                         2, 0.20,
                         3, 0.30,
                         4, 0.40,
                         5, 0.42,
                         6, 0.44,
                            0.45) TAX_RATE
FROM   employees
WHERE  department_id = 80;