-- триггер на вставку данных в таблицу профиль

delimiter //
drop trigger if exists profile_insert//
create trigger data_insert before insert on profile
for each row
begin
	if (isnull (new.phone) and (isnull (new.email))) then
		signal sqlstate '45000' set message_text = 'Одно из полей должно быть заполнено (email, phone)';
	end if;
end//


-- -- триггер на обновление данных в таблицу профиль

delimiter //
drop trigger if exists profile_update//
create trigger data_update before update on profile
for each row
begin
	if (isnull (new.phone) and (isnull (new.email))) then
		signal sqlstate '45000' set message_text = 'Одно из полей должно быть заполнено (email, phone)';
	end if;
end//

-- триггер на удаление данных в таблицу профиль, данные переносятся в таблицу reserve_profile

delimiter //
drop trigger if exists profile_delete//
create trigger profile_delete before delete on profile
for each row
begin
	insert into reserve_profile (user_id, is_confirmed, created_at, gender, birthday_date, homecity, email, phone, address, transport, child_info,registration_address)
	values (old.user_id, old.is_confirmed, old.created_at, old.gender, old.birthday_date, old.homecity, old.email, old.phone, old.address, old.transport, old.child_info, old.registration_address);
end//



