-- ===================================================
-- SHOPSPHERE CAPSTONE PROJECT
-- MODULE 1 : DATABASE CREATION
-- ===================================================

-- TO Create a database named:
CREATE DATABASE shopsphere_db;

USE shopsphere_db;

-- To check that wether the database is created or not 
SHOW DATABASES;

-- ===================================================
-- MODULE 2 : USERS TABLE
-- ===================================================
-- To Create the Users table in shopsphere_db 
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    pincode VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- To verify that table is created or not
SHOW TABLES;

-- To check the table STRUCTURE
DESC Users ;

-- ===================================================
-- MODULE 3 : CATEGORIES TABLE
-- ===================================================

-- To create the CATEGORIES table 
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
	description VARCHAR(255),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- To verify that table is created or not
SHOW TABLES;

-- STRUCTURE check
DESC Categories;

-- ===================================================
-- MODULE 4 : PRODUCTS TABLE
-- ===================================================

CREATE TABLE Products (
     product_id INT AUTO_INCREMENT PRIMARY KEY,
	 category_id INT NOT NULL,
	 product_name VARCHAR(150) NOT NULL,
     description VARCHAR(500),
	 brand VARCHAR(100),
     price DECIMAL(10,2) NOT NULL CHECK (price > 0),
     stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
	 created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     CONSTRAINT fk_products_category
     FOREIGN KEY (category_id)
     REFERENCES Categories(category_id)
);
-- To verify that table is created or not
SHOW TABLES;

-- To check the table STRUCTURE
DESC products ;

-- ===================================================
-- MODULE 5 : CART TABLE
-- ===================================================

CREATE TABLE Cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
	quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
	added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_cart_user
    FOREIGN KEY (user_id)
    REFERENCES Users(user_id),
    
    CONSTRAINT fk_cart_product
    FOREIGN KEY (product_id)
    REFERENCES Products(product_id)
);
-- To verify that table is created or not
SHOW TABLES;

-- To verify structure
DESC Cart ;

-- ===================================================
-- MODULE 6 : ORDERS TABLE
-- ===================================================

CREATE TABLE Orders (
   order_id INT AUTO_INCREMENT PRIMARY KEY,
   user_id INT NOT NULL,
   order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount >= 0),
   order_status VARCHAR(30) NOT NULL DEFAULT 'Placed',
   shipping_address VARCHAR(255) NOT NULL,
    CONSTRAINT fk_orders_user
    FOREIGN KEY (user_id)
    REFERENCES Users(user_id)
);
-- To verify that table is created or not
SHOW TABLES;
-- To check Structure
DESC Orders ;

-- ===================================================
-- MODULE 7 : ORDER_ITEMS TABLE
-- ===================================================

CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
	product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0), 
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal >= 0),
    CONSTRAINT fk_orderitems_order
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id),

    CONSTRAINT fk_orderitems_product
    FOREIGN KEY (product_id)
    REFERENCES Products(product_id)
);
-- To verify that table is created or not
SHOW TABLES;
-- To check Structure
DESC Order_Items ;

-- ===================================================
-- MODULE 8 : PAYMENTS TABLE
-- ===================================================

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method ENUM('Credit Card','Debit Card','UPI','Net Banking','Cash on Delivery') NOT NULL,
    payment_status ENUM('Pending','Completed','Failed') DEFAULT 'Pending',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    amount DECIMAL(10,2) NOT NULL CHECK(amount > 0),
    transaction_id VARCHAR(100) UNIQUE,
    CONSTRAINT fk_payments_orders
    FOREIGN KEY(order_id)
    REFERENCES Orders(order_id)
);
-- To verify that table is created or not
SHOW TABLES;
-- To check Structure
DESC Payments ;

-- ===================================================
-- MODULE 9 : REVIEWS TABLE
-- ===================================================

CREATE TABLE Reviews (
      review_id INT AUTO_INCREMENT PRIMARY KEY,
      user_id INT NOT NULL, 
      product_id INT NOT NULL,
      rating INT NOT NULL CHECK(rating BETWEEN 1 AND 5),
      review_text VARCHAR(500), 
      review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      CONSTRAINT fk_reviews_users
      FOREIGN KEY(user_id)
      REFERENCES Users(user_id),

      CONSTRAINT fk_reviews_products
      FOREIGN KEY(product_id)
      REFERENCES Products(product_id)
);
-- To verify that table is created or not
SHOW TABLES;
-- To check Structure
DESC Reviews ;

-- ===================================================
-- MODULE 10 : WISHLIST TABLE
-- ===================================================

CREATE TABLE Wishlist (
  wishlist_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  product_id INT NOT NULL,
  added_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_wishlist_users
    FOREIGN KEY(user_id)
    REFERENCES Users(user_id),
  CONSTRAINT fk_wishlist_products
    FOREIGN KEY(product_id)
    REFERENCES Products(product_id)
);
-- To verify that table is created or not
SHOW TABLES;
-- To check Structure
DESC Wishlist ;

-- ===================================================
-- MODULE 11 : AUDIT LOGS TABLE
-- ===================================================

