-- 1. Identifikasi 3 pelanggan teratas berdasarkan total nominal pesanan!
SELECT 
	c.first_name
    , c.last_name
    , SUM(total_amount) AS total_order_amount
FROM 
	customers AS c
JOIN
	orders AS o
	ON c.customers_id = o.customers_id
GROUP BY 
	c.customers_id
ORDER BY
	total_order_amount DESC
LIMIT 3;

-- 2. Temukan rata-rata nominal pesanan untuk setiap pelanggan!
SELECT 
	first_name
    , last_name
    , AVG(total_amount) AS average_order_amount
FROM 
	customers AS c
JOIN
	orders AS o
	ON c.customers_id = o.customers_id
GROUP BY 
	c.customers_id
ORDER BY
	average_order_amount DESC;

-- 3. Temukan semua karyawan yang telah menyelesaikan lebih dari 4 tiket support!
SELECT
	first_name
    , last_name
    , COUNT(s.tickets_id) AS resolved_tickets
FROM
	employees AS e
JOIN 
	support_tickets AS s
    ON e.employees_id = s.employees_id
WHERE 
	status = 'resolved'
GROUP BY
	e.employees_id
HAVING
	resolved_tickets > 4;

-- 4. Temukan semua produk yang belum pernah dipesan!
SELECT
	p.product_name
FROM 
	products AS p
LEFT JOIN 
	orderdetails AS od
    ON p.products_id = od.products_id
WHERE 
	od.orders_id IS null;

-- 5. Hitung total pendapatan yang dihasilkan dari penjualan produk!
SELECT
	SUM(unit_price*quantity) AS revenue
FROM 
	orderdetails;

-- 6. Temukan harga rata-rata produk untuk setiap kategori dan temukan kategori dengan harga rata-rata lebih dari $500!
WITH avg_price AS (
SELECT
	category
    , AVG(price) AS rerata
FROM
	products
GROUP BY
	category)
SELECT
	*
FROM 
	avg_price
WHERE 
	rerata > 500;

-- 7. Temukan pelanggan yang telah membuat setidaknya satu pesanan dengan total jumlah lebih dari $1000!
SELECT 
	*
FROM 
	customers
WHERE 
	customers_id IN
(SELECT 
	customers_id
FROM 
	orders
WHERE 
	total_amount > 1000);
    
-- 8. Jumlah quantity per order pada masing-masing customers
SELECT
	c.customers_id
    , o.orders_id
    , c.first_name
    , c.last_name
    , SUM(od.quantity) AS total_qty_per_order
FROM
	customers AS c
JOIN 
	orders AS o
    ON c.customers_id = o.customers_id
JOIN
	orderdetails AS od
    ON o.orders_id = od.orders_id
GROUP BY
	c.customers_id, c.first_name, c.last_name, o.orders_id
ORDER BY
	c.customers_id, o.orders_id;

-- 9. Berapa jumlah issue setiap customers
SELECT 
	st.customers_id
	, c.first_name
    , c.last_name
    , COUNT(st.tickets_id) AS total_issue
FROM 
	support_tickets AS st
JOIN 
	customers AS c
	ON st.customers_id = c.customers_id
GROUP BY
	st.customers_id;