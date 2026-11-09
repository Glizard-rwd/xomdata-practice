-- Xom Data · Total payroll by org branch
-- Problem: https://xomdata.com/practice/hard-recursive-001
-- Solved: 2026-11-09

with recursive 
    root_manager_cte as (
        select 
            m.id as manager_id, 
            m.name as manager_name,
            m.salary as manager_salary,
            count(e.id) as direct_reports
        from employees m join employees e on m.id = e.manager_id
        GROUP BY m.id, m.name
    ),
    employee_subtrees as (
        select 
            manager_id as root_id,
            manager_id as emp_id,
            manager_salary as salary
        from root_manager_cte
        UNION ALL

        select 
            es.root_id, 
            e.id as emp_id,
            e.salary
        from employee_subtrees es 
        join employees e on es.emp_id = e.manager_id
    )

    select 
        rm.manager_id, 
        rm.manager_name, 
        rm.direct_reports,
        count(es.emp_id) as subtree_size,
        sum(es.salary) as subtree_salary 
    from root_manager_cte rm join employee_subtrees es on rm.manager_id = es.root_id
    GROUP BY rm.manager_id, rm.manager_name, rm.direct_reports
    order by subtree_salary desc, manager_id asc
