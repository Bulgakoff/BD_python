-- lesson_07_hard_request
-- ТИПЫ МНОГОТАБЛИЧНЫХ ЗАПРОcОВ


USE shop;
DROP table if not exists rubrics;
CREATE TABLE rubrics (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'название раздела'
  ) COMMENT = 'Разделы интернет-магазина';

INSERT INTO shop.rubrics
VALUES
(null,'видео карты'),
(null,'память')
;

SELECT * FROM catal;
id|name              
--|------------------
 1|proccessors       
 2|mat.platy         
 3|video cards       
 4|жесткие диски     
 5|оперативная память
 
SELECT * FROM rubrics;

id|name       |
--|-----------|
 1|видео карты|
 2|память     |


SELECT * FROM catal
union
SELECT * FROM rubrics;
id|name              |
--|------------------|
 1|proccessors       |
 2|mat.platy         |
 3|video cards       |
 4|жесткие диски     |
 5|оперативная память|
 
 1|видео карты       |
 2|память            |

INSERT INTO shop.rubrics
VALUES
(null,'жесткие диски');





-- объединение UNION
SELECT * FROM catal
union all
SELECT * FROM rubrics
order by name DESC ;
id|name              |
--|------------------|
 2|память            |
 5|оперативная память|
 4|жесткие диски     |
 3|жесткие диски     |
 1|видео карты       |
 3|video cards       |
 1|proccessors       |
 2|mat.platy         |


SELECT * FROM catal
union all
SELECT * FROM rubrics
order by name DESC 
limit 3;

id|name              |
--|------------------|
 2|память            |
 5|оперативная память|
 3|жесткие диски     |
 
 
-- ВЛОЖЕННЫЕ ЗАПРОСЫ ()

(SELECT * FROM catal order by name desc LIMIT 2)
union all
(SELECT * FROM rubrics order by name DESC limit 3);

id|name              |
--|------------------|
 5|оперативная память|
 4|жесткие диски     |
 2|память            |
 
 3|жесткие диски     |
 1|видео карты       |
 
--  DROP table catal ;
--  DROP table cat ;
--  DROP table store_house_products ;
--  DROP table store_house_products2 ;
--  DROP table catal ;

(SELECT *
-- id, name
FROM shop.catalogs)
union
(SELECT id, name
-- id, name, description, price, catalog_id, created_at, updated_at
FROM shop.products);

id|name                   |
--|-----------------------|
 1|Процессоры             |
 2|Материнские платы      |
 3|Видеокарты             |
 4|Жесткие диски          |
 5|Оперативная память     |
 1|Intel Core i3-8100     |
 2|Intel Core i5-7400     |
 3|AMD FX-8320E           |
 4|AMD FX-8320            |
 5|ASUS ROG MAXIMUS X HERO|
 6|Gigabyte H310M S2H     |
 7|MSI B250M GAMING PRO   |
 
 (SELECT *
-- id, name
FROM shop.catalogs)
union
(SELECT id, name
-- id, name, description, price, catalog_id, created_at, updated_at
FROM shop.products)
union 
(SELECT id, name
-- id, name, birthday_at, created_at, updated_at
FROM shop.users order by name LIMIT 3);

id|name                   |
--|-----------------------|
 1|Процессоры             |
 2|Материнские платы      |
 3|Видеокарты             |
 4|Жесткие диски          |
 5|Оперативная память     |
 1|Intel Core i3-8100     |
 2|Intel Core i5-7400     |
 3|AMD FX-8320E           |
 4|AMD FX-8320            |
 5|ASUS ROG MAXIMUS X HERO|
 6|Gigabyte H310M S2H     |
 7|MSI B250M GAMING PRO   |
 3|Александр              |
 1|Геннадий               |
 5|Иван                   |
 
--  ключевые слова IN, ANY,SOME,ALL
 SELECT id, name FROM shop.catalogs;
id|name              |
--|------------------|
 1|Процессоры        |
 2|Материнские платы |
 3|Видеокарты        |
 4|Жесткие диски     |
 5|Оперативная память|

 SELECT id, name, catalog_id FROM shop.products;
id|name                   |catalog_id|
--|-----------------------|----------|
 1|Intel Core i3-8100     |         1|
 2|Intel Core i5-7400     |         1|
 3|AMD FX-8320E           |         1|
 4|AMD FX-8320            |         1|
 5|ASUS ROG MAXIMUS X HERO|         2|
 6|Gigabyte H310M S2H     |         2|
 7|MSI B250M GAMING PRO   |         2|
 
  SELECT id, name, catalog_id FROM shop.products WHERE catalog_id =1;
 
