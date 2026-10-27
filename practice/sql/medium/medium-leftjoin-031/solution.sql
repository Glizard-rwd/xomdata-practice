-- Xom Data · Candidates not yet interviewed
-- Problem: https://xomdata.com/practice/medium-leftjoin-031
-- Solved: 2026-10-27

SELECT full_name, email, application_date,
ROW_NUMBER() over (ORDER BY(application_date)) as queue_position,
ROUND(
    cast(percent_rank() over (ORDER BY(application_date)) * 100 as numeric), 2) as older_than_pct
from candidates c
where not exists (
    select 1 from interviews i where i.candidate_id = c.id 
)
