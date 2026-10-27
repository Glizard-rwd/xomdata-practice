-- Xom Data · Customer spending per order
-- Problem: https://xomdata.com/practice/medium-join-001
-- Solved: 2026-10-27

select 
    full_name, count(o.id) as order_count, sum(total_amount) as total_spending, round(avg(total_amount), 0) as avg_order_value,  
    row_number() over (order by sum(total_amount) desc, full_name asc) as spending_rank
from customers c join orders o on c.id = o.customer_id 
GROUP BY c.id, c.full_name
