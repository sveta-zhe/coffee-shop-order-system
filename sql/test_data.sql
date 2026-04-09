-- ============================================
-- Тестовые данные для проекта «Кофеин»
-- База данных: PostgreSQL
-- В тестовых данных используются упрощенные UUID для удобства чтения (1111... и др.)
-- В реальной БД они были бы сгенерированы через gen_random_uuid()
-- ============================================

-- 1. Очистка таблиц перед загрузкой тестовых данных
TRUNCATE TABLE order_item CASCADE;
TRUNCATE TABLE payment CASCADE;
TRUNCATE TABLE orders CASCADE;
TRUNCATE TABLE product CASCADE;
TRUNCATE TABLE users CASCADE;

-- 2. Пользователи (users)
INSERT INTO users (id, name, role, created_at) VALUES
  ('11111111-1111-1111-1111-111111111111', 'Анна Бариста', 'barista', NOW()),
  ('22222222-2222-2222-2222-222222222222', 'Дмитрий Управляющий', 'manager', NOW()),
  ('33333333-3333-3333-3333-333333333333', 'Екатерина Клиент', 'client', NOW());

-- 3. Продукты (напитки и добавки)
INSERT INTO product (id, name, category, price, stock, is_available) VALUES
  -- Напитки
  ('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'Латте', 'coffee', 180.00, 50, true),
  ('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'Капучино', 'coffee', 170.00, 30, true),
  ('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Эспрессо', 'coffee', 120.00, 100, true),
  ('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Раф', 'coffee', 200.00, 0, false), -- нет в наличии
  -- Добавки
  ('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Сироп карамель', 'additive', 50.00, 100, true),
  ('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Сироп ваниль', 'additive', 50.00, 100, true),
  ('gggggggg-gggg-gggg-gggg-gggggggggggg', 'Сироп лесной орех', 'additive', 60.00, 100, true),
  -- Десерты
  ('hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh', 'Круассан', 'dessert', 120.00, 20, true);

-- 4. Заказы (orders)
INSERT INTO orders (id, user_id, status, total_amount, created_at) VALUES
  ('99999999-9999-9999-9999-999999999999', '33333333-3333-3333-3333-333333333333', 'completed', 230.00, '2026-04-09 09:15:00'),
  ('88888888-8888-8888-8888-888888888888', '33333333-3333-3333-3333-333333333333', 'paid', 180.00, '2026-04-09 10:30:00'),
  ('77777777-7777-7777-7777-777777777777', '33333333-3333-3333-3333-333333333333', 'in_progress', 250.00, '2026-04-09 11:45:00');

-- 5. Позиции заказов (order_item)
INSERT INTO order_item (id, order_id, product_id, quantity, price_at_time) VALUES
  ('11111111-aaaa-bbbb-cccc-dddddddddddd', '99999999-9999-9999-9999-999999999999', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 1, 180.00),
  ('22222222-aaaa-bbbb-cccc-dddddddddddd', '99999999-9999-9999-9999-999999999999', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 1, 50.00),
  
  ('33333333-aaaa-bbbb-cccc-dddddddddddd', '88888888-8888-8888-8888-888888888888', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 1, 170.00),
  
  ('44444444-aaaa-bbbb-cccc-dddddddddddd', '77777777-7777-7777-7777-777777777777', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 1, 180.00),
  ('55555555-aaaa-bbbb-cccc-dddddddddddd', '77777777-7777-7777-7777-777777777777', 'ffffffff-ffff-ffff-ffff-ffffffffffff', 1, 50.00),
  ('66666666-aaaa-bbbb-cccc-dddddddddddd', '77777777-7777-7777-7777-777777777777', 'hhhhhhhh-hhhh-hhhh-hhhh-hhhhhhhhhhhh', 1, 120.00);

-- 6. Платежи (payment)
INSERT INTO payment (id, order_id, amount, method, status, paid_at) VALUES
  ('11111111-1111-1111-1111-999999999999', '99999999-9999-9999-9999-999999999999', 230.00, 'card', 'success', '2026-04-09 09:16:00'),
  ('22222222-2222-2222-2222-888888888888', '88888888-8888-8888-8888-888888888888', 180.00, 'online', 'success', '2026-04-09 10:31:00');

-- ============================================
-- Проверочные запросы (для тестирования)
-- ============================================

-- 1. Все заказы с суммой
SELECT o.id, o.status, o.total_amount, u.name 
FROM orders o
JOIN users u ON o.user_id = u.id;

-- 2. Детали заказа с продуктами
SELECT o.id, p.name, oi.quantity, oi.price_at_time
FROM order_item oi
JOIN orders o ON oi.order_id = o.id
JOIN product p ON oi.product_id = p.id
WHERE o.id = '99999999-9999-9999-9999-999999999999';

-- 3. Выручка за сегодня
SELECT SUM(amount) as total_revenue, COUNT(*) as orders_count
FROM payment
WHERE DATE(paid_at) = CURRENT_DATE;