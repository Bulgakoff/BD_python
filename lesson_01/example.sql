use example;
drop table if exists users; 
CREATE table  users(
  id SERIAL primary key,
  name varchar(255)
);
insert into users (name) values ('qweqwe');
insert into users (name) values ('sdfsfvdsfdf');