id|name              |catalog_id|
--|------------------|----------|
 1|Intel Core i3-8100|         1|
 2|Intel Core i5-7400|         1|
 3|AMD FX-8320E      |         1|
 4|AMD FX-8320       |         1|
 
  SELECT id, name FROM shop.catalogs where name ='Процессоры';
 
id|name      |
--|----------|
 1|Процессоры|
 
   SELECT id, name, catalog_id FROM shop.products 
   where catalog_id = (SELECT id FROM shop.catalogs where name ='Процессоры')
    id|name              |catalog_id|
	--|------------------|----------|
	 1|Intel Core i3-8100|         1|
	 2|Intel Core i5-7400|         1|
	 3|AMD FX-8320E      |         1|
	 4|AMD FX-8320       |         1|
   
 SELECT MAX(price ) FROM shop.products ;
 SELECT id, name,price, catalog_id
FROM shop.products;

SELECT id, name, price, catalog_id 
FROM shop.products where price in (SELECT MAX(price) FROM products);
id|name                   |price   |catalog_id|
--|-----------------------|--------|----------|
 5|ASUS ROG MAXIMUS X HERO|19310.00|         2|
 
 SELECT id, name, price, catalog_id 
FROM shop.products where price < (SELECT AVG(price) FROM products);
 
 id|name                |price  |catalog_id|
--|--------------------|-------|----------|
 1|Intel Core i3-8100  |7890.00|         1|
 3|AMD FX-8320E        |4780.00|         1|
 4|AMD FX-8320         |7120.00|         1|
 6|Gigabyte H310M S2H  |4790.00|         2|
 7|MSI B250M GAMING PRO|5060.00|         2|
 
 
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
 
 SELECT name FROM shop.catalogs where id =1 ;
--  ПОДЗАПРОСЫ В КОНСТРУКЦИИ FROM========================================================

 SELECT id, name,
 (SELECT name
--  id, name
 FROM shop.catalogs where id=catalog_id)
FROM products ;

id|name                   |(SELECT name
--  id, name
 FROM shop.catalogs where id=catalog_id)|
--|-----------------------|------------------
 1|Intel Core i3-8100     |Процессоры        
 2|Intel Core i5-7400     |Процессоры        
 3|AMD FX-8320E           |Процессоры        
 4|AMD FX-8320            |Процессоры        
 5|ASUS ROG MAXIMUS X HERO|Материнские платы 
 6|Gigabyte H310M S2H     |Материнские платы 
 7|MSI B250M GAMING PRO   |Материнские платы 
 
 
 SELECT 
 products.id,
 products.name,
 (SELECT catalogs.name
--  id, name
 FROM shop.catalogs
 where catalogs.id=products.catalog_id)
FROM products ;
 
 
 
 
--  ПРОВЕРКА НА СУЩЕСТВОВАНИЕ 

SELECT 
products.id,
products.name, 
products.price,
(SELECT catalogs.name
FROM shop.catalogs
where catalogs.id=products.catalog_id) qwe
-- id, name, description, price, catalog_id, created_at, updated_at
FROM shop.products 
where catalog_id =2 AND 
products.price <ANY  (SELECT price
-- id, name, description, price, catalog_id, created_at, updated_at
FROM shop.products where catalog_id =1);
id|name                |price  |qwe              |
--|--------------------|-------|-----------------|
 6|Gigabyte H310M S2H  |4790.00|Материнские платы|
 7|MSI B250M GAMING PRO|5060.00|Материнские платы|
 
 
 
 SELECT 
products.id,
products.name, 
products.price,
(SELECT catalogs.name
FROM shop.catalogs
where catalogs.id=products.catalog_id) qwe
-- id, name, description, price, catalog_id, created_at, updated_at
FROM shop.products 
where catalog_id =2 AND 
products.price >ALL (SELECT price 
-- id, name, description, price, catalog_id, created_at, updated_at
FROM shop.products where catalog_id =1);

id|name                   |price   |qwe              |
--|-----------------------|--------|-----------------|
 5|ASUS ROG MAXIMUS X HERO|19310.00|Материнские платы|
--  КОРЕЛИРОВАННЫЕ ЗАПРОСЫ =================================================================
 
SELECT id, name FROM shop.catalogs;

 id|name              |