CREATE TABLE Audit_Logs (
      log_id INT AUTO_INCREMENT PRIMARY KEY,
      action_performed VARCHAR(100) NOT NULL,
      table_name VARCHAR(100) NOT NULL,
      description VARCHAR(255),
      action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- To verify that table is created or not
SHOW TABLES;
-- To check Structure
DESC Audit_logs ;

-- ==========================================
-- INSERT DATA INTO CATEGORIES
-- ==========================================
-- To insert the data into Categories table
INSERT INTO Categories (category_name, description) VALUES
('Electronics','Electronic gadgets and accessories'),
('Fashion','Clothing and Footwear'),
('Home Appliances','Kitchen and Home Essentials'),
('Books','Educational and Story Books'),
('Sports','Sports Equipment');

-- for checking after our insertion the Categories
SELECT * FROM Categories;

-- To insert the value in USERS in USERS table
INSERT INTO Users
(first_name,last_name,email,phone,password,address,city,state,pincode)
VALUES
('Rahul','Sharma','rahul@gmail.com','9876500001','rahul123','MG Road','Hyderabad','Telangana','500001'),
('Priya','Reddy','priya@gmail.com','9876500002','priya123','Banjara Hills','Hyderabad','Telangana','500034'),
('Arjun','Kumar','arjun@gmail.com','9876500003','arjun123','MVP Colony','Visakhapatnam','Andhra Pradesh','530017'),
('Sneha','Patel','sneha@gmail.com','9876500004','sneha123','Governorpet','Vijayawada','Andhra Pradesh','520002'),
('Vikram','Singh','vikram@gmail.com','9876500005','vikram123','Madhapur','Hyderabad','Telangana','500081'),
('Pooja','Naidu','pooja@gmail.com','9876500006','pooja123','Brodipet','Guntur','Andhra Pradesh','522002'),
('Kiran','Rao','kiran@gmail.com','9876500007','kiran123','Ashok Nagar','Chennai','Tamil Nadu','600083'),
('Anjali','Verma','anjali@gmail.com','9876500008','anjali123','Sector 18','Noida','Uttar Pradesh','201301'),
('Ramesh','Yadav','ramesh@gmail.com','9876500009','ramesh123','Salt Lake','Kolkata','West Bengal','700091'),
('Divya','Kapoor','divya@gmail.com','9876500010','divya123','Indiranagar','Bangalore','Karnataka','560038'),
('Suresh','Reddy','suresh@gmail.com','9876500011','suresh123','Lakdikapul','Hyderabad','Telangana','500004'),
('Keerthi','Sai','keerthi@gmail.com','9876500012','keerthi123','Auto Nagar','Vijayawada','Andhra Pradesh','520007'),
('Mahesh','Babu','mahesh@gmail.com','9876500013','mahesh123','Ring Road','Guntur','Andhra Pradesh','522006'),
('Nithya','Sri','nithya@gmail.com','9876500014','nithya123','Anna Nagar','Chennai','Tamil Nadu','600040'),
('Harsha','Varma','harsha@gmail.com','9876500015','harsha123','KPHB','Hyderabad','Telangana','500072'),
('Sandeep','Kumar','sandeep@gmail.com','9876500016','sandeep123','Miyapur','Hyderabad','Telangana','500049'),
('Bhavya','Rani','bhavya@gmail.com','9876500017','bhavya123','Patamata','Vijayawada','Andhra Pradesh','520010'),
('Teja','Krishna','teja@gmail.com','9876500018','teja123','Arundalpet','Guntur','Andhra Pradesh','522002'),
('Akash','Raj','akash@gmail.com','9876500019','akash123','Whitefield','Bangalore','Karnataka','560066'),
('Deepika','Paul','deepika@gmail.com','9876500020','deepika123','Kukatpally','Hyderabad','Telangana','500085');

-- To count the value of USERS in USERS table
SELECT COUNT(*) AS Total_Users FROM Users;

SELECT * FROM Categories;

INSERT INTO Products
(category_id, product_name, description, brand, price, stock)
VALUES

(1,'iPhone 16','Apple Smartphone','Apple',89999.00,25),
(1,'Samsung Galaxy S25','Android Smartphone','Samsung',79999.00,20),
(1,'HP Pavilion Laptop','15.6 inch Laptop','HP',65000.00,15),
(1,'Dell Inspiron Laptop','Business Laptop','Dell',62000.00,18),
(1,'Sony Bravia TV','55 inch Smart TV','Sony',75000.00,10),
(1,'Boat Earbuds','Wireless Earbuds','Boat',2999.00,50),
(1,'Canon DSLR Camera','Professional Camera','Canon',55000.00,8),
(1,'Apple Watch','Smart Watch','Apple',45000.00,12),
(1,'Lenovo Tablet','Android Tablet','Lenovo',28000.00,16),
(1,'JBL Bluetooth Speaker','Portable Speaker','JBL',4999.00,30),
(2,'Nike Shoes','Running Shoes','Nike',4999.00,35),
(2,'Adidas T-Shirt','Sports T-Shirt','Adidas',1499.00,40),
(2,'Levis Jeans','Blue Denim Jeans','Levis',2999.00,30),
(2,'Puma Jacket','Winter Jacket','Puma',3999.00,20),
(2,'Titan Watch','Analog Watch','Titan',5999.00,18),
(2,'Woodland Shoes','Leather Shoes','Woodland',3499.00,25),
(3,'LG Refrigerator','Double Door Refrigerator','LG',42000.00,10),
(3,'Whirlpool Washing Machine','Fully Automatic','Whirlpool',28000.00,12),
(3,'Prestige Pressure Cooker','5 Litre Cooker','Prestige',2200.00,40),
(3,'Philips Mixer Grinder','750W Mixer','Philips',3500.00,25),
(3,'Bajaj Ceiling Fan','1200mm Fan','Bajaj',2800.00,30),
(3,'Havells Iron Box','Steam Iron','Havells',1800.00,20),
(4,'Java Programming','Programming Book','Oracle Press',799.00,50),
(4,'SQL Complete Guide','Database Book','McGraw Hill',699.00,40),
(4,'Python Basics','Programming Book','Pearson',650.00,45),
(4,'Data Structures','Computer Science','Cengage',850.00,30),
(5,'Yonex Badminton Racket','Professional Racket','Yonex',2999.00,20),
(5,'Cosco Football','Size 5 Football','Cosco',1200.00,30),
(5,'SG Cricket Bat','English Willow','SG',4500.00,15),
(5,'Nivia Volleyball','Official Volleyball','Nivia',950.00,25);

-- To verify count
SELECT COUNT(*) AS Total_Products FROM Products;
-- To check the products table
SELECT * FROM Products;

-- ===========================================
-- INSERT INTO ORDERS
-- ===========================================

INSERT INTO Orders (user_id,total_amount,order_status,shipping_address) VALUES
(1,92998.00,'Placed','MG Road, Hyderabad'),
(2,79999.00,'Delivered','Banjara Hills, Hyderabad'),
(3,65000.00,'Shipped','MVP Colony, Visakhapatnam'),
(4,4999.00,'Delivered','Governorpet, Vijayawada'),
(5,75000.00,'Placed','Madhapur, Hyderabad'),
(6,2999.00,'Delivered','Brodipet, Guntur'),
(7,55000.00,'Shipped','Ashok Nagar, Chennai'),
(8,45000.00,'Placed','Sector 18, Noida'),
(9,28000.00,'Delivered','Salt Lake, Kolkata'),
(10,4999.00,'Delivered','Indiranagar, Bangalore'),
(11,62000.00,'Shipped','Lakdikapul, Hyderabad'),
(12,3999.00,'Placed','Auto Nagar, Vijayawada'),
(13,42000.00,'Delivered','Ring Road, Guntur'),
(14,3500.00,'Delivered','Anna Nagar, Chennai'),
(15,2800.00,'Placed','KPHB, Hyderabad'),
(16,799.00,'Delivered','Miyapur, Hyderabad'),
(17,699.00,'Shipped','Patamata, Vijayawada'),
(18,2999.00,'Delivered','Arundalpet, Guntur'),
(19,1200.00,'Placed','Whitefield, Bangalore'),
(20,4500.00,'Delivered','Kukatpally, Hyderabad');

-- To verify count
SELECT COUNT(*) FROM Orders;

INSERT INTO Order_Items (order_id,product_id,quantity,price,subtotal) VALUES
(1,1,1,89999.00,89999.00),
(1,6,1,2999.00,2999.00),
(2,2,1,79999.00,79999.00),
(3,3,1,65000.00,65000.00),
(4,11,1,4999.00,4999.00),
(5,5,1,75000.00,75000.00),
(6,6,1,2999.00,2999.00),
(7,7,1,55000.00,55000.00),
(8,8,1,45000.00,45000.00),
(9,9,1,28000.00,28000.00),
(10,10,1,4999.00,4999.00),
(11,4,1,62000.00,62000.00),
(12,14,1,3999.00,3999.00),
(13,17,1,42000.00,42000.00),
(14,20,1,3500.00,3500.00),
(15,21,1,2800.00,2800.00),
(16,23,1,799.00,799.00),
(17,24,1,699.00,699.00),
(18,27,1,2999.00,2999.00),
(19,28,1,1200.00,1200.00),
(20,29,1,4500.00,4500.00);

-- TO verify count of order_items
SELECT COUNT(*) FROM Order_Items;

-- TO complete the remaining order_items we need to insert 29 more already we insert 21 then
INSERT INTO Order_Items (order_id, product_id, quantity, price, subtotal) VALUES
(2,11,2,4999.00,9998.00),
(3,12,2,1499.00,2998.00),
(4,13,1,2999.00,2999.00),
(5,14,1,3999.00,3999.00),
(6,15,1,5999.00,5999.00),
(7,16,1,3499.00,3499.00),
(8,17,1,42000.00,42000.00),
(9,18,1,28000.00,28000.00),
(10,19,2,2200.00,4400.00),
(11,20,1,3500.00,3500.00),
(12,21,2,2800.00,5600.00),
(13,22,1,1800.00,1800.00),
(14,23,2,799.00,1598.00),
(15,24,1,699.00,699.00),
(16,25,2,650.00,1300.00),
(17,26,1,850.00,850.00),
(18,27,1,2999.00,2999.00),
(19,28,2,1200.00,2400.00),
(20,30,1,950.00,950.00),
(3,5,1,75000.00,75000.00),
(5,1,1,89999.00,89999.00),
(6,3,1,65000.00,65000.00),
(7,8,1,45000.00,45000.00),
(8,10,2,4999.00,9998.00),
(9,6,1,2999.00,2999.00),
(10,4,1,62000.00,62000.00),
(11,2,1,79999.00,79999.00),
(12,18,1,28000.00,28000.00),
(13,29,1,4500.00,4500.00);

-- TO verify the total count of order-items
SELECT COUNT(*) AS Total_Order_Items
FROM Order_Items;

INSERT INTO Payments
(order_id,payment_method,payment_status,amount,transaction_id)
VALUES
(1,'UPI','Completed',92998.00,'TXN1001'),
(2,'Credit Card','Completed',79999.00,'TXN1002'),
(3,'Debit Card','Completed',65000.00,'TXN1003'),
(4,'UPI','Completed',4999.00,'TXN1004'),
(5,'Net Banking','Pending',75000.00,'TXN1005'),
(6,'Cash on Delivery','Completed',2999.00,'TXN1006'),
(7,'Credit Card','Completed',55000.00,'TXN1007'),
(8,'UPI','Pending',45000.00,'TXN1008'),
(9,'Debit Card','Completed',28000.00,'TXN1009'),
(10,'UPI','Completed',4999.00,'TXN1010'),
(11,'Credit Card','Completed',62000.00,'TXN1011'),
(12,'Cash on Delivery','Pending',3999.00,'TXN1012'),
(13,'UPI','Completed',42000.00,'TXN1013'),
(14,'Debit Card','Completed',3500.00,'TXN1014'),
(15,'Credit Card','Pending',2800.00,'TXN1015'),
(16,'UPI','Completed',799.00,'TXN1016'),
(17,'Net Banking','Completed',699.00,'TXN1017'),
(18,'UPI','Completed',2999.00,'TXN1018'),
(19,'Cash on Delivery','Pending',1200.00,'TXN1019'),
(20,'Credit Card','Completed',4500.00,'TXN1020');

-- To count the payments
SELECT COUNT(*) FROM Payments;

-- To insert reviews
INSERT INTO Reviews (user_id, product_id, rating, review_text) VALUES
(1,1,5,'Excellent iPhone with amazing camera'),
(2,2,4,'Good Samsung phone'),
(3,3,5,'Very good laptop'),
(4,11,4,'Comfortable running shoes'),
(5,5,5,'Excellent TV'),
(6,6,4,'Good sound quality'),
(7,7,5,'Professional camera'),
(8,8,5,'Very useful smartwatch'),
(9,9,4,'Tablet works smoothly'),
(10,10,5,'Speaker quality is excellent'),
(11,12,4,'Nice T-shirt'),
(12,13,5,'Perfect fitting jeans'),
(13,14,4,'Warm jacket'),
(14,15,5,'Premium watch'),
(15,17,5,'Large refrigerator'),
(16,18,4,'Washing machine is good'),
(17,19,5,'Pressure cooker quality is excellent'),
(18,20,4,'Mixer grinder is powerful'),
(19,21,5,'Ceiling fan works well'),
(20,22,4,'Iron box heats quickly'),
(1,23,5,'Very useful Java book'),
(2,24,5,'Best SQL book'),
(3,25,4,'Python basics explained well'),
(4,27,5,'Badminton racket is awesome'),
(5,29,4,'Cricket bat quality is good');

-- for counting the reviews

-- TO INSERT WISHLIST (20 Records)
INSERT INTO Wishlist (user_id, product_id) VALUES
(1,2),
(2,3),
(3,1),
(4,5),
(5,6),
(6,8),
(7,10),
(8,12),
(9,14),
(10,16),
(11,18),
(12,20),
(13,22),
(14,24),
(15,26),
(16,28),
(17,30),
(18,4),
(19,7),
(20,9);

-- To check the count of Wishlist is
SELECT COUNT(*) FROM Wishlist ;

-- TO INSERT CART (20 Records)
INSERT INTO Cart (user_id, product_id, quantity) VALUES
(1,3,1),
(2,5,2),
(3,7,1),
(4,9,1),
(5,11,2),
(6,13,1),
(7,15,1),
(8,17,1),
(9,19,2),
(10,21,1),
(11,23,1),
(12,25,2),
(13,27,1),
(14,29,1),
(15,30,2),
(16,2,1),
(17,4,1),
(18,6,2),
(19,8,1),
(20,10,1);

-- To check the count of CART is
SELECT COUNT(*) FROM Cart ;

USE shopsphere_db;

-- To display all the users
SELECT * FROM users;

-- To display all products from with the category name
SELECT
    p.product_name,
    c.category_name,
    p.brand,
    p.price,
    p.stock
FROM products p
JOIN categories c
ON p.category_id = c.category_id;

-- To display the all deliverd orders
SELECT *
FROM orders
WHERE order_status='Delivered';

-- To find the products that are costing more than 50000
SELECT product_name, brand, price
FROM products
WHERE price > 50000;

-- for the count of total no of products in each category
SELECT
c.category_name,
COUNT(p.product_id) AS Total_Products
FROM categories c
LEFT JOIN products p
ON c.category_id=p.category_id
GROUP BY c.category_name;

-- To find the most expensive Products
SELECT product_name,price
FROM products
ORDER BY price DESC
LIMIT 1;

-- cheapest product price
SELECT product_name,price
FROM products
ORDER BY price ASC
LIMIT 1;

-- Average products price
SELECT AVG(price) AS Average_Price
FROM products;

-- Total stock available
SELECT SUM(stock) AS Total_Stock
FROM products;

-- Number of orders placed by each user
SELECT
u.first_name,
u.last_name,
COUNT(o.order_id) AS Total_Orders
FROM users u
LEFT JOIN orders o
ON u.user_id=o.user_id
GROUP BY u.user_id,u.first_name,u.last_name;

-- Total revenue
SELECT SUM(total_amount) AS Total_Revenue
FROM orders;

-- To find the COMPLETED payments
SELECT *
FROM payments
WHERE payment_status='Completed';

-- to find the pending payments
SELECT *
FROM payments
WHERE payment_status='Pending';

-- To find the top 5 priceing products
SELECT product_name,price
FROM products
ORDER BY price DESC
LIMIT 5;

-- products that are currently out of stock
SELECT *
FROM products
WHERE stock=0;

-- To insert a  new user into USERS
INSERT INTO Users
(first_name,last_name,email,phone,password,address,city,state,pincode)
VALUES
('Ravi','Teja','raviteja@gmail.com','9876500021','ravi123',
'KPHB','Hyderabad','Telangana','500072');

-- To insert the categories
INSERT INTO categories
(category_name,description)
VALUES
('Beauty','Beauty and Skin Care Products');

-- To insert into products
INSERT INTO products
(category_id,product_name,description,brand,price,stock)
VALUES
(6,'Lakme Face Wash','Skin Care Product','Lakme',299.00,100);

-- to verify the insertions
SELECT * FROM users WHERE email='raviteja@gmail.com';

-- to verify the insertions
SELECT * FROM categories WHERE category_name='Beauty';

-- to verify the insertions
SELECT * FROM products WHERE product_name='Lakme Face Wash';

-- To read
SELECT * FROM users;

-- To read
SELECT * FROM products;

-- To read that the produts above 50000
SELECT *
FROM products
WHERE price>5000;

-- TO display delivered orders
SELECT *
FROM orders
WHERE order_status='Delivered';

-- To display electronic products
SELECT *
FROM products
WHERE category_id=1;

-- ===================================================
--   UPDATE
-- ===================================================

-- To update product price
UPDATE products
SET price=92000
WHERE product_id=1;

-- To update STOCK
UPDATE products
SET stock=40
WHERE product_id=5;

-- To update user CITY
UPDATE users
SET city='Bangalore'
WHERE user_id=2;

-- To update order status
UPDATE orders
SET order_status='Delivered'
WHERE order_id=5;

-- To update Payment status
UPDATE payments
SET payment_status='Completed'
WHERE payment_id=5;

-- ===================================================
--   DELETE OPERATIONS
-- ===================================================

SELECT * 
FROM products
WHERE product_name='Lakme Face Wash';

-- to delete product
DELETE FROM products
WHERE product_name='Lakme Face Wash';

-- To delete products
DELETE FROM products
WHERE product_id = 31;

-- to delete users 
DELETE FROM users
WHERE email='raviteja@gmail.com';

-- To delete category
DELETE FROM categories
WHERE category_name='Beauty';

-- To verify the delete
SELECT * FROM users WHERE email='raviteja@gmail.com';

SELECT * FROM categories WHERE category_name='Beauty';

SELECT * FROM products WHERE product_name='Lakme Face Wash';

-- TO display all the users
SELECT * FROM users;

-- ===================================================
--  JOIN OPERATIONS
-- ===================================================

-- To JOIN 1– Users and Orders (INNER JOIN)
SELECT
u.user_id,
u.first_name,
u.last_name,
o.order_id,
o.order_date,
o.total_amount
FROM users u
INNER JOIN orders o
ON u.user_id=o.user_id;

-- To JOIN 2- Display Products with Category Names
SELECT
    p.product_name,
    c.category_name,
    p.brand,
    p.price
FROM products p
INNER JOIN categories c
ON p.category_id = c.category_id;

-- To JOIN 3 – Display Orders with Payment Details
SELECT
    o.order_id,
    o.total_amount,
    p.payment_method,
    p.payment_status,
    p.transaction_id
FROM orders o
INNER JOIN payments p
ON o.order_id = p.order_id;


-- To JOIN 4 – Display Orders with Product Details
SELECT
    o.order_id,
    pr.product_name,
    oi.quantity,
    oi.price,
    oi.subtotal
FROM orders o
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products pr
ON oi.product_id = pr.product_id;

-- TO JOIN 5 – Display Users with Wishlist Products
SELECT
    u.first_name,
    u.last_name,
    pr.product_name
FROM users u
INNER JOIN wishlist w
ON u.user_id = w.user_id
INNER JOIN products pr
ON w.product_id = pr.product_id;

-- TO JOIN 6 – Display Users with Their Reviews
SELECT
    u.first_name,
    u.last_name,
    pr.product_name,
    r.rating,
    r.review_text
FROM users u
INNER JOIN reviews r
ON u.user_id = r.user_id
INNER JOIN products pr
ON r.product_id = pr.product_id;

-- To JOIN 7 – Display All Categories and Products (LEFT JOIN)
SELECT
    c.category_name,
    pr.product_name
FROM categories c
LEFT JOIN products pr
ON c.category_id = pr.category_id;

-- To JOIN 8 – Display Users, Orders and Payments
SELECT
    u.first_name,
    u.last_name,
    o.order_id,
    o.total_amount,
    p.payment_method,
    p.payment_status
FROM users u
INNER JOIN orders o
ON u.user_id = o.user_id
INNER JOIN payments p
ON o.order_id = p.order_id;

-- To JOIN 9 – Display Products with Reviews
SELECT
    pr.product_name,
    r.rating,
    r.review_text
FROM products pr
INNER JOIN reviews r
ON pr.product_id = r.product_id;

-- To JOIN 10 – Display User Orders with Ordered Products
SELECT
    u.first_name,
    u.last_name,
    o.order_id,
    pr.product_name,
    oi.quantity,
    oi.subtotal
FROM users u
INNER JOIN orders o
ON u.user_id = o.user_id
INNER JOIN order_items oi
ON o.order_id = oi.order_id
INNER JOIN products pr
ON oi.product_id = pr.product_id;

-- ===================================================
--   SUBQUERIES
-- ===================================================

-- To Subquery 1 – Find the Most Expensive Product 

SELECT product_name, price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);

