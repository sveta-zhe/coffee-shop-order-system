# Метрики и мониторинг

## Технические метрики (Prometheus)
- `http_requests_total` — общее количество запросов к API
- `http_request_duration_seconds` — время ответа API
- `payment_gateway_status` — доступность платежного шлюза (0/1)

## Бизнес-метрики (PostgreSQL)
- `revenue_today` — выручка за сегодня
- `orders_per_hour` — количество заказов по часам
- `top_products` — топ-3 популярных напитка

## Дашборд Grafana
- Адрес: http://localhost:3000
- Данные: Prometheus (технические метрики) + PostgreSQL (бизнес-метрики)