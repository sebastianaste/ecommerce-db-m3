INSERT INTO customers (customer_name, email) VALUES
('Matias Soto', 'matias.soto@email.com'),
('Camila Rojas', 'camila.rojas@email.com'),
('Sebastian Muñoz', 'sebastian.munoz@email.com'),
('Valentina Perez', 'valentina.perez@email.com'),
('Diego Contreras', 'diego.contreras@email.com'),
('Isidora Fuentes', 'isidora.fuentes@email.com'),
('Nicolas Herrera', 'nicolas.herrera@email.com'),
('Antonia Castro', 'antonia.castro@email.com');

INSERT INTO categories (category_name, category_description) VALUES
('N64 Controllers', 'Original and third-party Nintendo 64 controllers'),
('N64 Games', 'Nintendo 64 cartridge games'),
('GBA Games', 'Game Boy Advance cartridge games');

INSERT INTO products (category_id, product_name, product_description, unit_price, SKU) VALUES
(1, 'N64 OEM Controller - Gray', 'Original hardware. Minor cosmetic wear on shell.', 15000.00, 1001),
(1, 'N64 OEM Controller - Yellow', 'Original hardware. Excellent condition.', 15000.00, 1002),
(1, 'N64 HoriPAD Controller - Red', 'Enthusiast-grade hardware. Ergonomic grip. Near-mint, tight thumbstick.', 45000.00, 1003),
(1, 'N64 HoriPAD Controller - Green', 'Enthusiast-grade hardware. Ergonomic grip. Tight stick, light surface scratches.', 35000.00, 1004),
(2, 'Conker Bad Fur Day N64', 'Rare-developed adventure. Mature themes. Authentic cartridge, clean label.', 40000.00, 2001),
(2, 'Zelda Ocarina of Time N64', 'Action-adventure RPG. Gold cartridge, minor label wear.', 40000.00, 2002),
(2, 'Mischief Makers N64', '2D side-scrolling platformer. Cartridge only, tested working.', 40000.00, 2003),
(3, 'Pokemon LeafGreen GBA', 'GBA remake of Kanto region. Original internal battery tested. Label intact.', 40000.00, 3001),
(2, 'Harvest Moon 64 N64', 'Agricultural simulation RPG. High-collectible. Clean contacts, saves functional.', 40000.00, 2004),
(2, 'Diddy Kong Racing 64 N64', 'Multi-vehicle racing title. Adventure Mode supported. Cartridge shows shelf wear.', 40000.00, 2005),
(3, 'Pokemon Sapphire GBA', 'Third-generation entry. Hoenn region. Original translucent shell, intact label.', 40000.00, 3002),
(3, 'Pokemon FireRed GBA', 'Gen 1 remake on GBA. Updated visuals. Authentic Nintendo PCB, verified working.', 40000.00, 3003),
(2, 'Banjo-Tooie N64', 'Banjo-Kazooie sequel. Expanded world maps. Excellent cartridge and label condition.', 40000.00, 2006);

INSERT INTO inventory (product_id, quantity, last_update) VALUES
(1, 68, DEFAULT),
(2, 30, DEFAULT),
(3, 52, DEFAULT),
(4, 25, DEFAULT),
(5, 31, DEFAULT),
(6, 64, DEFAULT),
(7, 56, DEFAULT),
(8, 47, DEFAULT),
(9, 42, DEFAULT),
(10, 59, DEFAULT),
(11, 23, DEFAULT),
(12, 35, DEFAULT),
(13, 0, DEFAULT);

INSERT INTO orders (customer_id, order_date, total_price) VALUES
(1, '2025-01-10', 55000.00),
(2, '2025-01-15', 80000.00),
(3, '2025-02-01', 80000.00),
(4, '2025-02-14', 130000.00),
(5, '2025-03-05', 40000.00),
(1, '2025-03-10', 80000.00),
(6, '2025-03-20', 45000.00),
(2, '2025-04-01', 40000.00),
(7, '2025-04-10', 40000.00),
(1, '2025-04-18', 35000.00),
(3, '2025-04-20', 80000.00),
(8, '2025-04-22', 40000.00);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES
(1, 6, 1, 40000.00),
(1, 1, 1, 15000.00),
(2, 5, 1, 40000.00),
(2, 8, 1, 40000.00),
(3, 7, 2, 40000.00),
(4, 11, 1, 40000.00),
(4, 7, 1, 40000.00),
(4, 4, 1, 35000.00),
(4, 2, 1, 15000.00),
(5, 9, 3, 40000.00),
(6, 6, 1, 40000.00),
(6, 2, 1, 15000.00),
(6, 1, 1, 15000.00), 
(7, 3, 1, 45000.00),
(8, 1, 1, 15000.00),
(9, 10, 1, 40000.00),
(10, 4, 10, 35000.00);
-- no product id n12 being sold (for testing payment)

INSERT INTO payment (order_id, amount, method, payment_status, paid_at) VALUES
(1, 55000.00, 'credit', 'completed', '2025-01-10 10:05:00'),
(2, 80000.00, 'debit', 'completed', '2025-01-15 11:05:00'),
(3, 80000.00, 'credit', 'completed', '2025-02-01 09:35:00'),
(4, 130000.00, 'credit', 'completed', '2026-02-14 14:05:00'),
(5, 120000.00, 'debit', 'completed', '2026-03-05 16:05:00'),
(6, 70000.00, 'credit', 'completed', '2026-03-10 10:05:00'),
(7, 45000.00, 'debit', 'completed', '2026-03-20 12:05:00'),
(8, 15000.00, 'credit', 'completed', '2026-03-01 08:05:00'),
(9, 40000.00, 'debit', 'refunded', '2026-03-10 15:05:00'),
(10, 350000.00, 'credit', 'pending', NULL)