-- To Subquery 2 – Find the Cheapest Product
SELECT product_name, price
FROM products
WHERE price = (
    SELECT MIN(price)
    FROM products
);

-- To Subquery 3 – Products Costing More Than the Average Price 
SELECT product_name, price
FROM products
WHERE price >
(
    SELECT AVG(price)
    FROM products
);

-- To Subquery 4 – Customers Who Have Placed Orders

SELECT first_name, last_name
FROM users
WHERE user_id IN
(
    SELECT user_id
    FROM orders
);

-- To Subquery 5 – Products Never Ordered 
SELECT product_name
FROM products
WHERE product_id NOT IN
(
    SELECT product_id
    FROM order_items
);

-- To Subquery 6 – Orders Above Average Order Amount 
SELECT order_id, total_amount
FROM orders
WHERE total_amount >
(
    SELECT AVG(total_amount)
    FROM orders
);

-- To Subquery 7 – Users Who Made Completed Payments 
SELECT first_name, last_name
FROM users
WHERE user_id IN
(
    SELECT user_id
    FROM orders
    WHERE order_id IN
    (
        SELECT order_id
        FROM payments
        WHERE payment_status='Completed'
    )
);

-- To Subquery 8 – Categories Having Products 
SELECT category_name
FROM categories
WHERE category_id IN
(
    SELECT DISTINCT category_id
    FROM products
);

