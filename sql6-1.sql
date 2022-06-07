--NATURAL JOIN / JOIN : 정규화 전 상태
SELECT * 
FROM departments;
SELECT * 
FROM locations;
SELECT department_id, department_name, location_id, city, street_address
FROM departments NATURAL JOIN locations; --테이블 이름 사이에 natural join / 열(column) 이름이 같아야 join이 됨
SELECT employee_id, last_name, department_id, department_name
FROM employees NATURAL JOIN departments;

--USING 절을 사용하는 JOIN : 한 column만 지정해서 사용 할 수 있음
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id); --column명을 적고 join을 할 것.(column명은 똑같아야 함)
SELECT department_id, department_name, location_id, city
FROM departments JOIN locations
USING (location_id);

--ON절을 사용하는 JOIN : 
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id); 
SELECT employee_id, last_name, employees.department_id, department_name -- column명이 같으면 테이블의 명을 접두어로 써준다.
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);

--테이블 이름 별칭 사용 
SELECT employees.employee_id, employees.last_name, 
               employees.department_id, departments.department_name
FROM employees JOIN departments
ON (employees.department_id = departments.department_id);
--가장흔한 JOIN 문장(JOIN양쪽 모두 만족)
SELECT e.employee_id, e.last_name, 
       e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);

--WHERE 절 추가
SELECT e.employee_id, e.last_name, e.salary,
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
WHERE e.salary > 9000;
SELECT e.employee_id, e.last_name, e.salary,
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
AND e.salary > 9000; --추가조건

--INNER JOIN과 OUTER JOIN
--JOIN 결과만 : INNERJOIn
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e JOIN departments d
ON (e.department_id = d.department_id);
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e LEFT OUTER JOIN departments d 
ON (e.department_id = d.department_id);
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e RIGHT OUTER JOIN departments d
ON (e.department_id = d.department_id);
SELECT e.employee_id, e.last_name, 
               e.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);

--USING절에 OUTER 조인하기
SELECT employee_id, last_name, department_id, department_name
FROM employees LEFT OUTER JOIN departments
USING (department_id);
SELECT employee_id, last_name, department_id, department_name
FROM employees JOIN departments
USING (department_id);

--SELF JOIN : 한테이블에서 join. (열끼리) 즉, 두테블인것처럼 쓰임 + 테이블 별칭(필수)
SELECT employee_id, last_name, manager_id
FROM employees;

SELECT e.employee_id, e.last_name, e.manager_id, m.last_name
FROM employees e JOIN employees m --같은 테이블을 두번 읽었지만 다른 테이블에서 읽었는 듯이 . 별칭 다르게. 같은 테이블을 두번 FROM에 적기
ON (e.manager_id = m.employee_id);
SELECT e.employee_id, e.last_name, e.manager_id, m.last_name 
FROM employees e LEFT OUTER JOIN employees m
ON (e.manager_id = m.employee_id);

--NON-EQUI JOIN : 동등 JOIN 
SELECT * 
FROM job_grades;
SELECT e.employee_id, e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON (e.salary BETWEEN j.lowest_sal AND j.highest_sal);

--3Way JOIN : join하는 열이 꼭 select절에 있을 필요 X 
SELECT e.employee_id, e.last_name, d.department_id, l.city
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);
SELECT e.employee_id, e.last_name, d.department_id, l.city
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (d.location_id = l.location_id);

--Cartesian Products : 전체 경우의 수
SELECT employee_id, city
FROM employees NATURAL JOIN locations; -- Cartesian Products 일부러 시킴
SELECT employee_id, department_name
FROM employees CROSS JOIN departments; --전체경우를 보여줌

--GROUP함수와 JOIN 응용
SELECT   d.department_name, MIN(e.salary), 
                MAX(e.salary),TRUNC(AVG(e.salary))
FROM     employees e JOIN departments d
ON       (e.department_id = d.department_id)
GROUP BY d.department_name;