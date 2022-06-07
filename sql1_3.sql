--치환변수: 변수로 있다가 실행하면 값을 입력해서 넣으면 됨. 변수이름앞에 &붙이면 됨 ex.&변수이름
SELECT employee_id, last_name, salary
FROM employees
WHERE department_id = &부서번호;

--문자열을 값으로 가지려면 '&문자열'로 해야함
SELECT employee_id, last_name, salary
FROM employees
WHERE last_name = '&사원이름';

--SELECT절에 column변수이름을 넣을 수 있음(마지막 column절)
SELECT employee_id, last_name, salary, &column_name
FROM employees
ORDER BY &column_name; --한 문장안에 치환변수 여러개 사용 가능(각각 나타남)

--&& 변수 값을 물었을 때 값을 가지고 있으면서 변수명이 같은 변수에게 그 값을 전달함
SELECT employee_id, last_name, salary, &&column_name
FROM employees
ORDER BY &column_name;

--값을 undefine 하기 전까지 가지고 있고 undefine하면 값이 삭제됨
DEFINE column_name
UNDEFINE column_name
DEFINE column_name

