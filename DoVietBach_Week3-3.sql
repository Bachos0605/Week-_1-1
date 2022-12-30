-- Bai 1: Create Procedure
-- 1)
create or replace procedure dept_info (
	v_department_id in DEPARTMENTS.DEPARTMENT_ID%type,
	v_result out DEPARTMENTS%rowtype
)
is
begin
	select * into v_result from DEPARTMENTS where DEPARTMENTS.DEPARTMENT_ID = v_department_id;
end;
-- 2)
create or replace procedure add_job (
	v_job_id in varchar2,
	v_job_name in varchar2
)
is
begin
	insert into JOBS(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY) values (v_job_id, v_job_name, '', '');
end;
-- 3)
create or replace procedure update_comm (
	v_employee_id in number
)
is
begin
	update EMPLOYEES set COMMISSION_PCT = COMMISSION_PCT * 1.05 where EMPLOYEES.EMPLOYEE_ID = v_employee_id;
end;
-- 4)
create or replace procedure "add_emp" (
	v_employee_id in number,
	v_first_name in varchar2,
	v_last_name in varchar2,
	v_email in varchar2,
	v_phone_number in varchar2,
	v_hire_date in date,
	v_job_id in varchar2,
	v_salary in number,
	v_commission_pct in number,
	v_manager_id in number,
	v_department_id in number
)
is
begin
	insert into EMPLOYEES
	( EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID )
values
	( v_employee_id, v_first_name, v_last_name, v_email, v_phone_number, v_hire_date, v_job_id, v_salary, v_commission_pct, v_manager_id, v_department_id );
end;
-- Question 5
create or replace procedure "delete_emp" (
	v_employee_id in number
)
is
begin
	delete from EMPLOYEES where EMPLOYEES.EMPLOYEE_ID = v_employee_id;
end;
-- Question 6
create or replace procedure "find_emp" (
	v_result out EMPLOYEES%rowtype
)
is
begin
	select
		EMPLOYEES.*
	into
		v_result
	from
		EMPLOYEES
		join jobs on jobs.JOB_ID = EMPLOYEES.JOB_ID
	where
		EMPLOYEES.SALARY > jobs.MIN_SALARY
		end EMPLOYEES.SALARY < jobs.MAX_SALARY;
end;

-- 7)
create or replace procedure update_comm (p_employee_id IN employees.employee_id%TYPE)
as
  v_hire_date   employees.hire_date%type;
  v_salary      employees.salary%type;
  v_years       number;
begin
  select hire_date, salary
  into v_hire_date, v_salary
  from employees
  where employee_id = p_employee_id;

  v_years := trunc(MONTHS_BETWEEN(SYSDATE, v_hire_date) / 12);

  update employees
  set salary =
    case
      when v_years >= 2 then v_salary + 200
      when (v_years > 1 and v_years < 2)  then v_salary + 100
      when v_years = 1  then v_salary + 50
      else v_salary + 0
    end
  where employee_id = p_employee_id;
end;
-- 8)
create or replace procedure "LINH_HR_COPY"."job_his" (
	v_employee_id in number,
	v_result out JOB_HISTORY%rowtype
)
is
begin
	select * into v_result from JOB_HISTORY where JOB_HISTORY.EMPLOYEE_ID = v_employee_id;
end; 
-- Bai 2: Create Function
-- 1)
create or replace function "sum_salary" (
	v_department_id number
)
return number
is
	c_number number;
	cursor c1 IS
	select sum(SALARY) "Sum_Salary" from EMPLOYEES  where EMPLOYEES.DEPARTMENT_ID = v_department_id;
begin
	open c1;
	fetch c1 into c_number;
	close c1;
	return c_number;
END;
-- 2)
create or replace function "name_con" (
	v_country_id varchar2
)
return varchar2
is
	c_result varchar2(100);
	cursor c1 is
	select COUNTRY_NAME from COUNTRIES where COUNTRIES.COUNTRY_ID = v_country_id;
begin
	open c1;
	fetch c1 into c_result;
	close c1;
	return c_result;
end;
-- 3)
create or replace function "annual_comp" (
	v_month_sal number;
	v_commission number;
)
return number
is
	c_result number;
begin
	c_result := v_month_sal*12 + (v_commission*v_month_sal*12)
	return c_result;
end;
-- 4)
create or replace function "avg_salary" (
	v_department_id number
)
return number
is
	c_result number;
	cursor c1 IS
	select avg(SALARY) "Average_Salary" from EMPLOYEES  where EMPLOYEES.DEPARTMENT_ID = v_department_id;
begin
	open c1;
	fetch c1 into c_result;
	close c1;
	return c_result;
end;
-- 5)
create or replace function "time_work" (
	v_employee_id number
)
return number
is
	c_result number;
	cursor c1 is
	select (trunc( sysdate ) - HIRE_DATE) * 12 "Months" from EMPLOYEES where EMPLOYEES.EMPLOYEE_ID = v_employee_id;
begin
	open c1;
	fetch c1 into c_result;
	close c1;
	return c_result;
end;

-- Bai 3: Create Trigger
-- 1)
drop trigger trigger_01_insert_update_employees;

create or replace trigger trigger_01_insert_update_employees
  before insert or update on EMPLOYEES
  for each row
begin
  if sysdate < :new.HIRE_DATE then
    RAISE_APPLICATION_ERROR(-20001, 'Wrong');
  end if;
end;

alter trigger trigger_01_insert_update_employees disable;
alter trigger trigger_01_insert_update_employees enable;
--2)
drop trigger trigger_insert_update_jobs;

create or replace trigger trigger_insert_update_jobs
  before insert or update on JOBS
  for each row
begin
  if :new.MIN_SALARY > :new.MAX_SALARY then
    RAISE_APPLICATION_ERROR(-20001, 'Wrong');
  end if;
end;

alter trigger trigger_insert_update_jobs disable;
alter trigger trigger_insert_update_jobs enable;
--3)
drop trigger trigger_insert_update_job_history;

create or replace trigger trigger_insert_update_job_history
  before insert or update on JOB_HISTORY
  for each row
begin
  if :new.END_DATE > :new.START_DATE then
    RAISE_APPLICATION_ERROR(-20001, 'Wrong');
  end if;
end;

alter trigger trigger_insert_update_job_history disable;
alter trigger trigger_insert_update_job_history enable;
--4)
drop trigger trigger_02_update_employees;

create or replace trigger trigger_02_update_employees
  before update on EMPLOYEES
  for each row
begin
  if :new.SALARY <= :old.SALARY and (:new.COMMISSION_PCT <= :old.COMMISSION_PCT and :old.COMMISSION_PCT != NULL) then
     RAISE_APPLICATION_ERROR(-20001, 'Wrong');
  end if;
end;

alter trigger trigger_02_update_employees disable;
alter trigger trigger_02_update_employees enable;



