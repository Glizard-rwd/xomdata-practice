-- Xom Data · Heavy shipments
-- Problem: https://xomdata.com/practice/easy-where-025
-- Solved: 2026-10-28

select waybill_code, weight_kg, shipping_fee from shipments where weight_kg > 3 ORDER BY weight_kg desc
