-- busqueda por nombre del producto
SELECT product_name,product_description,unit_price,SKU FROM products WHERE (product_name) LIKE ('%horipad%');
-- busqueda por categoria
SELECT product_name,product_description,unit_price,SKU FROM products WHERE category_id  IN ( SELECT category_id FROM categories WHERE category_name = 'N64 Controllers'); 

-- busqueda por nombre del producto con stock 
SELECT product_name, product_description, unit_price, SKU, i.quantity FROM products p JOIN inventory i ON i.product_id = p.product_id WHERE product_name LIKE '%zelda%';
-- busqueda por categoria con stock
SELECT product_name,product_description,unit_price,SKU, i.quantity FROM products p JOIN inventory i ON i.product_id = p.product_id WHERE category_id  IN ( SELECT category_id FROM categories WHERE category_name = 'N64 Controllers'); 

-- presenta todo el stock de la tienda
SELECT product_name,product_description,unit_price,SKU, i.quantity FROM products p JOIN inventory i ON i.product_id = p.product_id;

-- top N ventas por monto
SELECT p.product_name, SUM(od.quantity) AS total_quantity FROM order_details od JOIN products p ON od.product_id = p.product_id  GROUP BY p.product_name ORDER BY total_quantity DESC LIMIT 7;

-- no registran ventas
SELECT p.product_name, product_description, p.unit_price FROM products p LEFT JOIN order_details od on p.product_id = od.product_id WHERE od.quantity IS NULL;

-- clientes frecuentes (3 o mas se considera cliente frecuente)
SELECT  c.customer_name, c.email, COUNT(o.order_id) AS total_orders, SUM(o.total_price) AS total_spent
FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN payment p ON o.order_id = p.order_id WHERE p.payment_status != 'cancelled' 
GROUP BY c.customer_id, c.customer_name, c.email HAVING COUNT(o.order_id) >= 3 					
ORDER BY total_orders DESC;

-- top N clientes con mas ventas
SELECT  c.customer_name, c.email, COUNT(o.order_id) AS total_orders, SUM(o.total_price) AS total_spent
FROM customers c JOIN orders o ON c.customer_id = o.customer_id JOIN payment p ON o.order_id = p.order_id WHERE p.payment_status != 'cancelled' 
GROUP BY c.customer_id, c.customer_name, c.email ORDER BY total_orders DESC LIMIT 5;

-- analisis de ventas por categoria por distintos meses incluyendo cantidad de ordenes, unidades y total revenue
SELECT
    months.month,
    c.category_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(od.quantity * (o.order_id IS NOT NULL)) AS total_units,
    SUM(od.quantity * od.unit_price * (o.order_id IS NOT NULL)) AS total_revenue
FROM (
    SELECT DISTINCT DATE_FORMAT(order_date, '%Y-%m') AS month
    FROM orders
) months
CROSS JOIN categories c
LEFT JOIN products p ON p.category_id = c.category_id
LEFT JOIN order_details od ON od.product_id = p.product_id
LEFT JOIN orders o ON od.order_id = o.order_id
    AND DATE_FORMAT(o.order_date, '%Y-%m') = months.month
GROUP BY months.month, c.category_name
ORDER BY months.month, c.category_name;


DELIMITER $$

CREATE PROCEDURE create_order(IN p_customer_id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO orders (customer_id, order_date, total_price)
    VALUES (p_customer_id, CURDATE(), 0);

    SET @order_id = LAST_INSERT_ID();

	-- ejemplo de una orden
    INSERT INTO order_details (order_id, product_id, quantity, unit_price)
    VALUES
        (@order_id, 1, 2, 15000.00),
        (@order_id, 6, 1, 40000.00),
        (@order_id, 8, 3, 40000.00);

    UPDATE orders
    SET total_price = (
        SELECT SUM(quantity * unit_price)
        FROM order_details
        WHERE order_id = @order_id
    )
    WHERE order_id = @order_id;

    UPDATE inventory i
    JOIN order_details od ON i.product_id = od.product_id
    SET i.quantity = i.quantity - od.quantity
    WHERE od.order_id = @order_id;

    COMMIT;
END$$

DELIMITER ;

CALL create_order(1); -- se llama procedure de la orden anteriormente creada (se hace con procedures para asegurar que haga rollback actualizando el inventario,
-- ya que en rutina begin-commit un error no puede tener una sqlhandler facilmente en este caso (segun averiguado))



