-- Тема “Сложные запросы”
-- 
-- Составьте список пользователей users, которые 
-- осуществили хотя бы один заказ orders в интернет магазине.

 SELECT id, name, brithday_at FROM shop.users2;
SELECT id, name, price, catalog_id FROM shop.products;

SELECT id, user_id, created_at FROM shop.orders;

INSERT INTO shop.orders
(user_id)
SELECT id FROM shop.users2 where name ='муля';
 
-- VALUES(0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT id, name, price, catalog_id FROM shop.products;

INSERT INTO shop.orders_products
(order_id, product_id, total)
SELECT LAST_INSERT_ID() ,id,2 FROM shop.products where name = 'Gigabyte H310M S2H';
-- =====================================================================================
INSERT INTO shop.orders
(user_id)
SELECT id FROM shop.users2 where name ='Джон';
 
-- VALUES(0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


INSERT INTO shop.orders_products
(order_id, product_id, total)
SELECT LAST_INSERT_ID() ,id,1 
FROM shop.products where name in ('Gigabyte H310M S2H','Intel Core i3-8100');
====================================================================================


INSERT INTO shop.orders
(user_id)
SELECT id FROM shop.users2 where name ='Леша';
 
-- VALUES(0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

SELECT id, name, price, catalog_id FROM shop.products;

INSERT INTO shop.orders_products
(order_id, product_id, total)
SELECT LAST_INSERT_ID() ,id,1 
FROM shop.products where name in ('ASUS ROG MAXIMUS X HERO','AMD FX-8320','AMD FX-8320');
LAST_INSERT_ID()|id|1|
----------------|--|-|
               5| 1|1|
               5| 2|1|
               5| 3|1|
               5| 4|1|
               5| 5|1|
               5| 6|1|
               5| 7|1|
 SELECT id, order_id, product_id, total FROM shop.orders_products;
id|order_id|product_id|total|
--|--------|----------|-----|
 1|       4|         6|    2|
 2|       5|         1|    1|
 3|       5|         6|    1|
 5|       2|         4|    1|
 6|       2|         5|    1|
=============================================================================================
SELECT 
-- shop.users.id,
shop.users.name,
-- shop.orders.user_id,
COUNT(*) as количество_заказов
FROM shop.users
join 
shop.orders
on 
shop.orders.user_id=shop.users.id
GROUP BY shop.users.name;

name   |количество_заказов|
-------|------------------|
Наталья|                 1|
Сергей |                 2|

-- вывод окончательного запроса 
SELECT id  FROM shop.orders;
SELECT id, name,brithday_at FROM shop.users2 where id in (SELECT id  FROM shop.orders);

id|name|brithday_at|
--|----|-----------|
 2|Муля| 1973-04-18|
 4|ВОля| 1983-04-18|
 1|Толя| 1979-05-18|
 3|Соня| 1953-08-18|
 5|Джон| 2004-06-15|

 
 SELECT 
 name, 
 brithday_at,
 shop.orders.id 
FROM shop.users2
join
shop.orders on shop.users2.id =shop.orders.user_id 
;
 
-- Выведите список товаров products
--  и разделов catalogs, который соответствует товару.
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

SELECT id, name, price, catalog_id FROM shop.products;

id|name                   |price   |catalog_id|
--|-----------------------|--------|----------|
 1|Intel Core i3-8100     | 7890.00|         1|
 2|Intel Core i5-7400     |12700.00|         1|
 3|AMD FX-8320E           | 4780.00|         1|
 4|AMD FX-8320            | 7120.00|         1|
 5|ASUS ROG MAXIMUS X HERO|19310.00|         2|
 6|Gigabyte H310M S2H     | 4790.00|         2|
 7|MSI B250M GAMING PRO   | 5060.00|         2|
 
 SELECT id, name FROM shop.catalogs;

id|name              |
--|------------------|
 1|Процессоры        |
 2|Материнские платы |
 3|Видеокарты        |
 4|Жесткие диски     |
 5|Оперативная память|
 
 SELECT
id, 
name, 
price, 
(SELECT name FROM shop.catalogs where id= shop.products.catalog_id) as qwe
FROM shop.products;

--  JOIN---------------

SELECT shop.products.id, shop.products.name, price, catalog_id,
shop.catalogs.name 
FROM shop.products
left JOIN
shop.catalogs on
shop.catalogs.id =shop.products.catalog_id 
 
 
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

SELECT 
shop.products.name товар,
shop.catalogs.name as имя_в_каталоге, 
shop.products.price цена, 
catalog_id id_товара
FROM
shop.products
join 
shop.catalogs
on
shop.catalogs.id=shop.products.catalog_id -- 1<------ M;

товар                  |имя_в_каталоге   |цена    |id_товара|
-----------------------|-----------------|--------|---------|
Intel Core i3-8100     |Процессоры       | 7890.00|        1|
Intel Core i5-7400     |Процессоры       |12700.00|        1|
AMD FX-8320E           |Процессоры       | 4780.00|        1|
AMD FX-8320            |Процессоры       | 7120.00|        1|
ASUS ROG MAXIMUS X HERO|Материнские платы|19310.00|        2|
Gigabyte H310M S2H     |Материнские платы| 4790.00|        2|
MSI B250M GAMING PRO   |Материнские платы| 5060.00|        2|


-- НЕМНОГО НЕ ПОНЯЛ 3-е ЗАДАНИЕ 
-- (по желанию) Пусть имеется таблица рейсов flights (id, from_city_id, to_city_id)



-- и таблица городов cities (label, name).

-- Поля from_city_id, to_city_id и label 
-- содержат английские названия городов, поле name — русское. 

-- Выведите список рейсов flights с русскими названиями городов.

**********************************************
DROP TABLE IF EXISTS `flights`;
CREATE TABLE `flights` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_city_id` varchar(255) comment 'Город отправления',
  `to_city_id` varchar(255)  comment 'Город прибытия',
  PRIMARY KEY (`id`),
  KEY `from_city_id` (`from_city_id`),
  KEY `to_city_id` (`to_city_id`)
)comment 'Рейсы';


INSERT INTO vk.flights
(from_city_id, to_city_id)
VALUES
('omsk', 'Moskow'),('Berlin', 'Paris'),('Vena', 'Oslo'),('Oslo', 'Omsk'),('Leon', 'Neapole');

-------------- ниже справочник городов=====
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  id SERIAL PRIMARY KEY,
  label VARCHAR(255) COMMENT 'код города',
  name VARCHAR(255) COMMENT 'название города'
) COMMENT = 'словарь городов';

INSERT INTO vk.cities
(label, name)
VALUES('omsk', 'Омск'),('Moskow', 'Москва'),
('Berlin', 'Берлин'),('Paris', 'Париж'),('Vena', 'Вена'),('Leon', 'Леон'),('Neapole', 'НЕаполь'),
('Oslo', 'Омск');
---- выводиь таблицу по вылетам и городам --------------
SELECT id, from_city_id, to_city_id FROM vk.flights;

id|from_city_id|to_city_id|
--|------------|----------|
 1|omsk        |Moskow    |
 2|Berlin      |Paris     |
 3|Vena        |Oslo      |
 4|Oslo        |Omsk      |
 5|Leon        |Neapole   |
 
 
SELECT id, label, name FROM vk.cities;
 
id|label  |name   |
--|-------|-------|
 1|omsk   |Омск   |
 2|Moskow |Москва |
 3|Berlin |Берлин |
 4|Paris  |Париж  |
 5|Vena   |Вена   |
 6|Leon   |Леон   |
 7|Neapole|НЕаполь|
 8|Oslo   |Омск   |
 
 --- выводим flights вложеннфм запросом ---
 SELECT id, from_city_id, to_city_id,
 (SELECT name FROM vk.cities where vk.cities.label = vk.flights.from_city_id ) вылет,
 (SELECT name FROM vk.cities where vk.cities.label = vk.flights.to_city_id ) прилет
FROM vk.flights;

 --- выводим flights join соединением ---

SELECT
vk.flights.id ,
qwe1.name вылет,
qwe2.name прилет

FROM vk.flights
left join 
vk.cities qwe1 -- придумываем псевдонимы 
on vk.flights.from_city_id =qwe1.label  
left join 
vk.cities qwe2 -- тк несколько раз использется для вывода одна и таже таблица
on vk.flights.to_city_id =qwe2.label 
;
 
id|from_city_id|to_city_id|
--|------------|----------|
 1|omsk        |Moskow    |
 2|Berlin      |Paris     |
 3|Vena        |Oslo      |
 4|Oslo        |Omsk      |
 5|Leon        |Neapole   |
 
 
 id|вылет |прилет |
--|------|-------|
 4|Омск  |Омск   |
 1|Омск  |Москва |
 2|Берлин|Париж  |
 5|Леон  |НЕаполь|
 3|Вена  |Омск   |
**********************************************
**********************************************
************************************************



DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'название города '
) COMMENT = 'города';

INSERT INTO vk.cities (name) VALUES
  ('Осло'),  ('Москва'),  ('Киев'),  ('Мюнхен'),  ('Берлин');

SELECT label, name FROM vk.cities;

-- label|name  |
-- -----|------|
--     1|Осло  |
--     2|Москва|
--     3|Киев  |
--     4|Мюнхен|
--     5|Берлин|

DROP TABLE IF EXISTS `flights`;
CREATE TABLE `flights` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_city_id` bigint(20) unsigned NOT NULL,
  `to_city_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `from_city_id` (`from_city_id`),
  KEY `to_city_id` (`to_city_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO vk.flights
(from_city_id, to_city_id)
VALUES
(4, 1),(2, 5),(5, 2),(3, 4),(4, 1);

SELECT id, from_city_id, to_city_id FROM vk.flights;



alter table flights
add constraint qwe_from_city_id
foreign key flights (from_city_id)
references cities(label)
on delete  CASCADE 
on UPDATE  CASCADE;

alter table flights
add constraint qwe_to_city_id
foreign key flights (to_city_id)
references cities(label)
on delete  CASCADE 
on UPDATE  CASCADE;

SELECT id, from_city_id, to_city_id FROM vk.flights;

id  |from_city_id|to_city_id|
----|------------|----------|
1001|           2|         5|
1002|           5|         2|
1003|           3|         4|
1004|           4|         1|
1005|           4|         1|



SELECT 
-- flights .from_city_id,
flights .to_city_id,
COUNT(*) ,
cities.name прилет_в_город
FROM cities
-- join 
-- flights 
-- on  cities .label=flights.to_city_id 
join 
flights
on  cities .label=flights.to_city_id 
where name in ('Мюнхен','Осло') 
GROUP by flights.id 


to_city_id|COUNT(*)|прилет_в_город|
----------|--------|--------------|
         1|       2|Осло          |
         4|       1|Мюнхен        |


-- SELECT 
-- -- flights .from_city_id,
-- flights .to_city_id,
-- -- cities.name вылет
-- 
-- -- COUNT(*) 
-- cities.name прилет_в_город
-- FROM cities
-- join 
-- flights 
-- on  flights.to_city_id =cities .label
-- where name in ('Мюнхен','Осло') 
-- -- GROUP by to_city_id 
-- UNION 
-- SELECT 
-- flights .from_city_id,
-- -- flights.from_city_id ,
-- -- COUNT(*) ,
-- cities.name
-- FROM cities
-- join 
-- flights 
-- on   cities .label=flights.from_city_id
-- where name in ('Мюнхен','Осло')










