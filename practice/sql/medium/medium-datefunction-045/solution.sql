-- Xom Data · Transaction count and amount by month
-- Problem: https://xomdata.com/practice/medium-datefunction-045
-- Solved: 2026-10-29

SELECT 
    SUBSTRING(transaction_date, 1, 7) as month,
    count(id) as transaction_count,
    sum(amount) as total_amount,
    sum(amount) - lag(sum(amount)) over (order by SUBSTRING(transaction_date, 1, 7)) as mom_delta
FROM transactions 
group by SUBSTRING(transaction_date, 1, 7)
order by SUBSTRING(transaction_date, 1, 7)
