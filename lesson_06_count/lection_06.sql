-- лекция № 6
SELECT id, firstname, lastname, 
(SELECT hometown FROM vk.profiles where user_id = users.id ),
(SELECT filename FROM vk.media where id = 
        (SELECT  photo_id FROM vk.profiles where  user_id = users.id)
)
 FROM vk.users;

SELECT id, name, created_at FROM vk.media_types ;
-- =====================================0 25 41===========================

-- получим фото
SELECT * FROM media where user_id = (SELECT id  FROM users where email = 'arlo50@example.org') 
and media_type_id = (SELECT id FROM media_types where name = 'post');

--  выбираем видео новости указанного пользователя

SELECT * FROM media where user_id =1 and (filename LIKE '%.mp4' 
OR filename LIKE '%.avi');

-- подсчитать колтчество этого пользоватеоя
SELECT COUNT(*) FROM media where user_id =1 and filename like '%.jpg' ;

SELECT COUNT(*) FROM media where user_id =1 and media_type_id = 2;

-- количество новостей каждого типа 

SELECT COUNT(*),
media_type_id,
(SELECT name FROM media_types where id = media.media_type_id )
FROM media  GROUP BY media_type_id ;

-- --+
-- | COUNT(*) | media_type_id | (SELECT name FROM media_types where id = media.media_type_id ) |
-- +----------+---------------+----------------------------------------------------------------+
-- |       26 |             1 | Photo                                                          |
-- |       25 |             2 | Music                                                          |
-- |       24 |             3 | Video                                                          |
-- |       25 |             4 | Post   


-- архив новостей по месяцам - выборка вида
SELECT  
	COUNT(*) qwe1,
-- 	monthname(created_at)
	MONTH(created_at ) qwe2
FROM media
group by MONTH(created_at ) order by MONTH(created_at ) DESC ;

-- сколько новостей у каждого пользователя

SELECT 
COUNT(*) qwe1,
user_id 
FROM media
group by user_id 
order by qwe1 DESC 

-- выбыраем друзей пользвоателя
SELECT *
-- initiator_user_id, target_user_id, status, requested_at, confirmed_at
FROM vk.friend_requests 
where (initiator_user_id = 1 or target_user_id =1)  and status = 'approved';


-- выбираем новости друзей
SELECT *
-- id, media_type_id, user_id, body, filename, `size`, metadata, created_at, updated_at
FROM vk.media where user_id in (-- 2,22,33,45
		SELECT initiator_user_id
FROM vk.friend_requests where target_user_id = 1 and status = 'approved'
 UNION 
 SELECT target_user_id 
FROM vk.friend_requests where initiator_user_id = 1 and status = 'approved'
)
or user_id =1
order by created_at desc
;

-- подсчитать лайки для моих (моих медиа)новостей

SELECT 
COUNT(*),
media_id
-- user_id 
-- id, user_id, media_id, created_at
FROM vk.likes where media_id in ( -- 1
		SELECT id 
-- 		id, media_type_id, user_id, body, filename, `size`, metadata, created_at, updated_at
        FROM vk.media where user_id =1)
group by media_id;
-- | COUNT(*) | media_id |
-- +----------+----------+
-- |        4 |        1 |
-- |        1 |       11 |
-- |        1 |       12 |
-- |        1 |       13 |
-- |        1 |       14 |
-- +----------+----------+
-- ==========================1 27 11 -========================

-- выбираем сообщения от пользователя ко мне и от меня
SELECT *
-- id, from_user_id, to_user_id, body, created_at
FROM vk.messages where from_user_id in (2) or to_user_id in (2);

SELECT *
-- id, from_user_id, to_user_id, body, created_at
FROM vk.messages where to_user_id in (1) and is_read =0;

UPDATE vk.messages
SET is_read=1
-- from_user_id=0, to_user_id=0, body='',
--  created_at=CURRENT_TIMESTAMP, is_read=b'0', is_deleted=b'0'
WHERE to_user_id in (1) and from_user_id in (2);

SELECT from_user_id, is_read
-- id, from_user_id, to_user_id, body, created_at
FROM vk.messages where to_user_id in (1) and is_read =1;
-- +--------------+------------------+
-- | from_user_id | is_read          |
-- +--------------+------------------+
-- |            2 | 0x01             |
-- |            2 | 0x01             |
-- +--------------+------------------+

-- выводим друзей пользователя с преобразоание пола и подсчетом возраста
SELECT 
user_id ,
case(gender )
 when 'm'then 'мужской'
  when 'f'then 'женский'
  ELSE 'средний'
end qwe,
gender ,
timestampdiff(YEAR,birthday,NOW()) as'age'
-- user_id, gender, birthday, photo_id, created_at, hometown
FROM vk.profiles where user_id in (-- 2,22,33,45
		SELECT initiator_user_id
FROM vk.friend_requests where target_user_id = 1 and status = 'approved'
 UNION 
 SELECT target_user_id 
FROM vk.friend_requests where initiator_user_id = 1 and status = 'approved'
);
SELECT 26= (
	SELECT admin_user_id
-- 	id, name, admin_user_id
	FROM vk.communities where id=5
) as 'is_admin'
