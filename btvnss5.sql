create table customers(
	customer_id serial primary key,
	customer_name varchar(50),
	city varchar(50)
);

create table orders(
	order_id serial primary key,
	customer_id int references customers(customer_id),
	order_date date,
	total_price int
);

create table order_items(
	item_id serial primary key,
	order_id int references orders(order_id),
	product_id int,
	quantity int check(quantity>=0),
	price int check(price>=0)
);

insert into customers (customer_id, customer_name, city) values
(1, 'Nguyễn Văn A', 'Hà Nội'),
(2, 'Trần Thị B', 'Đà Nẵng'),
(3, 'Lê Văn C', 'Hồ Chí Minh'),
(4, 'Phạm Thị D', 'Hà Nội');

select * from customers

insert into orders (order_id, customer_id, order_date, total_price) values
(101, 1, '2024-12-20', 3000),
(102, 2, '2025-01-05', 1500),
(103, 1, '2025-02-10', 2500),
(104, 3, '2025-02-15', 4000),
(105, 4, '2025-03-01', 800);

select * from orders

insert into order_items (item_id, order_id, product_id, quantity, price) values
(1, 101, 1, 2, 1500),
(2, 102, 2, 1, 1500),
(3, 103, 3, 5, 500),
(4, 104, 2, 4, 1000);

select * from order_items



---------------------------
--1
select c.customer_name, sum(o.total_price) as total_revenue, count(o.order_id) as order_count
from customers c join orders o on c.customer_id=o.customer_id
group by c.customer_name 
having sum(o.total_price) > 2000

--2
select c.customer_id, c.customer_name, sum(o.total_price)
from customers c join orders o on c.customer_id=o.customer_id
group by c.customer_id
having sum(o.total_price)>
(select avg(o.total_price)
from customers c join orders o on c.customer_id=o.customer_id)

--3
select c.city, sum(o.total_price)
from customers c join orders o on c.customer_id=o.customer_id
group by c.city
having sum(o.total_price)=
(
	select sum(o.total_price)
	from customers c join orders o on c.customer_id=o.customer_id
	group by c.city
	order by sum(o.total_price) desc limit 1
)

--4
select c.customer_name, c.city, sum(oi.quantity) as "tổng sản phẩm đã mua" , sum(o.total_price) as "tổng chi tiêu "
from customers c inner join orders o on c.customer_id=o.customer_id
inner join order_items oi on o.order_id=oi.order_id
group by c.customer_name, c.customer_id