-- To Subquery 9 – Product Purchased in Order 1 
SELECT product_name
FROM products
WHERE product_id IN
(
    SELECT product_id
    FROM order_items
    WHERE order_id=1
);

-- To Subquery 10 – Products with Stock Greater Than the Average Stock 
SELECT product_name, stock
FROM products
WHERE stock >
(
    SELECT AVG(stock)
    FROM products
);

-- ===================================================
--  VIEW operations
-- ===================================================

-- To View 1 – Product Details View 
CREATE VIEW Product_Details AS
SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.brand,
    p.price,
    p.stock
FROM products p
JOIN categories c
ON p.category_id = c.category_id;

-- To Execute view
SELECT * FROM Product_Details;

-- To View 2 – Customer Orders View 
CREATE VIEW Customer_Orders AS
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    o.order_status
FROM users u
JOIN orders o
ON u.user_id = o.user_id;
 
-- To execute
SELECT * FROM Customer_Orders;

-- To View 3 – Payment Details View 
CREATE VIEW Payment_Details AS
SELECT
    u.first_name,
    u.last_name,
    p.payment_method,
    p.payment_status,
    p.amount,
    p.transaction_id
FROM users u
JOIN orders o
ON u.user_id = o.user_id
JOIN payments p
ON o.order_id = p.order_id;

 -- To execute
