# Question 1
-- Split the Products column into atomic values
SELECT 
  OrderID, 
  CustomerName, 
  TRIM(SPLIT_PRODUCT.value) AS Product 
FROM ProductDetail
CROSS APPLY STRING_SPLIT(Products, ',') AS SPLIT_PRODUCT;

# Question 2
-- Create Orders table (removes partial dependency)
CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerName VARCHAR(255)
);

-- Create OrderProducts table
CREATE TABLE OrderProducts (
  OrderID INT,
  Product VARCHAR(255),
  Quantity INT,
  PRIMARY KEY (OrderID, Product),
  FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Populate Orders table
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Populate OrderProducts table
INSERT INTO OrderProducts (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;