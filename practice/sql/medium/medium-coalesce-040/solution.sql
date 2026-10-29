-- Xom Data · Book count and average price by genre
-- Problem: https://xomdata.com/practice/medium-coalesce-040
-- Solved: 2026-10-29

select g.genre_name,
    case 
        when count(b.id) is null then 0 else count(b.id) end as book_count,
    case 
        when count(b.id) = 0 then 0 else round(avg(b.price), 0) end as avg_price,
    case
        when count(b.id) = 0 then 0 else min(b.price) end as min_price,
    case
        when count(b.id) = 0 then 0 else max(b.price) end as max_price,
    case 
        when count(b.id) = 0 then 0 else round(max(b.price) - min(b.price), 0) end as price_range,
    RANK() over (order by count(b.id) desc) as coverage_rank, 
    ntile(3) over (order by count(b.id) desc, g.genre_name asc) as library_focus    
from genres g left join books b on g.id = b.genre_id
GROUP BY g.id
