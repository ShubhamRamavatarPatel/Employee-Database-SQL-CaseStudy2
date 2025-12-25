--Simple Queries:
--1. List all the employee details.
select * from employee


--2. List all the department details.
select * from Department


--3. List all job details.
select * from JOB


--4. List all the locations.
select * from  Location


--5. List out the First Name, Last Name, Salary, Commission for all Employees.
select First_Name ,last_Name, salary, comm from employee


/* 6. List out the Employee ID, Last Name, Department ID for all employees and alias
Employee ID as "ID of the Employee", Last Name as "Name of the
Employee", Department ID as "Dep_id".*/
select Employee_ID as 'ID of the Employee', 
       last_name as 'Name of the Employee' ,
       Department_id as 'Dep_id' 
from Employee


--7. List out the annual salary of the employees with their names only.
select first_name as name, salary*12 as Anuall_Salary 
from employee



-- WHERE Condition:

-- 1. List the details about "Smith".
select * from employee
where last_Name = 'smith'


-- 2. List out the employees who are working in department 20.
select * from employee
where department_ID = 20


-- 3. List out the employees who are earning salary between 2000 and 3000.
select * from employee
where salary between 2000 and 3000


-- 4. List out the employees who are working in department 10 or 20.
select * from employee
where department_ID = 10 or department_ID = 20


-- 5. Find out the employees who are not working in department 10 or 30.
select * from employee
where department_ID != 10 and department_ID != 30


-- 6. List out the employees whose name starts with 'L'.
select * from employee
where first_name like 'L%'


-- 7. List out the employees whose name starts with 'L' and ends with 'E'.
select * from employee
where first_name like 'L%E'


-- 8. List out the employees whose name length is 4 and start with 'J'.
select * from employee
where len(first_name) = 4 and first_name like 'J%'


--9. List out the employees who are working in department 30 and draw the salaries more than 2500.
select * from employee
where department_ID = 30 and salary > 2500


--10. List out the employees who are not receiving commission.
select * from employee
where comm is null


--ORDER BY Clause:

--1. List out the Employee ID and Last Name in ascending order based on the Employee ID.
select employee_ID,last_name from employee
order by 1


--2. List out the Employee ID and Name in descending order based on salary.
select employee_ID,first_name from employee
order by salary desc


--3. List out the employee details according to their Last Name in ascending-order.
select * from employee 
order by last_name


--4. List out the employee details according to their Last Name in ascending order and then Department ID in descending order.
select * from employee 
order by last_name, department_ID desc


--GROUP BY and HAVING Clause:
--1. List out the department wise maximum salary, minimum salary and average salary of the employees.
 select department_ID,
        max(salary) as max_sal,
        min(salary) as minSal, 
        avg(salary) as avgSal 
 from employee
 group by department_id


--2. List out the job wise maximum salary, minimum salary and average salary of the employees.
select JOB_ID,
        max(salary) as max_sal,
        min(salary) as minSal, 
        avg(salary) as avgSal 
 from employee
 group by job_id


--3. List out the number of employees who joined each month in ascending order.
select datename(month,hire_date) as Month, count(employee_id) as total_emp  
from employee
group by datename(month, hire_date) 

--4. List out the number of employees for each month and year in ascending order based on the year and month.
select datename(month,hire_date) as Month, year(hire_date) as year, count(employee_id) as total_emp  
from employee
group by datename(month, hire_date), year(hire_date) 
order by year(hire_date), datename(month, hire_date)


--5. List out the Department ID having at least four employees.
select department_ID, count(EMPLOYEE_ID) as Total_emp from employee
group by DEPARTMENT_ID
having count(EMPLOYEE_ID) >= 4


--6. How many employees joined in February month.
select datename(month,hire_date) as Month, count(employee_id) as total_emp  
from employee
group by datename(month, hire_date) 
having datename(month, hire_date) = 'February'


--7. How many employees joined in May or June month.
select datename(month,hire_date) as Month, count(employee_id) as total_emp  
from employee
group by datename(month, hire_date) 
having datename(month, hire_date) in ('may', 'June')


--8. How many employees joined in 1985?
select year(hire_date) as year ,count(Employee_id) as total_Emp
from employee
group by year(hire_date) 
having year(hire_date) = 1985


--9. How many employees joined each month in 1985?
select year(hire_date) as year ,datename(month,hire_date) as month ,count(Employee_id) as total_Emp
from employee
group by year(hire_date), datename(month,hire_date)
having year(hire_date) = 1985


--10. How many employees were joined in April 1985?
select year(hire_date) as year ,datename(month,hire_date) as month ,count(Employee_id) as total_Emp
from employee
group by year(hire_date), datename(month,hire_date)
having year(hire_date) = 1985 and datename(month,hire_date) = 'april'


--11. Which is the Department ID having greater than or equal to 3 employees joining in April 1985?
select year(hire_date) as year ,datename(month,hire_date) as month ,count(Employee_id) as total_Emp
from employee
group by year(hire_date), datename(month,hire_date)
having year(hire_date) = 1985 and datename(month,hire_date) = 'april' and count(Employee_id) >= 3


--Joins:

--1. List out employees with their department names.
select emp.EMPLOYEE_ID,emp.FIRST_NAME,dept.Name as departmentNames 
from EMPLOYEE as emp
join DEPARTMENT as dept on emp.DEPARTMENT_ID = dept.Department_Id


