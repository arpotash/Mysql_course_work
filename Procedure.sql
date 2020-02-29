delimiter //

drop procedure if exists payment_process//
create procedure payment_process(in payer_id int, in service_id int, in cart_id int)
begin
	set @money = (select amount from payment_cart where id = cart_id);
	set @price = (select price from services where id = service_id);
	if (@money >= @price) then
		update payment_cart set amount = amount - @price where id = cart_id;
		insert into payment(user_id, services_id, payment_cart_id , create_pay) 
		values (payer_id, service_id, cart_id, now());
	else
		signal sqlstate 'HY008' SET Message_text = 'Недостаточно средств на карте!';
	end if;
end//
