USE mydb;

-- 1

SELECT od.*, (SELECT o.customer_id FROM orders AS o WHERE od.order_id=o.id) AS customer_id_new
FROM order_details AS od;

-- 2

SELECT od.*
FROM order_details AS od
WHERE od.order_id in (SELECT o.id FROM orders AS o WHERE o.shipper_id=3);

-- 3

SELECT order_id, AVG(quantity)
FROM (SELECT * FROM order_details WHERE quantity > 10) AS od
GROUP BY od.order_id;

-- 4

WITH temp AS (SELECT * FROM order_details WHERE quantity > 10)
SELECT AVG(od.quantity)
FROM temp AS od
GROUP BY od.order_id;

-- 5 

DROP FUNCTION IF EXISTS divide_num;
DELIMITER //
CREATE FUNCTION divide_num(num1 FLOAT, num2 FLOAT) RETURNS FLOAT
NO SQL
DETERMINISTIC
BEGIN
	IF num2 = 0 THEN
		RETURN NULL;
	ELSE 
		 RETURN num1 / num2;
	END IF;
END //
DELIMITER ;

-- use function
SELECT quantity, divide_num(quantity, 3) AS divided_value
FROM order_details LIMIT 15;