SELECT * FROM Payment_Details;
--  To View 4 – Order Summary View 
CREATE VIEW Order_Summary AS
SELECT
    o.order_id,
    pr.product_name,
    oi.quantity,
    oi.price,
    oi.subtotal
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products pr
ON oi.product_id = pr.product_id;

-- To execute
SELECT * FROM Order_Summary;

-- To View 5 – Product Reviews View
CREATE VIEW Product_Reviews AS
SELECT
    u.first_name,
    u.last_name,
    pr.product_name,
    r.rating,
    r.review_text
FROM users u
JOIN reviews r
ON u.user_id = r.user_id
JOIN products pr
ON r.product_id = pr.product_id;

-- To execute
SELECT * FROM Product_Reviews;

-- To verify all views
SHOW FULL TABLES
WHERE Table_type = 'VIEW';

-- ===================================================
-- Stored Procedures
-- ===================================================

-- To Procedure 1 – Display All Products
DELIMITER $$
CREATE PROCEDURE GetAllProducts()
BEGIN
    SELECT * FROM products;
END $$
DELIMITER ;

-- To execute
CALL GetAllProducts();

-- To Procedure 2 – Search Product by Category 
DELIMITER $$
CREATE PROCEDURE GetProductsByCategory(IN cat_id INT)
BEGIN
    SELECT
        product_name,
        brand,
        price,
        stock
    FROM products
    WHERE category_id = cat_id;
