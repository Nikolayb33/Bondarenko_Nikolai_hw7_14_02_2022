use vk;
-- 1) пусть задан пользователь, из всех друзей найдите, кто больше всего с ним общался

-- 1.1) кто из друзей больше всего отправил сообщений 

SELECT from_user_id, count(id) FROM messages WHERE from_user_id IN ( 
 SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 1) AND status='approved' -- ИД друзей, заявку которых я подтвердил
 union
 SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 1) AND status='approved' -- ИД друзей, подтвердивших мою заявку
)
group by from_user_id
order by count(id) desc;

-- 1.2) кто из друзей больше всего получил сообщений

SELECT to_user_id , count(id) FROM messages WHERE to_user_id IN (  
 SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 1) AND status='approved' -- ИД друзей, заявку которых я подтвердил
 union
 SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 1) AND status='approved' -- ИД друзей, подтвердивших мою заявку
)
group by to_user_id
order by count(id) desc;

-- 2) подсчитайте общее количество лайков, которые получили пользователи младше 11 лет

select
  count(id) as younger_11
  from likes
  where user_id in 
    (select id from users where 
      (select user_id from profiles where user_id = users.id and timestampdiff(YEAR, birthday, NOW()) < 11));

-- 3) посчитать кто больше всего поставил лайков, мужчины или женщины
 
select count(id) as cnt, (select gender from profiles where user_id in (select id from users where id = likes.user_id)) as gender
from likes
where id IN 
  (select id from users WHERE
    (select user_id from profiles where user_id = users.id))
group by gender
limit 1;