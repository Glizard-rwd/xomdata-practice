-- Xom Data · Median and percentile salary by department
-- Problem: https://xomdata.com/practice/hard-percentile-001
-- Solved: 2026-11-09

with pct_rank_cte as  (
    select 
    department,
    salary,
    percent_rank() over (PARTITION BY department order by salary) as pct_rank
from employees
), 
diff_rank as (
select 
    department,
    salary,
    ROW_NUMBER() over(PARTITION BY department order by abs(pct_rank - 0.25) asc, salary asc) as p25_rank,
    ROW_NUMBER() over(PARTITION BY department order by abs(pct_rank - 0.5) asc, salary asc) as p50_rank,
    ROW_NUMBER() over(PARTITION BY department order by abs(pct_rank - 0.75) asc, salary asc) as p75_rank
from pct_rank_cte
)
select 
    department,
    MIN(case when p25_rank=1 then salary end) as p25, 
    MIN(case when p50_rank=1 then salary end) as p50, 
    MIN(case when p75_rank=1 then salary end) as p75
from diff_rank 
GROUP BY department
