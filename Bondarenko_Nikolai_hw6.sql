use vk;
-- 1) пусть задан пользователь, из всех друзей найдите, кто больше всего с ним общался
-- указал получателя

SELECT from_user_id, count(id), to_user_id FROM messages WHERE from_user_id IN ( 
 SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 1) AND status='approved' -- ИД друзей, заявку которых я подтвердил
 union
 SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 1) AND status='approved' -- ИД друзей, подтвердивших мою заявку
) and to_user_id = 1
group by from_user_id
order by count(id) desc;


-- 2) подсчитайте общее количество лайков, которые получили пользователи младше 11 лет
-- исправил, нашел кто лайкает 

select count(id) as younger_11
from likes
where media_id in 
  (select id from media where user_id in
    (select id from users where id in
      (SELECT user_id from profiles where user_id = users.id and timestampdiff(YEAR, birthday, NOW()) < 11)));

-- 3) посчитать кто больше всего поставил лайков, мужчины или женщины
 
select count(id) as cnt, (select gender from profiles where user_id in (select id from users where id = likes.user_id)) as gender
from likes
where id IN 
  (select id from users WHERE
    (select user_id from profiles where user_id = users.id))
group by gender
limit 1;