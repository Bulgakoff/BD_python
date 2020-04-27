DROP database if exists vk_dz;
create database vk_dz;
use vk_dz;
drop table if exists users_vk;
create table users_vk(
    num_users SERIAL primary key,
    names_users varchar (100),
    index (names_users)
);     
-- исходник  таблиц  получается в основном profile_vk
drop table if exists profile_vk;
create table profile_vk(
    num_body SERIAL primary key,
    gender char(1), 
    birthday date, 
    photo_id bigint unsigned default null,
    home_town varchar (100),
    created_at datetime default now(),
    foreign key(num_body) references users_vk(num_users)
); 
 
 drop table if exists foo_profile;
 create table foo_profile(
     num_body_foo SERIAL primary key,
     name_user_profile varchar(100),
     support varchar (100),
     foreign key (num_body_foo) references profile_vk(num_body)
);

drop table if exists support;
create table support(
    id_body_support SERIAL primary key,  
    guide varchar (100), -- наименование поля "справочник" например
    my_questions varchar (100) , -- название таблицы репозитория "Мои вопросы"
    question_field text, -- поле для ввода текста вопросов
    created_question_text_at datetime  default now(),
    created_question_video_at datetime  default now(),
    video varchar(100),
    foreign key (id_body_support) references foo_profile(num_body_foo)
);



drop table if exists  id_questions;
create table id_questions(
     id SERIAL primary key,
     user_question_id bigint unsigned not null,
     media_question_id bigint unsigned not null,
     foreign key (media_question_id) references support(id_body_support),
     foreign key (user_question_id) references profile_vk(num_body)
);

drop table if exists repo_my_questions; -- хранилище вопросов (тектом, видообращение)
create table repo_my_questions(
    id_repo_my_questions SERIAL primary key,
    my_questions varchar(100),
    foreign key (id_repo_my_questions) references id_questions(id)
);
