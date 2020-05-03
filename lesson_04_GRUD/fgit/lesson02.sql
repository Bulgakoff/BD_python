use vk;
-- GRUD: insert delete select  update
-- insert users(first_name,sec_name,email,phone)
-- values ('Petro',default,'qwe19@mail.ru',464987313);

-- insert users
-- values (10, 'Petro',default,'qwe20@mail.ru','464987313'); -- точное кол фргументов нужно 
--  -- если не указывается столбец таблицы , нельзя перепутывать данные
 
-- здесь легко ошибиться(но основное этого синтаксиса вставлять данные пакетно)

-- insert users(first_name,sec_name,email,phone)
-- values 
-- ('Иван',default,'qwe21@mail.ru',464987313),
-- ('Bon',default,'qwe22@mail.ru',464987313),
-- ('VOv',default,'qwe23@mail.ru',464987313),
-- ('ETD','qweqwe','qwe24@mail.ru',464987313);

-- insert into `users`-- эото если вставляется лтолько одна строчка более 
-- наглядноо такой синтаксис
-- set 
-- 	`first_name` = 'Bonqwe',
-- 	sec_name = 'Qweqwe',
-- 	`email` = 'qwe2qwe2@mail.ru',
-- 	`phone` = 464681351

-- insert into users 
--    (id,first_name,sec_name,email,phone)
-- SELECT 
--    '101', 'Petro','bdghdhghdh','qwe201@mail.ru','464987313'
--   ;

-- 
-- insert into users 
--    (sec_name)
-- SELECT 
-- names_users
-- FROM vk_dz.users_vk; -- соответствие колонон адресатов и источника

-- SELECT 
-- *
-- FROM users;
-- 
-- SELECT "helloqwe"

-- select DISTINCT first_name -- а уникальных DISTINCT имен меньше
-- FROM users;
-- select 
-- * 
-- FROM users
-- where id<9;

select 
* 
FROM users
limit 4
