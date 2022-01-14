use shop;

-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

select u.id, o.user_id
from 
  users as u 
JOIN
  orders as o 
ON u.id = o.user_id;

-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.name as product_name, c.name as catalog_name 
FROM 
  products as p
join
  catalogs as c
on p.catalog_id = c.id;

/*(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов
 cities (label, name). Поля from, to и label содержат английские названия городов, поле
 name — русское. Выведите список рейсов flights с русскими названиями городов.
*/
DROP DATABASE IF EXISTS flights;
CREATE DATABASE flights;
USE flights;

drop table if exists flights;
create table flights (
  id SERIAL primary key,
  from_1 varchar(20),
  to_2 varchar(20));
insert into flights values(1, 'moscow', 'omsk'),(2, 'novgorod', 'kazan'),(3, 'irkutsk', 'moscow'),(4, 'omsk', 'irkutsk'),(5, 'moscow', 'kazan');

drop table if exists cities;
create table cities (
  label varchar(20),
  name varchar(20));
  
insert into cities values('moscow', 'москва'),('irkutsk', 'иркутск'),('novgorod', 'новгород'),('kazan', 'казань'),('omsk', 'омск');


select id, (SELECT name from cities where label = f.from_1) as from_, c.name as to_ 
from flights as f left join cities as c
on f.to_2 = c.label;
