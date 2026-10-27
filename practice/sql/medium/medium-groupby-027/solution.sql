-- Xom Data · Average score per subject
-- Problem: https://xomdata.com/practice/medium-groupby-027
-- Solved: 2026-10-27

select subject_name, credits, count(g.id) as student_count, round(avg(final_score), 2) as avg_score,
       round(avg(case when final_score >= 5 then 1 else 0 end) * 100, 2) as pass_rate,
       rank() over (order by avg(final_score) DESC) as rank_by_avg,
       ntile(4) over (order by avg(final_score) desc, s.subject_name asc) as difficulty_quartile 
from subjects s join grades g on s.id = g.subject_id 
GROUP BY s.id, s.subject_name, s.credits
