-- процесс покупки пользователем услуги со снятием средств с платежной карты

delimiter //
drop procedure if exists payment_process//
create procedure payment_process(in service_id int, in cart_id int)
begin
	set @money = (select amount from payment_cart where id = cart_id);
	set @price = (select price from services where id = service_id);
	set @discout = (select discount from services where id = service_id);
	set @payer_id = (select user_id from payment_cart where id = cart_id);
	if (@money >= @price) then
		update payment_cart set amount = amount - (@price - (@price*@discout/100)) where id = cart_id;
		insert into payment(user_id, services_id, payment_cart_id , create_pay) 
		values (@payer_id, service_id, cart_id, now());
	else
		signal sqlstate 'HY008' SET Message_text = 'Недостаточно средств на карте!';
	end if;
end//