--|------------------|
 1|Процессоры        |
 2|Материнские платы |
 3|Видеокарты        |
 4|Жесткие диски     |
 5|Оперативная память|
 
 SELECT id, name, catalog_id
--  id, name, description, price, catalog_id, created_at, updated_at
FROM shop.products;
id|name                   |catalog_id|
-- --|-----------------------|----------|
--  1|Intel Core i3-8100     |         1|
--  2|Intel Core i5-7400     |         1|
--  3|AMD FX-8320E           |         1|
--  4|AMD FX-8320            |         1|

--  5|ASUS ROG MAXIMUS X HERO|         2|
--  6|Gigabyte H310M S2H     |         2|
--  7|MSI B250M GAMING PRO   |         2|

SELECT id, name FROM shop.catalogs
where 
EXISTS ( SELECT 1 FROM shop.products where catalog_id = catalogs.id );

id|name             |
--|-----------------|
 1|Процессоры       |
 2|Материнские платы|
 
 
 SELECT id, name FROM shop.catalogs
where 
NOT EXISTS ( SELECT 1 FROM shop.products where catalog_id = catalogs.id );
 
 id|name              |
--|------------------|
 3|Видеокарты        |
 4|Жесткие диски     |
 5|Оперативная память|
 
 
SELECT id , name, price, catalog_id
-- id, name, description, price, catalog_id, created_at, updated_at
FROM shop.products;
id|name                   |price   |catalog_id|
--|-----------------------|--------|----------|
 1|Intel Core i3-8100     | 7890.00|         1|
 2|Intel Core i5-7400     |12700.00|         1|
 3|AMD FX-8320E           | 4780.00|         1|
 4|AMD FX-8320            | 7120.00|         1|
 5|ASUS ROG MAXIMUS X HERO|19310.00|         2|
 6|Gigabyte H310M S2H     | 4790.00|         2|
 7|MSI B250M GAMING PRO   | 5060.00|         2|
 
 SELECT id , name, price, catalog_id FROM shop.products 
 where (catalog_id,12700) IN (SELECT id, price FROM shop.catalogs);
 -- надо обратить внимание га  price из products встаыленное в SELECT catalogs.
 
-- id|name              |price   |catalog_id|
-- --|------------------|--------|----------|
--  2|Intel Core i5-7400|12700.00|         1|

SELECT ROUND( AVG(price)) qwe FROM shop.products where catalog_id =1;
qwe |
----|
8123|

SELECT ROUND( AVG(price)) qew 
FROM (SELECT * FROM shop.products
where catalog_id =1) zzz;

выясняем минимальную цену и груперуем по виду товара catalog_id

 SELECT
 AVG(price) 
 FROM 
 (SELECT MIN(price) as qwe
 FROM shop.products
 group by catalog_id ) as jjj;

 
-- СЛОЖНЫЕ ЗАПРОСЫ=============================================================================

-- соединение JOIN
-- декартово произведение 
CREATE TABLE tbl1 (
  value VARCHAR(255)
);
INSERT INTO tbl1
VALUES ('fst1'), ('fst2'), ('fst3');

CREATE TABLE tbl2 (
  value VARCHAR(255)
);
INSERT INTO tbl2
VALUES ('snd1'), ('snd2'), ('snd3');

SELECT value
FROM shop.tbl1;
value|
-----|
fst1 |
fst2 |
fst3 |
SELECT value
FROM shop.tbl2;
value|
-----|
snd1 |
snd2 |
snd3 |

SELECT * FROM tbl1 ,tbl2 ;
value|value|
-----|-----|
fst3 |snd1 |
fst2 |snd1 |
fst1 |snd1 |
fst3 |snd2 |
fst2 |snd2 |
fst1 |snd2 |
fst3 |snd3 |
fst2 |snd3 |


fst1 |snd3 |




SELECT * FROM tbl1 join tbl2 ;

value|value|
-----|-----|
fst3 |snd1 |
fst2 |snd1 |
fst1 |snd1 |
fst3 |snd2 |
fst2 |snd2 |
fst1 |snd2 |
fst3 |snd3 |
fst2 |snd3 |
fst1 |snd3 |

SELECT tbl1.value, tbl2.value FROM tbl1 ,tbl2 ;
SELECT tbl1.*, tbl2.value FROM tbl1 ,tbl2 ;-- **********************************

SELECT aa1.value, aa2.value FROM tbl1 aa1,tbl2 aa2;-- алиасы
==========================================================================================
SELECT id, name FROM shop.catalogs;

