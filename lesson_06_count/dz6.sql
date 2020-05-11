-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”. Работаем с БД vk и данными, которые вы сгенерировали ранее:
-- 
--     1.Пусть задан некоторый пользователь №1. 
-- Из всех друзей этого пользователя найдите человека,
-- который больше всех общался с нашим пользователем.

SELECT 
COUNT(*) Письма,
from_user_id 
-- id, from_user_id, to_user_id, body, created_at, is_read, is_deleted
FROM vk.messages where to_user_id = 1 group by from_user_id ORDER by Письма DESC limit 1;
-- +--------------+--------------+
-- | Письма       | from_user_id |
-- +--------------+--------------+
-- |            9 |            8 |--9 Писем от пользоваля №8 к №1
-- +--------------+--------------+
SELECT 
COUNT(*) Письма,
to_user_id 
-- id, from_user_id, to_user_id, body, created_at, is_read, is_deleted
FROM vk.messages where from_user_id = 1 group by to_user_id ORDER by  Письма DESC  limit 1;

-- +--------------+------------+
-- | Письма       | to_user_id |
-- +--------------+------------+
-- |            1 |          2 |  -- 1 письмо от №1 к № 2
-- +--------------+------------+


--     2.Подсчитать общее количество лайков, 
-- которые получили пользователи младше 10 лет..

SELECT 
COUNT(*) лайки,
user_id 
-- id, user_id, media_id, created_at
FROM vk.likes where user_id in 
	(SELECT user_id
-- 	id, media_type_id, user_id, body, filename, `size`, metadata, created_at, updated_at
	FROM vk.media where user_id in 
		(SELECT user_id 
-- 		user_id, gender, birthday, photo_id, created_at, hometown
		FROM vk.profiles where timestampdiff(YEAR,birthday ,NOW())<10)
)
GROUP BY user_id
WITH ROLLUP ; 

-- +------------+---------+
-- | лайки      | user_id |
-- +------------+---------+
-- |          1 |       2 |
-- |          1 |       7 |
-- |          2 |    NULL | 2 лaйка 
-- +------------+---------+



	
--     3.Определить кто больше поставил лайков (всего): мужчины или женщины.

	
SELECT *
-- COUNT(*)
-- id, user_id, media_id, created_at
FROM vk.likes where user_id in(
	SELECT id 
-- 	id, firstname, lastname, email, phone
	FROM vk.users where id in (
		SELECT user_id
-- 		user_id, gender, birthday, photo_id, created_at, hometown
		FROM vk.profiles where gender='m' ) -- gender='f' == 10 лайков женщины
)
order by media_id; -- 4 лака поставили мужчины


-- больш елайков поставили женщины == 10 шт
