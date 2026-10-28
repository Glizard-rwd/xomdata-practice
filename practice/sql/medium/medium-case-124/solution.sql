-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-10-28

select 
    s.full_name, 
    s.student_code, 
    round(avg(sc.final_score), 2) as avg_score,
    case 
        when avg(sc.final_score) >= 9 then 'Excellent'
        when avg(sc.final_score) >= 8 then 'Good'
        when avg(sc.final_score) >= 7 then 'Fair'
        when avg(sc.final_score) >= 5 then 'Average'
        else 'Poor'
    End as grade,
    DENSE_RANK() over (order by avg(sc.final_score) desc) as class_rank
from students s left join scores sc on s.id = sc.student_id
group by s.full_name, s.student_code
order by avg_score desc, s.student_code asc
limit 20
