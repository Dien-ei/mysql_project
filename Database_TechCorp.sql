CREATE DATABASE techcorp_dna;

CREATE TABLE products (
	products_id		INT AUTO_INCREMENT PRIMARY KEY,
	product_name 	VARCHAR (100)	NOT NULL,
    category		VARCHAR (50)	NOT NULL,
    price			DECIMAL(10, 2) 	NOT NULL,
    stock_quantity	INT UNSIGNED	NOT NULL DEFAULT 0,
    discount		INT UNSIGNED	NOT NULL
);

CREATE TABLE customers (
	customers_id	INT AUTO_INCREMENT PRIMARY KEY,
	first_name		VARCHAR (50)	NOT NULL,
    last_name		VARCHAR (50)	NOT NULL,
    email			VARCHAR	(100) 	UNIQUE,
    phone			VARCHAR (20),
    address			VARCHAR (200)
);

CREATE TABLE orders (
	orders_id		INT AUTO_INCREMENT PRIMARY KEY,
    customers_id	INT,
	order_date		DATE,
    total_amount	DECIMAL (10, 2),
    FOREIGN KEY (customers_id) REFERENCES customers(customers_id)
);

CREATE TABLE orderdetails (
	order_details_id	INT AUTO_INCREMENT PRIMARY KEY,
    orders_id			INT,
    products_id			INT,
    quantity			INT 	NOT NULL DEFAULT 0,
	unit_price			DECIMAL (10, 2),
    FOREIGN KEY (orders_id) REFERENCES orders(orders_id),
    FOREIGN KEY (products_id) REFERENCES products(products_id)
);

CREATE TABLE employees (
	employees_id		INT AUTO_INCREMENT PRIMARY KEY,
    first_name			VARCHAR (50)	NOT NULL,
    last_name			VARCHAR (50)	NOT NULL,
    email				VARCHAR (100)	UNIQUE,
    phone				VARCHAR (20),
    hire_date			DATE,
    department			VARCHAR	(50)
);

CREATE TABLE support_tickets (
	tickets_id			INT AUTO_INCREMENT PRIMARY KEY,
    customers_id		INT,
    employees_id		INT,
    issue				TEXT,
    status				VARCHAR (20),
    created_at			DATETIME,
    resolved_at			DATETIME,
    FOREIGN KEY (customers_id) REFERENCES customers(customers_id),
    FOREIGN KEY (employees_id) REFERENCES employees(employees_id)
 );
 
 INSERT INTO products (
	product_name
    , category
    , price
    , stock_quantity
    , discount)
VALUES
	('Laptop Pro 15', 'Laptop', 1500.00, 100, 0)
    , ('Smartphone X', 'Smartphone', 800.00, 200, 0)
    , ('Wireless Mouse', 'Accessories', 25.00, 500, 0)
	, ('USB-C Charger', 'Accessories', 20.00, 300, 0)
	, ('Gaming Laptop', 'Laptop', 2000.00, 50, 10)
	, ('Budget Smartphone', 'Smartphone', 300.00, 150, 5)
	, ('Noise Cancelling Headphones', 'Accessories', 150.00, 120, 15)
	, ('Wireless Earphones', 'Accessories', 100.00, 100, 10);
 
 INSERT INTO customers (
	first_name
    , last_name
    , email
    , phone
    , address)
VALUES
	('John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Elm Street')
	, ('Jane', 'Smith', 'jane.smith@example.com', '123-456-7891', '456 Oak Street')
	, ('Emily', 'Johnson', 'emily.johnson@example.com', '123-456-7892', '789 Pine Street')
	, ('Michael', 'Brown', 'michael.brown@example.com', '123-456-7893', '101 Maple Street')
	, ('Sarah', 'Davis', 'sarah.davis@example.com', '123-456-7894', '202 Birch Street');
 
 INSERT INTO orders (
	customers_id
	, order_date
    , total_amount)
VALUES
	(1, '2023-07-01', 1525.00)
	, (2, '2023-07-02', 820.00)
	, (3, '2023-07-03', 25.00)
	, (1, '2023-07-04', 2010.00)
	, (4, '2023-07-05', 300.00)
	, (2, '2023-07-06', 315.00)
	, (5, '2023-07-07', 165.00);
 
 INSERT INTO orderdetails (
	orders_id
    , products_id
    , quantity
    , unit_price)
VALUES
	(1, 1, 1, 1500.00)
	, (1, 3, 1, 25.00)
	, (2, 2, 1, 800.00)
	, (2, 4, 1, 20.00)
	, (3, 3, 1, 25.00)
	, (4, 5, 1, 2000.00)
	, (4, 6, 1, 10.00)
	, (5, 6, 1, 300.00)
	, (6, 6, 1, 300.00)
	, (7, 7, 1, 150.00)
	, (7, 4, 1, 15.00);
    
INSERT INTO employees (
	first_name
    , last_name
    , email
    , phone
    , hire_date
    , department)
VALUES
	('Alice', 'Williams', 'alice.williams@example.com', '123-456-7895', '2022-01-15', 'Support')
	, ('Bob', 'Miller', 'bob.miller@example.com', '123-456-7896', '2022-02-20', 'Sales')
	, ('Charlie', 'Wilson', 'charlie.wilson@example.com', '123-456-7897', '2022-03-25', 'Development')
	, ('David', 'Moore', 'david.moore@example.com', '123-456-7898', '2022-04-30', 'Support')
	, ('Eve', 'Taylor', 'eve.taylor@example.com', '123-456-7899', '2022-05-10', 'Sales');
 
INSERT INTO support_tickets (
	customers_id
    , employees_id
    , issue
    , status
    , created_at
    , resolved_at)
VALUES
	(1, 1, 'Cannot connect to Wi-Fi', 'resolved', '2023-07-01 10:00:00', '2023-07-01 11:00:00')
	, (2, 1, 'Screen flickering', 'resolved', '2023-07-02 12:00:00', '2023-07-02 13:00:00')
	, (3, 1, 'Battery drains quickly', 'open', '2023-07-03 14:00:00', NULL)
	, (4, 2, 'Late delivery', 'resolved', '2023-07-04 15:00:00', '2023-07-04 16:00:00')
	, (5, 2, 'Damaged product', 'open', '2023-07-05 17:00:00', NULL)
	, (1, 3, 'Software issue', 'resolved', '2023-07-06 18:00:00', '2023-07-06 19:00:00')
	, (2, 3, 'Bluetooth connectivity issue', 'resolved', '2023-07-07 20:00:00', '2023-07-07 21:00:00')
	, (5, 4, 'Account issue', 'open', '2023-07-08 22:00:00', NULL)
	, (3, 4, 'Payment issue', 'resolved', '2023-07-09 23:00:00', '2023-07-09 23:30:00')
	, (4, 5, 'Physical damage', 'open', '2023-07-10 08:00:00', NULL)
	, (4, 1, 'Laptop blue screen', 'resolved', '2024-01-05 10:00:00', '2024-02-05 12:00:00')
	, (5, 1, 'Laptop lagging', 'resolved', '2024-01-06 10:00:00', '2024-01-25 12:00:00')
	, (3, 1, 'Some part of laptop broken', 'resolved', '2024-02-05 10:00:00', '2024-03-05 12:00:00');
