use e_ticaret

create database e_ticaret

create table USERS
(
id int primary key identity(1,1),
user_name_ varchar(10) not null,
password_ varchar(10) not null,
full_name varchar(20) not null,
email varchar(20) not null, 
gender char(1) check(gender = 'E' or gender = 'K'),
birthdate date not null, 
phone_number char(10) not null check(phone_number not like '0%')
)

insert into USERS(user_name_,password_,full_name,email,gender,birthdate,phone_number)
values('mc_es','12345','Mehmetcan ESER','ceser@gmail.com','E','2001-08-08','5340755058'),
('emos','123','Emirhan ESER','emos@gmail.com','E','2009-07-30','5356344577'),
('fiko58','fiko5858','Furkan ESER','fiko58@gmail.com','E','2003-01-23','5353456435'),
('hoca','hoca58','Nihat ESER','hocam58@gmail.com','E','1972-10-09','5374694518'),
('fatos','fatos58','Fatma ESER','fatos58@gmail.com','K','1977-07-15','5393070107')


create table COUNTRIES
(
id tinyint primary key identity(1,1),
country varchar(20) not null
)

insert into COUNTRIES(country)
values('Türkiye'),('A.B.D'),('Almanya'),('Ýngiltere'),('Ýspanya')


create table CITIES
(
id smallint primary key identity(1,1),
country_id tinyint foreign key references COUNTRIES(id),
city varchar(20) not null
)

insert into CITIES(country_id,city)
values(1,'Ýstanbul'),(1,'Sivas'),(1,'Balýkesir'),(2,'New York'),(2,'Nevada'),(3,'Berlin'),(3,'Munih'),(4,'Londra'),
(4,'Liverpool'),(5,'Madrid'),(5,'Barcelona')


create table ADDRESSES
(
id int primary key identity(1,1),
user_id_ int foreign key references USERS(id),
country_id tinyint foreign key references COUNTRIES(id),
city_id smallint foreign key references CITIES(id),
post_code varchar(10),
address_text varchar(50)
)

insert into ADDRESSES(user_id_,country_id,city_id,post_code,address_text)
values(1,1,1,58100,'...'),(1,1,2,12434,'...'),(2,1,1,43545,'...'),(2,5,10,56434,'...'),(3,4,9,32543,'...'),
(4,2,4,23435,'...'),(5,5,11,12345,'...')


create table PRODUCTS
(
id int primary key identity(1,1),
code varchar(10) not null unique,
name_ varchar(15) not null,
unit_price float not null check(unit_price >= 0),
brand varchar(20) not null
)

insert into PRODUCTS(code,name_,unit_price,brand)
values('ulk101','Ülker Albeni',	4,'Ülker'),('eti101','Eti Burçak',5,'Eti'),('clgt101','Diþ Macunu',2599,'Colgate'),
('fbctl101','Kýrmýzý kalem',3,'Faber Castel')


create table ORDERS
(
id int primary key identity(1,1),
user_id_ int foreign key references USERS(id),
address_id int foreign key references ADDRESSES(id),
date_ date not null,
total_price float not null check(total_price >= 0)
)
insert into ORDERS(user_id_,address_id,date_,total_price)
values(1,1,1,'2022-04-14',2599),(2,1,2,'2020-02-02',3),(3,2,3,'2019-05-13',4)