SELECT id, name, price, catalog_id FROM shop.products;
===============================================================================================

SELECT p.name, p.price,p.catalog_id, c.name
FROM shop.catalogs as  c
join 
products as p;

name                   |price   |catalog_id|name              |
-----------------------|--------|----------|------------------|
Intel Core i3-8100     | 7890.00|         1|Оперативная память|
Intel Core i3-8100     | 7890.00|         1|Жесткие диски     |
Intel Core i3-8100     | 7890.00|         1|Видеокарты        |
Intel Core i3-8100     | 7890.00|         1|Материнские платы |
Intel Core i3-8100     | 7890.00|         1|Процессоры        |
Intel Core i5-7400     |12700.00|         1|Оперативная память|
Intel Core i5-7400     |12700.00|         1|Жесткие диски     |

-- все в перемешку добавляем для уточнения where c.id=p.catalog_id 

SELECT p.name, p.price,p.catalog_id, c.name
FROM shop.catalogs as  c
join 
products as p
where c.id=p.catalog_id 
;
-- name                   |price   |catalog_id|name             |
-- -----------------------|--------|----------|-----------------|
-- Intel Core i3-8100     | 7890.00|         1|Процессоры       |
-- Intel Core i5-7400     |12700.00|         1|Процессоры       |
-- AMD FX-8320E           | 4780.00|         1|Процессоры       |
-- AMD FX-8320            | 7120.00|         1|Процессоры       |
-- ASUS ROG MAXIMUS X HERO|19310.00|         2|Материнские платы|
-- Gigabyte H310M S2H     | 4790.00|         2|Материнские платы|
-- MSI B250M GAMING PRO   | 5060.00|         2|Материнские платы|

SELECT p.name, p.price,p.catalog_id, c.name
FROM shop.catalogs as  c
join 
products as p
on c.id=p.catalog_id 



-- самобъединеие таблиц 

SELECT * FROM shop.catalogs as qwe join catalogs as zxc
where qwe.id=zxc.id 
;
id|name              |id|name              |
--|------------------|--|------------------|
 1|Процессоры        | 1|Процессоры        |
 2|Материнские платы | 2|Материнские платы |
 3|Видеокарты        | 3|Видеокарты        |
 4|Жесткие диски     | 4|Жесткие диски     |
 5|Оперативная память| 5|Оперативная память|vv
 
 SELECT * 
 FROM shop.catalogs as qwe 
 join
 catalogs as zxc
using(id) 

id|name              |name              |
--|------------------|------------------|
 1|Процессоры        |Процессоры        |
 2|Материнские платы |Материнские платы |
 3|Видеокарты        |Видеокарты        |
 4|Жесткие диски     |Жесткие диски     |
 5|Оперативная память|Оперативная память|
 
--  LEFT JOIN 

 SELECT p.name, p.price,p.catalog_id, c.name
FROM shop.catalogs as  c
left JOIN  
products as p
on c.id=p.catalog_id 

-- снижение цены мат плат********************************************

SELECT
p.name,
p.price,
p.catalog_id,
c.name
FROM shop.catalogs as  c
join 
products as p
on c.id=p.catalog_id

UPDATE 
catalogs 
join 
products 
on catalogs .id = products .catalog_id 
SET 
price = price *0.1
where catalogs .name ='Материнские платы'

name                   |price   |catalog_id|name             |
-----------------------|--------|----------|-----------------|
Intel Core i3-8100     | 6312.00|         1|Процессоры       |
Intel Core i5-7400     |10160.00|         1|Процессоры       |
AMD FX-8320E           | 3824.00|         1|Процессоры       |
AMD FX-8320            | 5696.00|         1|Процессоры       |
ASUS ROG MAXIMUS X HERO|  494.34|         2|Материнские платы|<------------снижена цена на 90%
Gigabyte H310M S2H     |  122.62|         2|Материнские платы|<------------снижена цена на 90%
MSI B250M GAMING PRO   |  129.54|         2|Материнские платы|<------------снижена цена на 90%


DELETE 
products,
catalogs
FROM catalogs 
join
products 
on catalogs .id = products .catalog_id -- id продукции будут 
-- соответствовать, id  в каталогах
-- далее уточняем еще больше что удалить платы или процессоры
where catalogs.name = 'Материнские платы'

