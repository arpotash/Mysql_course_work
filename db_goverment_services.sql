drop table if exists users;
create table users (
	id serial primary key,
	firstname varchar(255),
	lastname varchar(255),
	
	index firstname_lastname_idx(firstname,lastname)
);

drop table if exists profile;
create table profile(
	user_id bigint unsigned not null,
	is_confirmed bit default false,
	photo_id bigint unsigned,
	created_at datetime default current_timestamp(),
	updated_at datetime default current_timestamp(),
	gender bit,
	birthday_date date,
	homecity varchar(255),
	email varchar(255) unique,
	phone bigint unique,
	address varchar(255),
	transport varchar(255),
	child_info varchar(255),
	registration_address varchar(255),
	
	index homecity_idx(homecity),
	foreign key (user_id) references users(id) on update cascade
);



drop table if exists notifications;
create table notifications (
	id serial primary key,
	name varchar(255),
	body text,
	user_id bigint unsigned not null,
	
	foreign key (user_id) references users(id)
);

drop table if exists document_type;
create table document_type (
	id serial primary key,
	name varchar(255),
	
	index docname_idx(name)
);

drop table if exists documents;
create table documents (
	id serial primary key,
	body varchar(255),
	is_confirmed bit default false,
	document_type_id bigint unsigned not null,
	user_id bigint unsigned not null,
	
	index docowner_idx(user_id),
	index doctype_idx(document_type_id),
	foreign key (user_id) references users(id),
	foreign key (document_type_id) references document_type(id)
);

drop table if exists services_category;
create table services_category (
	id serial primary key,
	name varchar(255),
	
	index servicename_idx(name)
);

drop table if exists services;
create table services (
	id serial primary key,
	user_id bigint unsigned,
	category_service_id bigint unsigned not null,
	created_at datetime default now(),
	updated_at datetime default now(),
	
	index ownerserv_idx(user_id),
	foreign key (category_service_id) references services_category(id),
	foreign key (user_id) references users(id)
);

drop table if exists payment_cart;
create table payment_cart (
	id serial primary key,
	name varchar(255),
	user_id bigint unsigned not null,
	
	index ownercart_idx (user_id),
	foreign key (user_id) references users(id)
);

drop table if exists payment;
create table payment (
	id serial primary key,
	user_id bigint unsigned not null,
	services_id bigint unsigned not null,
	payment_cart_id bigint unsigned,
	
	index ownerpayment_idx(user_id),
	index paymentgoal_idx(services_id),
	foreign key (user_id) references users(id),
	foreign key (services_id) references services(id),
	foreign key (payment_cart_id) references payment_cart(id)
);
