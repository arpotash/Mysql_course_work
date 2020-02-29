-- вычисление коэффициента активности пользователя 
-- (количество приобретенных услуг/количество лет со даты регистрации/12(среднее пользование услугами портала в год)*100


delimiter //
drop function if exists users_activity//
create function users_activity(id_user int)
returns float deterministic
begin
	declare ages int;
	declare count_sales int;

	set @ages = (select (year(current_date()) - year(created_at)) as years_from_register from profile where user_id = id_user);
	set @count_sales = (select count(id) from payment where user_id = id_user);
	return @count_sales/@ages/12*100;
end//