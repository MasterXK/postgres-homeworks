-- Подключиться к БД Northwind и сделать следующие изменения:
-- 1. Добавить ограничение на поле unit_price таблицы products (цена должна быть больше 0)
ALTER TABLE products ADD CONSTRAINT chk_products_unit_price CHECK (unit_price >= 0)

-- 2. Добавить ограничение, что поле discontinued таблицы products может содержать только значения 0 или 1
ALTER TABLE products ADD CONSTRAINT chk_products_discontinued CHECK (discontinued IN (0, 1))


-- 3. Создать новую таблицу, содержащую все продукты, снятые с продажи (discontinued = 1)
CREATE TABLE discontinued_products
	AS (SELECT *
	    FROM products
	   	where discontinued = 1)

-- 4. Удалить из products товары, снятые с продажи (discontinued = 1)
-- Для 4-го пункта может потребоваться удаление ограничения, связанного с foreign_key. Подумайте, как это можно решить, чтобы связь с таблицей order_details все же осталась.
CREATE TABLE all_products
	AS (SELECT product_id, product_name
		FROM discontinued_products
		UNION
		SELECT product_id, product_name
		FROM products)
ALTER TABLE all_products ADD CONSTRAINT pk_all_products_product_id PRIMARY KEY (product_id);

ALTER TABLE order_details DROP CONSTRAINT fk_order_details_products;
DELETE FROM products WHERE discontinued = 1;
ALTER TABLE order_details ADD CONSTRAINT fk_order_details_all_products FOREIGN KEY(product_id) REFERENCES all_products(product_id);