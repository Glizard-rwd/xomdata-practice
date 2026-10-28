-- Xom Data · Products more expensive than the category average
-- Problem: https://xomdata.com/practice/medium-subquery-103
-- Solved: 2026-10-28

with cte as (
    select 
        category,
        avg(price) as avg_price
    from products
    GROUP BY category 
)
select 
    p.product_name, 
    p.category, 
    round(p.price, 1) as price,
    round((p.price - cte.avg_price), 0) as diff_from_avg, 
    round((p.price - cte.avg_price) / cte.avg_price * 100, 2) as pct_above
from products p join cte on p.category = cte.category
where p.price > cte.avg_price
ORDER BY pct_above DESC
