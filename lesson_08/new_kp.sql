
DROP database if exists kp;
create database kp;
use kp;



DROP TABLE IF EXISTS `cinemas`;
CREATE TABLE `cinemas` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название раздела',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`(10))
) ENGINE=InnoDB AUTO_INCREMENT=6 
DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Разделы';













-- kp.film_types definition
DROP TABLE IF EXISTS `film_types`;
CREATE TABLE `film_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;








-- kp.films definition
DROP TABLE IF EXISTS `films`;
CREATE TABLE `films` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Название',
  `desription` text COMMENT 'Описание',
  `price` decimal(11,2) DEFAULT NULL COMMENT 'Цена',
  `cinemas_id` bigint unsigned DEFAULT NULL,
  `tipes_film_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cinemas_id` (`cinemas_id`),
  KEY `tipes_film_id` (`tipes_film_id`),
  CONSTRAINT `media_ibfk_1` FOREIGN KEY (`cinemas_id`) REFERENCES `cinemas` (`id`),
  CONSTRAINT `media_ibfk_6` FOREIGN KEY (`tipes_film_id`) REFERENCES `film_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT=' позиции';



-- kp.showings definition
DROP TABLE IF EXISTS `showings`;
CREATE TABLE `showings` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT 'Название раздела',
  `cinemas_id` bigint unsigned DEFAULT NULL,
  `films_id` bigint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`(10)),
  KEY `media_ibfk_2` (`cinemas_id`),
  KEY `media_ibfk_3` (`films_id`),
  CONSTRAINT `media_ibfk_2` FOREIGN KEY (`cinemas_id`) REFERENCES `cinemas` (`id`),
  CONSTRAINT `media_ibfk_3` FOREIGN KEY (`films_id`) REFERENCES `films` (`cinemas_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Разделы';

























-- kp.users_cinema definition
DROP TABLE IF EXISTS `users_cinema`;
CREATE TABLE `users_cinema` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'Фамиль',
  `email` varchar(120) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `users_firstname_lastname_idx` (`firstname`,`lastname`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;





















