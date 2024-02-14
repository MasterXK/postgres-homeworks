-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select CONCAT(employees.first_name, ' ', employees.last_name) as ФИО, customers.company_name as компания
from orders, employees, customers, shippers
where employees.employee_id = orders.employee_id AND
customers.customer_id = orders.customer_id AND
employees.city = 'London' AND
customers.city = 'London' AND
orders.ship_via = shippers.shipper_id AND
shippers.company_name = 'United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select product_name as Продукт, units_in_stock as Количество, suppliers.contact_name as Поставщик, suppliers.phone as Телефон
from products, suppliers, categories
where products.discontinued = 0 AND
products.units_in_stock < 25 AND
products.category_id = categories.category_id AND
categories.category_name in ('Dairy Products', 'Condiments') AND
products.supplier_id = suppliers.supplier_id
order by units_in_stock ASC

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select distinct company_name as Компания
from customers
join orders on customers.customer_id not in (
	select distinct customer_id
	from orders)

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select distinct product_name as Название
from products
full join order_details using(product_id)
where order_details.quantity = 10