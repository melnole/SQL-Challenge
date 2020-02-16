drop table departments cascade;
drop table salaries cascade;
drop table employees cascade;
drop table dept_manager cascade;
drop table titles cascade;
drop table dep_emp cascade;


CREATE TABLE "departments" (
    "dept_no" varchar   NOT NULL,
    "dept_name" varchar   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "gender" varchar   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);


CREATE TABLE "dept_manager" (
    "dept_no" varchar   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" int   NOT NULL,
    "title" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dep_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL

);

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

--Q1 employee number, last, first name, gender, salary

select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from employees e
left join salaries s
on e.emp_no = s.emp_no
--order by emp_no asc;

--Q2 list of employees who were hired in 1986

select first_name, last_name, hire_date
from employees
where hire_date between '1986-1-1' and '1986-12-31'

--Q3 list the manager of each dept with *dept_no, dept_name, *manager emp_no, manager last and first name, *start and *end date
--i added title as extra layer, was just checking stuff out

select dm.emp_no, dm.dept_no, d.dept_name, e.first_name, e.last_name, t.title, dm.from_date, dm.to_date
from departments d
left join dept_manager dm
on d.dept_no = dm.dept_no
left join employees e
on dm.emp_no = e.emp_no
left join titles t
on e.emp_no = t.emp_no
where title = 'Manager'

--Q4 list the dept of each employee with emp_no, last_name, first_name, dept_name

select d.dept_no, d.dept_name, de.emp_no, e.first_name, e.last_name
from departments d
left join dep_emp de
on d.dept_no = de.dept_no
left join employees e
on de.emp_no = e.emp_no

--Q5 employees first name Hercules and last name begin with B

select first_name, last_name
from employees
where first_name = 'Hercules' and last_name like 'B%'

--Q6 all employees dept_name = sales, emp_no, last_name, first_name, dept_name

select d.dept_name, de.emp_no, e.first_name, e.last_name
from departments d
left join dep_emp de
on d.dept_no = de.dept_no
left join employees e
on de.emp_no = e.emp_no
where dept_name = 'Sales'

--Q7 all employees sales and development depts, emp_no, last_name, first_name, dept_name

select d.dept_name, de.emp_no, e.first_name, e.last_name
from departments d
left join dep_emp de
on d.dept_no = de.dept_no
left join employees e
on de.emp_no = e.emp_no
where dept_name = 'Sales' or dept_name = 'Development'
--other option(not sure what you're asking for here) where dept_name in ('Sales', 'Development')
--order by last_name asc, first_name asc


--Q8 frequency count of emp last_names (how many emp have same last name) ; list in desc

select count(last_name), last_name
from employees
group by last_name
order by last_name desc;




