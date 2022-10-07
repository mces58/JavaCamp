-- Bu derste Joinler ve turleri, Joinler ile update ve delete yapma
-- ve UNION konusu islemleri islenmistir

use e_ticaret

-- biz her kullanicinin adresini bir tabloda gormek istiyorsak bu yontem ise yaramaz cunku 
-- bu yontem iki tablo getirir dolayýsýyla birlestirmemiz lazým
select * from USERS
select * from ADDRESSES
----------------------------------------------------------------------

-- burada where kosulunu kullanarak her kullanicinin adresini bir tabloda gorduk
select USERS.*, ADDRESSES.address_text from USERS,ADDRESSES 
where USERS.id = ADDRESSES.user_id_
----------------------------------------------------------------------

-- bu sorguda ise id = 1 olan kullanicinin adreslerini goruntuledik
-- temel anlamda iliskisel veri tabanlarini býrlestirip sorgu cekmenin en temel yontemi budur
-- temel yapýyý yazacak olursak
-- select A.Kolon1, A.Kolon2, B.Kolon1, B.Kolon2... from A, B where A.PK = B.FK seklindedir 
select USERS.*, ADDRESSES.address_text from USERS,ADDRESSES
where USERS.id = ADDRESSES.user_id_ and USERS.id = 1
-----------------------------------------------------------------------

--Alias kullanýmý

--yukarýdaki sorguda tablo adlarýný her defasýnda uzun uzun yazýyoruz alias kullanarak 
--bu tablo adlarýna bir kýsaltma verebiliriz ve alias ile sutunlarýn baslýklarýnýda takma ad verebiliriz
--tablolara takma ad vermek icin from tablo_adi as takma_ad seklinde bir format izlenebilir 

select U.full_name, U.birthdate, U.gender, U.phone_number, 
A.address_text
from USERS as U, ADDRESSES as A
where U.id = A.user_id_ and U.id = 1
-------------------------------------------------------------------------------

--yukarýda ki sorgu da sutunlara bir takma ad vermedik burada ise hem tablolara hem de
--sutunlara bir takma ad verelim

select U.full_name as [Ad Soyad], U.birthdate as [Doðum Tarihi], U.gender as Cinsiyet, U.phone_number as [Telefon Numarasý],
A.address_text as [Açýk Adresi]
from USERS as U, ADDRESSES as A
where U.id = A.user_id_ and U.id = 1

-- sutunlara verilen takma isimler ise sutunlarýn adlarýndan sonra geliyor ayrýca bazý yerlerde 
-- koseli parantez kullanildi. Bunun anlamý aralarýnda bosluk olan kelimeleri sql'e bir kelimeymis diye
-- gostermek (Ad Soyad aralarýnda bir bosluk var)

-------------------------------------------------------------------------------

-- biz kullanicilarýn sadece adreslerini degil ulke il ilce gibi ozelliklerini de gormek istiyorsak
-- bunun icin en temel anlamla diger tablolarýda where kosulu ile baglayabiliriz

select 
U.full_name as [Ad Soyad],
U.birthdate as [Doðum Tarihi],
U.gender as Cinsiyet,
U.phone_number as [Telefon Numarasý],
A.address_text as [Açýk Adres],
C.country as Ülke,
CT.city as Þehir
from USERS as U, ADDRESSES as A, COUNTRIES as C, CITIES as CT
where 
U.id = A.user_id_ and 
C.id = A.country_id and
CT.id = A.city_id
order by U.full_name

----------------------------------------------------------------------------------

-- her kullanicinin adres sayýsýný ve bu adreslerin kac tane ulkede oldgunu bulan sorgu
select 
U.full_name, count(A.id) as [Adres Sayýsý], count(distinct C.country) as [Ülke Sayýsý]
from USERS as U, ADDRESSES as A, COUNTRIES as C, CITIES as CT
where 
U.id = A.user_id_ and 
C.id = A.country_id and
CT.id = A.city_id

group by U.full_name

--------------------------------------------------------------------------------
-- ikiye esit veya daha fazla adresi olan kullanicilari getir dedigimizde olayýn icine having giriyor
-- cunku group by ile where bir kullanilmiyor.Dolayýsýyla boyle bir sartý sorgulamak icin 
-- having kullanilir

select 
U.full_name, count(A.id) as [Adres Sayýsý], count(distinct C.country) as [Ülke Sayýsý]
from USERS as U, ADDRESSES as A, COUNTRIES as C, CITIES as CT
where 
U.id = A.user_id_ and 
C.id = A.country_id and
CT.id = A.city_id

