create table products(
	product_id serial primary key,
	product_name varchar(50),
	category varchar(50)
);

create table orders(
	order_id serial primary key,
	product_id int references products(product_id),
	quantity int check(quantity>=0),
	total_price int check(total_price>=0)
	
);

insert into products(product_name,category) values
('Laptop Dell',	'Electronics'),
('IPhone 15','Electronics'),
('Bàn học gỗ','Furniture' ),
('Ghế xoay', 'Furniture');


insert into orders (order_id,product_id,quantity,total_price) values
(101,1,2,2200),
(102,2,3,3300),
(103,3,5,2500 ),
(104,4,4,1600),
(105,1,1,1100);

delete from orders

select * from orders 




select p.category, sum(o.total_price) as total_sales, sum(o.quantity) as total_quantity
from products as p join orders as o on p.product_id=o.product_id
group by p.category
having sum(o.total_price) >2000
order by total_sales desc











