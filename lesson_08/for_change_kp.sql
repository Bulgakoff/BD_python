-- for change
use kp;

SELECT id, name FROM kp.cinemas;

id|name   |
--|-------|
 1|Прага  |
 2|Варшава|
 3|Ролан  |
 4|Союз   |
 5|Ударник|

SELECT id, name, desription, price, cinemas_id FROM kp.films;

id|name               |desription                    |price  |cinemas_id|
--|-------------------|------------------------------|-------|----------|
 1|Миссия не выполнима|Фильм о супер агентах         | 350.00|         2|
 2|Дракула            |Фильм о супер вампирах        | 400.00|         2|
 3|Воин ветра         |Фильм о карате                | 200.00|         4|
 4|История игрушек    |мультФильм об игрушках        | 100.00|         1|
 5|Храброе сердце     |Исторические события шотландии|1000.00|         2|
 
SELECT id, name FROM kp.showings;

id|name|
--|----|

SELECT id, firstname, lastname, email, phone FROM kp.users_cinema;

id|firstname|lastname|email|phone|
--|---------|--------|-----|-----|



