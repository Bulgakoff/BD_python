USE vk;
/*****Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение”*****/
-- 
-- 
-- ******************************************
-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
-- Если полей не было совсем как у меня, то
ALTER TABLE users ADD created_at DATETIME DEFAULT now() NOT NULL; 
ALTER TABLE users ADD updated_at DATETIME DEFAULT now() ON UPDATE now() NOT NULL;
/* -- Если поля были, но не были заполнены
UPDATE users 
set created_at = now(), updated_at = now();
*/
-- 
-- 
-- 
-- ******************************************
-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались 
-- значения в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
-- СИМУЛЯЦИЯ СИТУАЦИИ
ALTER TABLE users CHANGE created_at `__created_at` datetime DEFAULT CURRENT_TIMESTAMP NOT NULL;
ALTER TABLE users CHANGE updated_at `__updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL;
Update users
SET `__created_at` =  DATE_ADD(now(), INTERVAL -floor(rand()*1000) DAY);
    
ALTER TABLE users ADD created_at  varchar(30) NOT NULL;
ALTER TABLE users ADD updated_at  varchar(30) NOT NULL;
Update users
SET `created_at` = DATE_FORMAT(__created_at,'%d.%m.%Y %k:%i'),
    `updated_at` = DATE_FORMAT(DATE_ADD(now(), INTERVAL -floor(rand()*1000) DAY),'%d.%m.%Y %k:%i');
 ALTER TABLE vk.users DROP COLUMN `__created_at`;
 ALTER TABLE vk.users DROP COLUMN `__updated_at`;
-- КОНЕЦ СИМУЛЯЦИИ СИТУАЦИИ 
-- ПРОВЕРКА select * from users
ALTER TABLE users ADD _created_at DATETIME NULL; 
ALTER TABLE users ADD _updated_at DATETIME NULL;
UPDATE users
set _created_at =  STR_TO_DATE(created_at,'%d.%m.%Y %k:%i'),
	_updated_at =  STR_TO_DATE(updated_at,'%d.%m.%Y %k:%i');
-- ПРОВЕРКА что все перенеслось корректно 
-- select * from users
ALTER TABLE vk.users DROP COLUMN `created_at`;
ALTER TABLE vk.users DROP COLUMN `updated_at`;
ALTER TABLE users CHANGE _created_at `created_at` datetime DEFAULT CURRENT_TIMESTAMP NOT NULL;
ALTER TABLE users CHANGE _updated_at `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL;
-- 
-- 
-- 
-- ******************************************
-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился 
-- и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения 
-- значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
-- КАРТИНКА
-- СИМУЛЯЦИЯ СИТУАЦИИ
Drop table if Exists storehouses_products;
CREATE TABLE storehouses_products (id BIGINT UNSIGNED auto_increment NOT NULL,Value BIGINT UNSIGNED DEFAULT 0 NOT NULL,CONSTRAINT storehouses_products_PK PRIMARY KEY (id)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
insert into storehouses_products (Value) values (12),(3),(2),(0),(0),(0);
-- КОНЕЦ СИМУЛЯЦИИ СИТУАЦИИ
select * from storehouses_products
Order by if (value = 0, 999999999999999, value);
-- Подчищаем в БД
Drop table if Exists storehouses_products;
-- 
-- 
-- ******************************************
-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')
select * from users a
join profiles b on a.id = b. user_id 
where LOWER(DATE_FORMAT(birthday,'%M')) in ('may','august');
-- 
-- 
-- ******************************************
-- 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, 
-- заданном в списке IN.
-- ЧТО БЫ НЕ ГОРОДИТЬ НОВЫХ ТАБЛИЦ ИСПОЛЬЗУЕМ ПОДХОДЯЩУЮ `users_communities`
select * from users_communities
where community_id in (5,1,2)
order by FIELD (community_id, 5, 1, 2);
-- 
-- 
-- 
-- 
-- /***********************************************Практическое задание теме “Агрегация данных”*****************************/
-- 1. Подсчитайте средний возраст пользователей в таблице users
select round(avg(Year(Now())-Year(birthday) + if (DAYOFYEAR(Now()) >= DAYOFYEAR(birthday),1,0)),0) 
from users a
join profiles b on a.id = b.user_id;
-- 
-- 
-- ******************************************
-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы 
-- дни недели текущего года, а не года рождения.
select DAYOFWEEK(MAKEDATE(Year(now()),DAYOFYEAR(birthday))) as BirthdayOfWeek, count(*)
from users a
join profiles b on a.id = b.user_id
Group by BirthdayOfWeek
Order by 1;
-- select DAYOFWEEK(NOW());
-- 
-- 
-- ******************************************
-- 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы
select exp(SUM(log(ID))) 
from vk.media_types
where id <= 8;


