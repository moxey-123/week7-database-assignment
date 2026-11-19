
-- =========================================
-- PLP WEEK 7: DATABASE DESIGN AND NORMALIZATION
-- =========================================

-- QUESTION 1: ACHIEVING FIRST NORMAL FORM (1NF)

CREATE DATABASE IF NOT EXISTS week7_normalization;
USE week7_normalization;

-- Create a normalized ProductDetail table
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    PRIMARY KEY (OrderID, Product)
);

-- Insert one product per row
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Display 1NF results
SELECT * FROM ProductDetail_1NF;


-- =========================================
-- QUESTION 2: ACHIEVING SECOND NORMAL FORM (2NF)
-- =========================================

-- Partial dependency:
-- CustomerName depends only on OrderID,
-- not on the complete composite key (OrderID, Product).

-- Create Orders table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table
CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert order information
INSERT INTO Orders (OrderID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert order items
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Display 2NF results
SELECT * FROM Orders;

SELECT * FROM OrderItems;

-- Display combined order information
SELECT
    Orders.OrderID,
    Orders.CustomerName,
    OrderItems.Product,
    OrderItems.Quantity
FROM Orders
JOIN OrderItems
ON Orders.OrderID = OrderItems.OrderID;
