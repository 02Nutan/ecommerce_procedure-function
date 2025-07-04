use ecommerce_db;

-- Create Procedure
-- A procedure to get all orders of a customer by their ID
DELIMITER $$

CREATE PROCEDURE GetOrdersByCustomer(
    IN cust_id INT
    )
BEGIN
    SELECT o.order_id, o.order_date, o.status
    FROM Orders o
    WHERE o.customer_id = cust_id;
END$$

DELIMITER ;

-- call the procedure
CALL GetOrdersByCustomer(3);

-- List products by category
DELIMITER $$

CREATE PROCEDURE GetProductsByCategory(
    IN cat_id INT
)
BEGIN
    SELECT product_id, name, price
    FROM Product
    WHERE category_id = cat_id;
END$$

DELIMITER ;

-- call the procedure
CALL GetProductsByCategory(1);



-- Create Funtion
-- A function to calculate total payment amount for an order
DELIMITER $$

CREATE FUNCTION GetOrderTotalPayment(ord_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    SELECT SUM(amount) INTO total
    FROM Payment
    WHERE order_id = ord_id;
    RETURN IFNULL(total, 0.00);
END$$

DELIMITER ;

-- call the funtion
SELECT GetOrderTotalPayment(1) AS total_payment;

--  Count orders for a customer
DELIMITER $$

CREATE FUNCTION CountCustomerOrders(cust_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE order_count INT;
    SELECT COUNT(*) INTO order_count FROM Orders WHERE customer_id = cust_id;
    RETURN order_count;
END$$

DELIMITER ;

-- call the function
SELECT name, CountCustomerOrders(customer_id) AS order_count
FROM Customer;






