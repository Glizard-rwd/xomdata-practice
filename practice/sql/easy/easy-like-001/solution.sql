-- Xom Data · Basic-plan subscribers
-- Problem: https://xomdata.com/practice/easy-like-001
-- Solved: 2026-10-27

select phone_number, full_name, plans from subscribers where plans ilike '%basic%' ORDER BY full_name
