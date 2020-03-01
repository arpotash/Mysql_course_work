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

-- триггер регистрации пользователя

delimiter //
drop trigger if exists user_register//
create trigger user_register after insert on users
for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.id, now(), concat(new.firstname, ' ', new.lastname), 'users');
end//

-- триггер изменения данных пользователя

delimiter //
drop trigger if exists user_updating//
create trigger user_updating after update on users
for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.id, now(), concat(new.firstname, ' ', new.lastname), 'users');
end//

-- триггер заполнения профиля

delimiter //
drop trigger if exists inserting_profile//
create trigger inserting_profile after insert on profile
for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.user_id, now(), new.email, 'profile');
end//

-- триггер обновления профиля

delimiter //
drop trigger if exists updating_profile//
create trigger updating_profile after update on profile
for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.user_id, now(), new.email, 'profile');
end//

-- триггер добавления фото

delimiter //
drop trigger if exists inserting_photo//
create trigger inserting_photo after insert on photo
for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.id, now(), new.filename, 'photo');
end//

-- триггер обновления фото

delimiter //
drop trigger if exists updating_photo//
create trigger updating_photo after update on photo
for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.id, now(), new.filename, 'photo');
end//

-- триггер добавления документа

delimiter //
drop trigger if exists inserting_document//
create trigger inserting_document after insert on documents
for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.id, now(), new.num, 'documents');
end//

-- триггер обновления документа

delimiter //
drop trigger if exists updating_document//
create trigger updating_document after insert on documents
for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.id, now(), new.num, 'documents');
end//



-- триггер добавления платежной карты пользователя

delimiter //
drop trigger if exists inserting_payment_cart//
create trigger inserting_payment_cart after insert on payment_cart
for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.id, now(), new.name, 'payment_cart');
end//

-- триггер обновления платежной карты пользователя

delimiter //
drop trigger if exists updating_payment_cart//
create trigger updating_payment_cart after insert on payment_cart
for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.id, now(), new.name, 'payment_cart');
end//

-- триггер добавления платежа

delimiter //
drop trigger if exists inserting_payment//
create trigger updating_payment after insert on payment
for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.id, now(), concat(user_id, ' ', services_id), 'payment');
end//

-- тригер добавления услуги

delimiter //
drop trigger if exists inserting_services//
create trigger updating_services after insert on services
for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.id, now(), name, 'services');
end//


-- тригер обновления услуги

delimiter //
	drop trigger if exists updating_service//
	create trigger updating_service after insert on services
	for each row
begin
	insert into logs (col_id, created_at, name, table_name) values (new.id, now(), name, 'services');
end//