END $$
DELIMITER ;

--  To execute
CALL GetProductsByCategory(1);

-- to Procedure 3 – Display Orders of a User
DELIMITER $$
CREATE PROCEDURE GetOrdersByUser(IN uid INT)
BEGIN
    SELECT *
    FROM orders
    WHERE user_id = uid;
END $$
DELIMITER ;

-- to Execute
CALL GetOrdersByUser(5);

-- to Procedure 4 – Display Products Above Given Price
DELIMITER $$
CREATE PROCEDURE GetProductsAbovePrice(IN amount DECIMAL(10,2))
BEGIN
    SELECT
        product_name,
        price
    FROM products
    WHERE price > amount;
END $$
DELIMITER ;
-- to Execute
CALL GetProductsAbovePrice(50000);

-- To Procedure 5 – Count Total Orders
DELIMITER $$
CREATE PROCEDURE TotalOrders()
BEGIN
    SELECT COUNT(*) AS Total_Orders
    FROM orders;
END $$
DELIMITER ;

-- to Execute
CALL TotalOrders();

-- To Verify Procedures
SHOW PROCEDURE STATUS
WHERE Db='shopsphere_db';

-- ===================================================
--  TRANSACTIONS
-- ===================================================

-- To Transaction 1 – COMMIT , Purpose: Permanently save changes. 
START TRANSACTION;

