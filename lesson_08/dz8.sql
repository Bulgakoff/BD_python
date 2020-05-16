-- Тема “Сложные запросы”
-- 
-- Составьте список пользователей users, которые 
-- осуществили хотя бы один заказ orders в интернет магазине.

 
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
 


-- Выведите список товаров products
--  и разделов catalogs, который соответствует товару.




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










