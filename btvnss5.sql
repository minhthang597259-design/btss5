CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    total_amount NUMERIC(10,2)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_name VARCHAR(100),
    quantity INT,
    price NUMERIC(10,2)
);

INSERT INTO customers (customer_name, city) VALUES
('Nguyen Van An', 'Hanoi'),
('Tran Thi Bich', 'Ho Chi Minh'),
('Le Van Cuong', 'Da Nang'),
('Pham Thi Dung', 'Can Tho'),
('Hoang Van Duc', 'Hai Phong'),
('Nguyen Thi Hoa', 'Hue'),
('Tran Van Hung', 'Nha Trang'),
('Le Thi Lan', 'Vung Tau'),
('Pham Van Minh', 'Quang Ninh'),
('Hoang Thi Nga', 'Bac Ninh'),
('Nguyen Van Phuc', 'Hanoi'),
('Tran Thi Quyen', 'Ho Chi Minh'),
('Le Van Son', 'Da Nang'),
('Pham Thi Trang', 'Can Tho'),
('Hoang Van Tuan', 'Hai Phong'),
('Nguyen Thi Uyen', 'Hue'),
('Tran Van Viet', 'Nha Trang'),
('Le Thi Xuan', 'Vung Tau'),
('Pham Van Yen', 'Quang Ninh'),
('Hoang Thi Zinh', 'Bac Ninh');

select * from customers

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2024-01-01', 250.50),
(2, '2024-01-02', 120.00),
(3, '2024-01-03', 560.75),
(4, '2024-01-04', 80.00),
(5, '2024-01-05', 300.20),
(6, '2024-01-06', 150.00),
(7, '2024-01-07', 420.40),
(8, '2024-01-08', 75.00),
(9, '2024-01-09', 610.10),
(10, '2024-01-10', 95.00),
(11, '2024-01-11', 200.00),
(12, '2024-01-12', 330.30),
(13, '2024-01-13', 440.00),
(14, '2024-01-14', 510.00),
(15, '2024-01-15', 620.00),
(16, '2024-01-16', 710.50),
(17, '2024-01-17', 80.80),
(18, '2024-01-18', 90.90),
(19, '2024-01-19', 150.50),
(20, '2024-01-20', 260.60);

select * from orders

INSERT INTO order_items (order_id, product_name, quantity, price) VALUES
(1, 'Laptop Dell', 1, 250.50),
(2, 'Mouse Logitech', 2, 60.00),
(3, 'Keyboard Razer', 1, 560.75),
(4, 'USB 32GB', 2, 40.00),
(5, 'Monitor Samsung', 1, 300.20),
(6, 'Headphone Sony', 1, 150.00),
(7, 'Laptop HP', 1, 420.40),
(8, 'USB 64GB', 1, 75.00),
(9, 'iPhone 13', 1, 610.10),
(10, 'Charger Anker', 1, 95.00),

(11, 'Laptop Asus', 1, 200.00),
(12, 'Tablet Samsung', 1, 330.30),
(13, 'Camera Canon', 1, 440.00),
(14, 'Smartwatch', 1, 510.00),
(15, 'TV LG', 1, 620.00),
(16, 'MacBook Air', 1, 710.50),
(17, 'Speaker JBL', 2, 40.40),
(18, 'Router TP-Link', 1, 90.90),
(19, 'SSD 1TB', 1, 150.50),
(20, 'Power Bank', 2, 130.30),

(1, 'Mouse Pad', 1, 10.00),
(2, 'USB Hub', 1, 20.00),
(3, 'Cooling Pad', 1, 25.00),
(4, 'HDMI Cable', 2, 15.00),
(5, 'Webcam', 1, 45.00),
(6, 'Microphone', 1, 70.00),
(7, 'Gaming Chair', 1, 200.00),
(8, 'Desk Lamp', 1, 30.00),
(9, 'AirPods', 1, 150.00),
(10, 'Keyboard Cover', 1, 10.00),

(11, 'Stylus Pen', 1, 15.00),
(12, 'Phone Case', 2, 20.00),
(13, 'Tripod', 1, 35.00),
(14, 'Fitness Band', 1, 50.00),
(15, 'Remote TV', 1, 25.00),
(16, 'Laptop Sleeve', 1, 20.00),
(17, 'Bluetooth Adapter', 1, 15.00),
(18, 'Ethernet Cable', 2, 10.00),
(19, 'External HDD', 1, 80.00),
(20, 'Screen Protector', 2, 10.00);

select * from order_items


--1
select o.order_id, c.customer_name as "Tên khách", o.order_date as "Ngày đặt hàng", o.total_amount as "Tổng tiền" 
from customers c join orders o on c.customer_id=o.customer_id

--2
select sum(total_amount),AVG(total_amount), max(total_amount),
min(total_amount), count(total_amount)
from customers c join orders o on c.customer_id=o.customer_id

--3
select c.city, sum(total_amount) as s
from customers c join orders o on c.customer_id=o.customer_id
group by c.city
having sum(total_amount) >=10000

--4
select oi.item_id, c.customer_name, order_date, quantity, price
from customers c join orders o on c.customer_id=o.customer_id
join order_items as oi on oi.order_id=o.order_id

--5
select c.customer_name, sum(o.total_amount)
from customers c join orders o on c.customer_id=o.customer_id
group by c.customer_name, c.customer_id
having sum(o.total_amount)=
(
	select sum(o.total_amount)
	from customers c join orders o on c.customer_id=o.customer_id
	group by c.customer_name, c.customer_id
	order by sum(o.total_amount) desc limit 1
)


--6a
select city from customers
union
select c.city
from customers c join orders o on c.customer_id=o.customer_id

--6b
select city from customers
intersect
select c.city
from customers c join orders o on c.customer_id=o.customer_id