group by U.full_name
having count(A.id)>= 2

-----------------------------------------------------------------------------------
-- Yukarida ki sorgular aslýnda yetersizdir hep where kosulu kullanarak yapýlmaktadýr
-- bunun yerine artýk joinler kullanýlmaktadir
-- temel yapýsý soyledir
-- select A.Kolon1, A.Kolon2... from A join B on A.PK = B.FK seklindedir

select U.full_name, U.birthdate, A.address_text 
from USERS as U
join ADDRESSES as A on A.user_id_ = U.id
----------------------------------------------------------------------
-- birden fazla tabloda birlestirilebilir
select U.full_name, U.birthdate, A.address_text, C.country, CT.city
from USERS as U
join ADDRESSES as A on A.user_id_ = U.id
join COUNTRIES as C on C.id = A.country_id
join CITIES as CT on CT.id = A.city_id

-- bu kullaným ayný zamanda inner join olarak gecer
-- sonucta tablolarýn kesisimlerini alýyoruz
--------------------------------------------------------------------

-- join'nin turleri bulunmaktadýr 
-- inner join,left join, right join, full join
------------------------------------------------------------------

-- INNER JOIN 
-- bu birlestirme islemi aslýnda kesisim alma islemidir
-- elimizde iki tane kume(tablo) oldugunu dusunelim bu iki kumenin kesisimine
-- inner join denilmektedir. Peki iki kume(tablo) arasýnda ki kesisimi ne saglar
-- diye sorarsak. Bu kesisimleri birinde bulunan primary key diger kumede bulunan
-- foreign key bu kesisimi saglamaktadýr

/*
A kumesi(tablosu)                    B kumesi(tablosu)
-------------------                ---------------------------
| id      user    |                | id    user_id    city   |
|  1      can     |                |  1      1        ankara |  
|  2      ali     |                |  2      1        sivas  |
|  3      veli    |                |  3      2        nigde  |
|  4      alp     |                |  4      3        rize   |
|  5      mehmet  |                |  5      3        sivas  |
-------------------                |  6      6        mugla  |
                                   |  7      10       kars   |
                                   ---------------------------
              
bu tablolar da ortan olan a kumesinde id (primary key) ile b kumesinde ki 
user_id(foreign key). Dolayýsýyla kesisim kumemiz

               kesisim kumesi(tablosu) (inner join)
                    -------------------------
					|  user         city    |
                    |  can          ankara  |
                    |  can          sivas   |
                    |  ali          nigde   |
                    |  veli         rize    |
                    |  veli         sivas   |
                    -------------------------
goruldugu gibi alp ve mehmet kullanicisinin kesisim tablosunda isi yok ayný sekilde
mugda adlý sehir ile kars adlý sehrinde kesisim tablosunda isi yok 
(veri tabaný seklýnde dusunursen mugla ve karsin bir kullanicisi olmak zorunda 
cunku foreign key'ler lakin burada kumeler seklýnde dusun)

LEFT JOIN

burada soldaki tablo a kumesi left olurken right tablosu b kumesi olmaktadir

left join ise a tablosunu getir ve a ile b'nin kesisiminide getir demek oluyor

                        left join
                   ----------------------- 
                   |  user       city    |
                   |  can        ankara  | 
                   |  can        sivas   |
                   |  ali        nigde   |
                   |  veli       rize    | 
                   |  veli       sivas   | 
                   |  alp        NULL    | 
                   |  mehmet     NULL    |
                   -----------------------
RIGHT JOIN 
left joinin tam tersidir
sag tarafta ki tablo baz alýnýr 


                        right join
                   ----------------------- 
                   |  user       city    |
                   |  can        ankara  | 
                   |  can        sivas   |
                   |  ali        nigde   |
                   |  veli       rize    | 
                   |  veli       sivas   | 
                   |  NULL       mugla   | 
                   |  NULL       kars    |
                   -----------------------              

FULL JOIN 

iki kumeyide getiren bir birlestirme islemidir. Aralarinda baglantý(kesisim) olsun
olmasýn birlestirir

                        full join
                   ----------------------- 
                   |  user       city    |
                   |  can        ankara  | 
                   |  can        sivas   |
                   |  ali        nigde   |
                   |  veli       rize    | 
                   |  veli       sivas   | 
                   |  alp		 NULL    | 
                   |  mehmet     NULL    |
                   |  NULL       mugla   |
                   |  NULL       kars    |
                   -----------------------   
*/                     