UPDATE products
SET stock = stock - 2
WHERE product_id = 1;

COMMIT;

-- To verify
SELECT product_id, product_name, stock
FROM products
WHERE product_id = 1;

--  To Transaction 2 – ROLLBACK, Purpose: Undo changes before committing.
START TRANSACTION;

UPDATE products
SET stock = stock - 5
WHERE product_id = 2;

ROLLBACK;

-- To verify 
SELECT product_id, product_name, stock
FROM products
WHERE product_id = 2;

-- To Transaction 3 – SAVEPOINT,Purpose: Create a checkpoint inside a transaction.

START TRANSACTION;
UPDATE products
SET stock = stock - 2
WHERE product_id = 3;
SAVEPOINT SP1;
UPDATE products
SET stock = stock - 3
WHERE product_id = 4;
ROLLBACK TO SP1;
COMMIT;

-- Result : Product 3 stock is updated, Product 4 stock returns to its original value.

-- To the Transaction 4 – Multiple Updates with COMMIT
START TRANSACTION;

UPDATE products
SET stock = stock + 10
WHERE product_id = 5;

UPDATE products
SET stock = stock + 5
WHERE product_id = 6;

COMMIT;

-- To the Verification
SELECT product_id, product_name, stock
FROM products
WHERE product_id IN (5,6);

-- For overall verification
SELECT @@autocommit;

-- ===================================================
-- STRING FUNCTIONS
-- ===================================================

-- To the String Function 1 – Display Full Name Purpose: Combine first name and last name.
SELECT
CONCAT(first_name,' ',last_name) AS Full_Name
FROM users;

-- To the String Function 2 – Convert Names to Uppercase
SELECT
UPPER(first_name) AS First_Name,
UPPER(last_name) AS Last_Name
FROM users;

-- To the String Function 3 – Convert Names to Lowercase
SELECT
LOWER(first_name) AS First_Name,
LOWER(last_name) AS Last_Name
FROM users;

-- To the String Function 4 – Length of Product Name
SELECT
product_name,
LENGTH(product_name) AS Name_Length
FROM products;

-- To the String Function 5 – First 5 Characters of Product Name
SELECT
product_name,
LEFT(product_name,5) AS First_Five_Characters
FROM products;

-- To the String Function 6 – Last 4 Characters of Product Name
SELECT
product_name,
RIGHT(product_name,4) AS Last_Four_Characters
FROM products;

-- To the String Function 7 – Remove Extra Spaces
SELECT
TRIM('   ShopSphere SQL Project   ') AS Trimmed_Text;

-- To the String Function 8 – Replace Product Brand Name
SELECT
product_name,
REPLACE(brand,'Apple','APPLE INC') AS Updated_Brand
FROM products;

-- To the String Function 9 – Email Username , To Extract the username before @.
SELECT
email,
SUBSTRING_INDEX(email,'@',1) AS Username
FROM users;

-- To the String Function 10 – Reverse Product Name
SELECT
product_name,
REVERSE(product_name) AS Reverse_Name
FROM products;