SELECT *FROM catalogs;
id|name              |
--|------------------|
 1|Процессоры        |
 3|Видеокарты        |
 4|Жесткие диски     |
 5|Оперативная память|
 
SELECT id, name, price, catalog_id FROM shop.products;

-- id|name              |price   |catalog_id|
-- --|------------------|--------|----------|
--  1|Intel Core i3-8100| 6312.00|         1|
--  2|Intel Core i5-7400|10160.00|         1|
--  3|AMD FX-8320E      | 3824.00|         1|
--  4|AMD FX-8320       | 5696.00|         1|удалились все мат платы

delete 
products,catalogs
FROM 
catalogs 
join products on catalogs.id = products .catalog_id 
where catalogs .name ='Процессоры'

id|name              |
--|------------------|
 3|Видеокарты        |
 4|Жесткие диски     |
 5|Оперативная память|
SELECT id, name, price, catalog_id FROM shop.products;

 id|name|price|catalog_id|
--|----|-----|----------|


-- ссылочная целостность и ограничнение внешнегро ключа

ALTER table products 
add foreign key (catalog_id) -- ключ ставится там где множество (товары)
references catalogs(id)-- и ссылка указывает на родителя  catalogs
on delete no action 
on UPDATE no action ;

ALTER table products 
change catalog_id catalog_id bigint unsigned default null; 
-- для поставки ключа нужно сделать один тип данных  bigint

--   KEY `index_of_catalog_id` (`catalog_id`),
--   CONSTRAINT `products_ibfk_1` FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`)
-- ) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=u

ALTER table products 
DROP FOREIGN KEY products_ibfk_1;
 


ALTER table products 
add CONSTRAINT qwe_catalog_id
foreign key (catalog_id) -- ключ ставится там где множество (товары)
references catalogs(id)-- и ссылка указывает на родителя  catalogs
on delete no action 
on UPDATE no action ;


--  CONSTRAINT `qwe_catalog_id` 
-- FOREIGN KEY (`catalog_id`) REFERENCES `catalogs` (`id`) 



ALTER table products 
DROP FOREIGN KEY qwe_catalog_id;


alter table products
add constraint qwe_qwe_catalog_id
foreign key products(catalog_id)
references catalogs (id )
on delete cascade
on UPDATE cascade;

SELECT * FROM catalogs;

SELECT id, name, price, catalog_id FROM shop.products;

UPDATE catalogs SET id=6 WHERE name = 'Процессоры';

SELECT * FROM catalogs;
id|name              |
--|------------------|
 2|Материнские платы |
 3|Видеокарты        |
 4|Жесткие диски     |
 5|Оперативная память|
 6|Процессоры        |<------
 
 SELECT id, name, price, catalog_id FROM shop.products;
id|name                   |price   |catalog_id|
--|-----------------------|--------|----------|
 1|Intel Core i3-8100     | 7890.00|         6|<------
 2|Intel Core i5-7400     |12700.00|         6|<------
 3|AMD FX-8320E           | 4780.00|         6|<------
 4|AMD FX-8320            | 7120.00|         6|<------
 5|ASUS ROG MAXIMUS X HERO|19310.00|         2|
 6|Gigabyte H310M S2H     | 4790.00|         2|
 7|MSI B250M GAMING PRO   | 5060.00|         2|
 
 
--  если удалить раздел в таблице каталог то удалятся все товары в products

DELETE FROM shop.catalogs WHERE name ='Процессоры' ;

 SELECT * FROM catalogs;
 SELECT id, name, price, catalog_id FROM shop.products;

 ALTER table products 
DROP FOREIGN KEY qwe_qwe_catalog_id;

alter table products
add constraint qwe_qwe_catalog_id
foreign key products(catalog_id)
references catalogs (id )
on DELETE set NULL ;

DELETE FROM shop.catalogs WHERE name ='Материнские платы' ;
 SELECT * FROM catalogs;
id|name              |
--|------------------|
 3|Видеокарты        |
 4|Жесткие диски     |
 5|Оперативная память|

 SELECT id, name, price, catalog_id FROM shop.products;

-- +----+-------------------------+----------+------------+
-- | id | name                    | price    | catalog_id |
-- +----+-------------------------+----------+------------+
-- |  5 | ASUS ROG MAXIMUS X HERO | 19310.00 |       NULL |
-- |  6 | Gigabyte H310M S2H      |  4790.00 |       NULL |
-- |  7 | MSI B250M GAMING PRO    |  5060.00 |       NULL |
-- +----+-------------------------+----------+------------+
