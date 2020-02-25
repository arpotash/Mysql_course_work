-- Вывести информацию о об услуге, цене, ее категории, стоиомсти, с какой карты произведена оплата и кем

create or replace view service_info (`name`, `category`, `price`, `owner`, `cart`, `date_payment`)
as select s.name, sc.name, s.price, concat(u.firstname, ' ', u.lastname), concat(pc.name, ' ', pc.type_cart), py.create_pay from payment py
join services s on py.services_id = s.id
join services_category sc on s.category_service_id = sc.id
join payment_cart pc on py.payment_cart_id = pc.id
join users u on py.user_id = u.id
select * from service_info

-- Вывести пользователей, которые активировали больше 2 документов

create or replace view users_docs (`count`, `user_id`)
as select count(dc.id), u.id
from users u
join documents dc on
u.id = dc.user_id
where dc.is_confirmed = 1
group by u.id
having count(dc.id) > 2
select * from users_docs

-- Вывести самого активного пользователя (больше всего уведомлений)

create or replace view active_user (`id`, `name`, `count_notifications`)
as select u.id, concat(u.firstname, ' ', u.lastname) as name, count(nf.id) 
from users u
join profile p on u.id = p.user_id
join notifications nf on u.id = nf.user_id
group by u.id
order by count(nf.id) desc limit 1
select * from active_user
