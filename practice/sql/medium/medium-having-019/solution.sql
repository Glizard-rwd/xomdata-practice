-- Xom Data · High-rated sellers with many orders
-- Problem: https://xomdata.com/practice/medium-having-019
-- Solved: 2026-10-28

select 
    s.store_name, 
    s.reputation_score,
    count(o.id) as order_count,
    DENSE_RANK() over(order by count(o.id) desc) as rank_by_orders,
    sum(count(o.id)) over (order by count(o.id) desc, store_name) as cumulative_orders

from sellers s join orders o on s.id = o.seller_id
where reputation_score >= 4.5
GROUP BY s.id, s.store_name, s.reputation_score
having count(o.id) >= 3
