-- Xom Data · Top 10 highest-paid employees and their leave days
-- Problem: https://xomdata.com/practice/medium-agg-127
-- Solved: 2026-11-02

with avg_salary_department as (
    select department_id, department_name, 
    sum(p1.net_salary) * 1.0 / NULLIF(COUNT(distinct e1.id), 0) as avg_salary
    from departments d1 join employees e1 on d1.id = e1.department_id
    join payroll p1 on e1.id = p1.employee_id
    GROUP BY department_id , department_name
), payroll_by_employee as (
    select employee_id, sum(net_salary) as net_salary
    from payroll 
    GROUP BY employee_id
), leaves_by_employee as (
    select employee_id, count(id) as leave_count
    from leaves 
    where status = 'approved'
    GROUP BY employee_id
)
select 
    e.full_name, e.employee_code,
    asd.department_name,
    p.net_salary as total_received_salary,
    COALESCE(l.leave_count, 0) as leave_count,
    round((p.net_salary - asd.avg_salary) * 100.0 / nullif(asd.avg_salary, 0), 2)
    as pct_above_dept_avg

from employees e
join avg_salary_department asd on asd.department_id = e.department_id
left join payroll_by_employee p on e.id = p.employee_id
left join leaves_by_employee l on e.id = l.employee_id

ORDER BY total_received_salary desc, employee_code asc 
limit 10
