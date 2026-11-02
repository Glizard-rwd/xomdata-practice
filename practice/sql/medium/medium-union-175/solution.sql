-- Xom Data · Summary of issues to handle
-- Problem: https://xomdata.com/practice/medium-union-175
-- Solved: 2026-11-02

with all_problem as (
    select 'Complaint' as issue_type,
    count(case when status = 'Pending' then 1 end) as quantity
    from complaints

    UNION ALL 
    select 'Cancelled Order' as issue_type,
    count(case when status = 'Cancelled' then 1 end) as quantity
    from orders
    
    UNION ALL 
    select 'Out of Stock Product' as issue_type,
    count (case when status = 'Out of Stock' then 1 end) as quantity
    from products
) 
select 
    issue_type as type,
    quantity,
    round(quantity/ nullif(sum(quantity) over(), 0) * 100, 2) as pct_of_total, 
    rank() over(order by quantity desc) as rank_pos, 
    round(sum(quantity) over (
        order by quantity desc, issue_type asc
        rows between unbounded preceding and current row
    ) * 100 / nullif(sum(quantity) over(), 0), 2) as cumulative_pct
from all_problem
ORDER BY rank_pos ASC, type ASC;
