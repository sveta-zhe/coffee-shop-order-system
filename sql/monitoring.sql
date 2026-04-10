SELECT SUM(amount) as total_revenue, COUNT(*) as orders_count
FROM payment
WHERE DATE(paid_at) = CURRENT_DATE;