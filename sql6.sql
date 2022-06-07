--JOIN : 값대 값을 찾아서 가져옴 (column이름이 달라도 할 수 있음)
SELECT employee_id, last_name, salary, department_id, department_name
FROM employees JOIN departments --사원하고 부서와 합쳐서 보란뜻, 테이블을 분해해 놨기 때문에 붙여서 봐야함
USING(department_id); --같은 데이터를 한 column이 가지고 있어야 함

--NATURAL JOIN : departments와 location공통되는 column찾아서 합쳐줌, column이 딱 하나만 join가능할 때 사용 가능.
--주로 양쪽에 join가능한 column이 한 개 일 때 사용가능. column명 같을 때 쓰임(같은 column이 하나밖에 없을 때 더 적합)
SELECT * 
FROM departments;
SELECT * 
FROM locations;
SELECT department_id, department_name, location_id, city
FROM departments NATURAL JOIN locations;
SELECT employee_id, last_name, department_id, department_name
FROM employees NATURAL JOIN departments;


--USING 절을 사용하는 JOIN : column명 같을 때 쓰임 여러개일 때 특정 column을 지정해서 보여줌
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id);
SELECT department_id, department_name, location_id, city
FROM departments JOIN locations
USING (location_id);

--ON절을 사용하는 JOIN : 양쪽 테이블의 column명이 다를 때 사용
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments --오류 이유 : select절에 column명이 같은 애가 있으면 헷갈려함 그래서 오류 뜸
ON (employees.department_id = departments.department_id);
SELECT employee_id, last_name, employees.department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);