--사원테이블의 입사일(hire_date)을 이용해 사원의 입사 후 첫 급여일과 업무검토일을 구하시오.
--첫 급여일은 입사한 다음달 5일 입니다.(힌트 LAST_DAY)
--업무검토일은 입사 3개월 후 처음 도래하는 금요일 입니다.(힌트 ADD_MONTHS)

SELECT employee_id, last_name, hire_date,
          LAST_DAY(hire_date)+5 "첫 급여일",
          NEXT_DAY(ADD_MONTHS (hire_date,3),'금요일') "검토일"
FROM employees;
