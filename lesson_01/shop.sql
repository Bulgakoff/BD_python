use shop;
drop table if exists catal;
create table catal(
  id SERIAL primary key,
  name varchar(255) comment 'Название раздела' 
--   unique unique_name (name(10))
) COMMENT ='Разделы интернет магазина';
-- insert into catal values (null,'proccessors');
-- insert into catal (id, name) values (null,'mat.platy');
-- insert into catal values (default,'video cards');
insert ignore into catal values
    (null,'proccessors'),
    (null,'mat.platy'),
--     (default,'video cards')
    (default,'video cards');
-- DELETE FROM catal ;
-- DELETE FROM catal where id>1 LIMIT 1;
TRUNCATE catal;/*isntade DeLETE make zero counts id*/
insert  into catal values
    (null,'proccessors'),
    (null,'mat.platy'),
--     (default,'video cards')
    (default,'video cards');
-- UPDATE 
--     catal 
-- set
--     name = 'Processors intel ';
--  WHERE 
--      name = 'proccessors';
-- SELECT * from catal;
drop table if exists cat;
create table cat(
  id SERIAL primary key,
  name varchar(255) comment 'Название раздела', 
  unique unique_name (name(10))
  )comment ='Deparments of internet shop';
insert into
    cat
select * FROM 
    catal;
select * FROM cat ;

drop table if exists users;
create table users(
  id SERIAL primary key,
  name varchar(255) comment 'Имя покупателя',
  brithday_at date comment 'дата рождения',
  created_at datetime default CURRENT_TIMESTAMP comment 'время регистрации',
  updated_at datetime  default CURRENT_TIMESTAMP comment 'ремя последнего обновления пользователя' on update  CURRENT_TIMESTAMP
) COMMENT = 'Покупателя';
 
insert into users (id, name ,brithday_at) values(1,'ВАСЯ','1973-04-18' );
select *from users;
 
drop table if exists products;
create table products(
  id SERIAL primary key,
  name varchar(255) comment 'Название',
  discription text comment 'Описание',
  price decimal (11.2) comment 'Цена',
  id_catalog int unsigned,
  created_at datetime default CURRENT_TIMESTAMP comment 'время регистрации',
  updated_at datetime  default CURRENT_TIMESTAMP   on update  CURRENT_TIMESTAMP,
  key index_id_catalog (id_catalog)
) COMMENT = 'Товарные позиции';
-- create index index_id_catalog on products(id_catalog);
-- drop index index_id_catalog on products;
-- create index index_id_catalog using BTREE on products(id_catalog);
-- create index index_id_catalog using HASH on products(id_catalog);
 
drop table if exists orders;
create table orders(
  id SERIAL primary KEY,
  users_id int unsigned,
  created_at datetime default CURRENT_TIMESTAMP comment 'время регистрации',
  updated_at datetime  default CURRENT_TIMESTAMP   on update  CURRENT_TIMESTAMP,
  key index_users_id (users_id)
) COMMENT = 'Заказы';
 
drop table if exists orders_products;
create table orders_products(
  id SERIAL primary KEY,
  users_id int unsigned,
  orders_id int unsigned,
  products_id int unsigned,
  total int unsigned default 1 comment 'Колличество заказанных товарных позиций',
  created_at datetime default CURRENT_TIMESTAMP comment 'время регистрации',
  updated_at datetime  default CURRENT_TIMESTAMP   on update  CURRENT_TIMESTAMP
--   key index_users_id (users_id)
) COMMENT = 'Состав Заказа';
 
drop table if exists discounts;
create table discounts(
  id SERIAL primary KEY,
  users_id int unsigned,
  orders_id int unsigned,
  products_id int unsigned,
  discounts FLOAT unsigned comment 'Величина скидки от 0,0 до 1,0',
  started_at datetime comment 'начало скитки',
  finished_at datetime comment 'дата окончания скидки',
  created_at datetime default CURRENT_TIMESTAMP comment 'время регистрации',
  updated_at datetime  default CURRENT_TIMESTAMP   on update  CURRENT_TIMESTAMP,
  key index_users_id (users_id),
  key index_orders_id (orders_id)
) COMMENT = 'Скидки';
 
drop table if exists store_house_products;
create table store_house_products(
  id SERIAL primary KEY,
  users_id int unsigned,
  id_store_house_products int unsigned,
  products_id int unsigned,
  value int unsigned comment 'Запас тованой позиции хранимый на складе',
  created_at datetime default CURRENT_TIMESTAMP comment 'время регистрации',
  updated_at datetime  default CURRENT_TIMESTAMP   on update  CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';