--2. Display employees with their designations.
select emp.EMPLOYEE_ID,emp.FIRST_NAME,jb.Designation 
from employee as emp
join job as jb on emp.JOB_ID  = jb.Job_ID


--3. Display the employees with their department names and city.
select emp.EMPLOYEE_ID,emp.FIRST_NAME,dept.Name as departmentNames,city as locations 
from EMPLOYEE as emp
join DEPARTMENT as dept on emp.DEPARTMENT_ID = dept.Department_Id
join location as loc on dept.Location_Id = loc.Location_ID


--4. How many employees are working in different departments? Display with department names.
select dept.name, count(employee_ID) as total_emp from DEPARTMENT as dept
left join employee as emp on dept.Department_Id = emp.DEPARTMENT_ID
group by dept.name


--5. How many employees are working in the sales department?
select dept.name, count(employee_ID) as total_emp from DEPARTMENT as dept
join employee as emp on dept.Department_Id = emp.DEPARTMENT_ID
group by dept.name
having dept.name = 'sales'


--6. Which is the department having greater than or equal to 3 employees and display the department names in ascending order.
select dept.name, count(employee_ID) as total_emp from DEPARTMENT as dept
join employee as emp on dept.Department_Id = emp.DEPARTMENT_ID
group by dept.name
having count(employee_ID) >= 3
order by dept.name 


--7. How many employees are working in 'Dallas'?
select city as locations, count(employee_ID) as totatEmp  
from EMPLOYEE as emp
join DEPARTMENT as dept on emp.DEPARTMENT_ID = dept.Department_Id
join location as loc on dept.Location_Id = loc.Location_ID
group by city
having city = 'dallas'


--8. Display all employees in sales or operation departments.
select dept.name, emp.employee_ID  from DEPARTMENT as dept
join employee as emp on dept.Department_Id = emp.DEPARTMENT_ID
where dept.name in ('operations','sales')


--CONDITIONAL STATEMENT

--1. Display the employee details with salary grades. Use conditional statement to create a grade column.
select *, 
       case
       when salary > 2500 then 'A'
       when salary > 2000 and salary <= 2500 then 'B'
       when salary > 1500 and salary <= 2000 then 'C'
       when salary > 1000 and salary <= 1500 then 'D'
       else 'E'
       end as salary_Grade
from employee


--2. List out the number of employees grade wise. Use conditional statement to create a grade column.
select
       case
       when salary > 2500 then 'A'
       when salary > 2000 and salary <= 2500 then 'B'
       when salary > 1500 and salary <= 2000 then 'C'
       when salary > 1000 and salary <= 1500 then 'D'
       else 'E'
       end as salary_Grade, 
       count(employee_id) as total_emp
from employee
group by 
       case
       when salary > 2500 then 'A'
       when salary > 2000 and salary <= 2500 then 'B'
       when salary > 1500 and salary <= 2000 then 'C'
       when salary > 1000 and salary <= 1500 then 'D'
       else 'E'
       end


--3. Display the employee salary grades and the number of employees between 2000 to 5000 range of salary
select salary,
       case
       when salary > 2500 then 'A'
       when salary > 2000 and salary <= 2500 then 'B'
       when salary > 1500 and salary <= 2000 then 'C'
       when salary > 1000 and salary <= 1500 then 'D'
       else 'E'
       end as salary_Grade, 
       count(employee_id) as total_emp
from employee
group by salary
having salary between 2000 and 5000


--Subqueries:

--1. Display the employees list who got the maximum salary.
select * from employee
where salary = (select max(salary) from employee)


--2. Display the employees who are working in the sales department.
select * from employee 
where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENT
                       where name = 'sales')


--3. Display the employees who are working as 'Clerk'.
select * from employee
where JOB_ID = (select JOB_ID from job
                 where Designation = 'clerk')


--4. Display the list of employees who are living in 'Boston'.
select * from employee
where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENT as dep
                       join location as loc on dep.Location_Id = loc.Location_ID
                       where city = 'Boston')


--5. Find out the number of employees working in the sales department.
select count(*) as total_emp from employee 
where DEPARTMENT_ID = (select DEPARTMENT_ID from DEPARTMENT
                       where name = 'sales')


--6. Update the salaries of employees who are working as clerks on the basis of 10%.
select salary from employee 
where JOB_ID = (select JOB_ID from job
                 where Designation = 'clerk')  

update employee
set salary = salary*1.10
where JOB_ID = (select JOB_ID from job
                 where Designation = 'clerk')

select salary from employee 
where JOB_ID = (select JOB_ID from job
                 where Designation = 'clerk')


--7. Display the second highest salary drawing employee details.
select top 1 * from employee
where salary < (Select max(salary) from employee)
order by salary desc


--8. List out the employees who earn more than every employee in department 30.
select * from employee
where SALARY > (select max(salary) from employee
               where DEPARTMENT_ID = 30)


--9. Find out which department has no employees.
select * from DEPARTMENT
where Department_Id not in (Select Department_Id from employee)


--10. Find out the employees who earn greater than the average salary for their department.
select * from employee as e
where salary > (
                 select avg(salary) as avgSal from employee
                 where department_id = e.department_id )