-- ===================================================
-- Module 12 – String Functions
-- ===================================================

-- To the String Function 1 – Display Full Name , Purpose: Combine first name and last name.
SELECT
CONCAT(first_name,' ',last_name) AS Full_Name
FROM users;

-- To the String Function 2 – Convert Names to Uppercase
SELECT
UPPER(first_name) AS First_Name,
UPPER(last_name) AS Last_Name
FROM users;

-- To the String Function 3 – Convert Names to Lowercase
SELECT
LOWER(first_name) AS First_Name,
LOWER(last_name) AS Last_Name
FROM users;

-- To the String Function 4 – Length of Product Name
SELECT
product_name,
LENGTH(product_name) AS Name_Length
FROM products;

-- To the String Function 5 – First 5 Characters of Product Name
SELECT
product_name,
LEFT(product_name,5) AS First_Five_Characters
FROM products;

-- To the String Function 6 – Last 4 Characters of Product Name
SELECT
product_name,
RIGHT(product_name,4) AS Last_Four_Characters
FROM products;

-- To the String Function 7 – Remove Extra Spaces
SELECT
TRIM('   ShopSphere SQL Project   ') AS Trimmed_Text;

-- To the String Function 8 – Replace Product Brand Name
SELECT
product_name,
REPLACE(brand,'Apple','APPLE INC') AS Updated_Brand
FROM products;

-- To the String Function 9 – Email Username , Extract the username before @.


-- To the String Function 10 – Reverse Product Name
SELECT
product_name,
REVERSE(product_name) AS Reverse_Name
FROM products;

-- ===================================================
-- Module 13 – Date & Time Functions
-- ===================================================

-- Date Function 1 – Display Current Date
SELECT NOW() AS CurrentDateTime;
-- Purpose: Displays the current system date.

-- Date Function 2 – Display Current Time
SELECT CURTIME() AS CurrentTime;
-- Purpose: Displays the current system time.

-- Date Function 3 – Display Current Date and Time
SELECT NOW() AS CurrentDateTime;
-- Purpose: Displays both the current date and current time.

-- Date Function 4 – Display Order Year
SELECT
order_id,
YEAR(order_date) AS OrderYear
FROM orders;
-- Purpose: Extracts the year from the order date.

-- Date Function 5 – Display Order Month
SELECT
order_id,
MONTH(order_date) AS OrderMonth
FROM orders;
-- Purpose: Extracts the month from the order date.

-- Date Function 6 – Display Order Day
SELECT
order_id,
DAY(order_date) AS Order_Day
FROM orders;
-- Purpose: Extracts the day from the order date.

-- Date Function 7 – Days Since Order
SELECT
order_id,
DATEDIFF(CURDATE(), DATE(order_date)) AS Days_Since_Order
FROM orders;
-- Purpose: Calculates how many days have passed since each order was placed.

-- Date Function 8 – Add 7 Days to Order Date
SELECT
order_id,
order_date,
DATE_ADD(order_date, INTERVAL 7 DAY) AS Expected_Delivery
FROM orders;
-- Purpose: Calculates the expected delivery date by adding 7 days.

-- Date Function 9 – Subtract 3 Days from Order Date
SELECT
order_id,
order_date,
DATE_SUB(order_date, INTERVAL 3 DAY) AS Previous_Date
FROM orders;
-- Purpose: Displays the date three days before the order date.

-- To Date Function 10 – Format Order Date
SELECT
order_id,
DATE_FORMAT(order_date,'%d-%m-%Y') AS Formatted_Date
FROM orders;
-- Purpose: Formats the date as DD-MM-YYYY.

-- For Verification

-- You can also run these optional queries:
SELECT DAYNAME(order_date) AS DayName
FROM orders;
SELECT MONTHNAME(order_date) AS MonthName
FROM orders;

-- ===================================================
-- Module 14 – DCL(DATA CONTROL LANGUAGUE)
-- ===================================================

-- 1. Create a New User
CREATE USER 'project_user'@'localhost'
IDENTIFIED BY 'Project@123';
-- Explanation: Creates a new MySQL user named project_user.

-- 2. Grant All Privileges
GRANT ALL PRIVILEGES
ON shopsphere_db.*
TO 'project_user'@'localhost';
-- Explanation: Grants all privileges on the shopsphere_db database.

-- 3. Reload Privileges
FLUSH PRIVILEGES;
-- Explanation: Applies the privilege changes immediately.

-- 4. Show User Privileges
SHOW GRANTS FOR 'project_user'@'localhost';
-- Explanation:Displays all privileges assigned to the user.

-- 5. Revoke UPDATE Permission
REVOKE UPDATE
ON shopsphere_db.*
FROM 'project_user'@'localhost';
-- Explanation: To  Removes UPDATE permission from the user.

-- 6. Show Grants Again
SHOW GRANTS FOR 'project_user'@'localhost';
-- Explanation: To Verifies that the UPDATE privilege has been revoked.

-- 7. Grant UPDATE Again
GRANT UPDATE
ON shopsphere_db.*
TO 'project_user'@'localhost';

-- To Flush 
FLUSH PRIVILEGES;
-- Explanation: Restores UPDATE permission.