-- Bu tablolar joinlerin sorgularý icin olusturulmustur
create table test_user
(
user_id tinyint primary key identity(1,1),
user_name varchar(10)
)
insert into test_user(user_name)
values('can'),('ali'),('veli'),('alp'),('mehmet')


create table test_address
(
address_id int primary key identity(1,1),
user_id tinyint foreign key references test_user(user_id),
address_city varchar(10)
)
insert into test_address(user_id,address_city)
values(1,'sivas'),(1,'ankara'),(2,'nigde'),(3,'rize'),(3,'sivas'),(6,'mugla')


select * from test_user
select * from test_address
----------------------------------------------------
--inner join icin kesisim (inner keyword yazmasakta olur)
select t_u.user_id as ID, t_u.user_name as users, t_a.address_city
from test_user as t_u
inner join test_address as t_a on t_a.user_id = t_u.user_id 

----------------------------------------------------
-- Left join 
-- solda kalan tabloyu belirlemek icin join'nin solunda ki tablo sol tablo
-- sagýnda ki tablo sag tablo olarak gecer
-- test_user as t_u left join sol tablo
-- left join test_address as t_a ise sag tablo olarak geciyor
-- ayný sey right join icinde gecersi
select t_u.user_id as ID, t_u.user_name as users, t_a.address_city
from test_user as t_u
left join test_address as t_a on t_a.user_id = t_u.user_id 

-----------------------------------------------------

-- Right join (hepsi kesistigi icin bir fark gorunmuyor gibi duruyor)
select t_u.user_id as ID, t_u.user_name as users, t_a.address_city
from test_user as t_u
right join test_address as t_a on t_a.user_id = t_u.user_id

--------------------------------------------------------------

-- full join (hepsini alir)
select t_u.user_id as ID, t_u.user_name as users, t_a.address_city
from test_user as t_u
full join test_address as t_a on t_a.user_id = t_u.user_id

--------------------------------------------------------------------

-- JOIN KULLANARAK UPDATE YAPMA
-- bir tane ara tablo yaptýk bu tabloya degerleri test_user tablosundan atacagýz
-- test_user2 tablosuna 5 tane can ismi girdim sonra bu degerleri test_user tablosundan
-- isimleri cekerek test_user2 tablosunu guncelledim
create table test_user2
(
user_id int primary key identity(1,1),
user_name varchar(10)
)
insert into test_user2(user_name)
values('can'),('can'),('can'),('can'),('can')


update test_user2 set user_name = test_user.user_name 
from 
test_user inner join test_user2 on test_user.user_id = test_user2.user_id
-- bu sorgu tum kisiler uzerinde guncelleme yapar
-- where kosula koyabiliriz
-- where test_user2.user_name like '%a%'
-- icinde a gecen kisilere uygula

-----------------------------------------------------------------

--JOIN KULLANARAK DELETE YAPMA

delete test_user2 from test_user inner join test_user2 
on test_user.user_id = test_user2.user_id
where test_user2.user_name like '%a%'
-- icinde a harfi gecen kisileri sil

select * from test_user2

------------------------------------------------------------------

-- UNION KOMUTU

--union ile iki sorguyu birlestirebiliriz bu konu daha iyi anlasýlsýn diye
--burada bir tablo olusturacagim adi test_cities
--bu test_cties ile cities tablolarý uzerinde union uygulayacagým

create table test_cities
(
city varchar(20)
)
insert into test_cities
values('Sivas union'),('Balikesir union'),('Liverpool'),('Nevada union'),('Madrid'),('Barcelona')


-- test_cities tablosuna bir kac deger girdim
-- Sivas union, Balýkesir union, Liverpool, Nevada union , Madrid, Barcelona
select * from CITIES
select * from test_cities

-- bu iki sorguyu calýstýrdýgým da iki farklý tablo gelir. union ile sorgularý
-- birlestirebiliriz
-- Bu sorgu sonucunda 17 sonuc dondu

select * from CITIES union select * from test_cities
-- sorguyu boyle yazarsak hata alýrýz cunku iki tabloda da kolon sayýlarý farklý
-- uzerinde islem yaptýgýmýz kolonlarýn týpleri ve sayilari esit olmalidir

select CITIES.city from CITIES
union 
select * from test_cities
-- bu sorgu sonucunda 14 sonuc dondu. 3 tanesini almadi cunku ayni olanlari almali
-- bunlar Liverpool, Madrid, Barcelona iki tabloda da vardý
-- eger ayný olanlarý da almak istiyorsak all demeliyiz

select CITIES.city from CITIES
union all
select * from test_cities
