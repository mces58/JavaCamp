
--Burada use,create,insert,update,delete,tarih hesaplama(DATEDIFF,GETDATE), 
--truncate komutu where kosulu order by(NEWID), top komutu konularý islenmýstýr

--intro veritabanýný kullanmasý icin bunu yazdýk bazen baska veritabanlari uzerinde 
--islem yapýyor
use intro

--veritabanini olusturur
create database intro

--intro veritabanina bir tablo olusturur tablo adý ve sutunlar ekledik
create table CUSTOMERS(
--id'nin turu int not null ile bos gecilemez dedik ayrýca primary key yaptýk
--identity ile benzersizlik ve otomatik artma verdik (0,1) degeri 0'dan basla birer birer art demek
customer_id int not null primary key identity(0,1),
customer_name varchar(50) not null,
customer_birthday date not null,
--telefon numaralarý hep farklý benzersiz oldugu icin unique ozelligini verdik
--char veri tipinde yaptýk cunku uzunlugu sabit bir ozelliktir telefon numarasý
customer_phone char(10) not null unique,
--yas bos gecilebilir yaptýk
customer_age int,
city varchar(20) not null,
gender char(1) not null
)

select * from CUSTOMERS

---INSERT ÝÞLEMÝ---------------------------------------------------------------------------------------------------------------------------
--tabloya veri ekler tablo adý yazýlýr ve sutun adlarý yazýlýr
--ekleme yaparken customer_id vermemeliyiz biz onu otomatik artan yaptýgýmýz icin
insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
-- sonrada eklenek veriler values icine yazýlýr string date tek týrnak icinde yazýlýr
-- ayrýca date yazýlýrken yýl-ay-gun sýrasýnda aralarýnda bir tire veya tiresiz olarak yazýlabilir
values
('Can ESER', '2001-08-08',1111111111,'Sivas','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Nihat ESER', '1971-10-17',2222222222,'Ýzmir','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Fatma ESER', '1977-01-01',3333333333,'Mersin','K')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Furkan ESER', '2003-02-23',4444444444,'Bolu','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Emirhan ESER', '2009-07-30',5555555555,'Hakkari','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Mehmet ESER', '1940-04-13',6666666666,'Mersin','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Hacer ESER', '1950-12-04',7777777777,'Samsun','K')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Osman ERBAÞ', '1941-06-28',8888888888,'Rize','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Mükrime ERBAÞ', '1949-11-11',9999999999,'Muðla','K')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Gaffar Okan ERKAN', '2001-05-12',0000000000,'Denizli','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Volkan ÇEKÝP', '1997-10-16',1,'Mersin','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Songül BOZKURT', '1983-01-13',2,'Burdur','K')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Salih ÇOÞKUN', '2001-05-12',3,'Denizli','E')

insert into CUSTOMERS
(customer_name, customer_birthday, customer_phone, city, gender)
values
('Ezgi MOLA', '19860610',4,'Denizli','K')

select * from CUSTOMERS

--UPDATE ÝÞLEMÝ-------------------------------------------------------------------------------------------------------------------------------

-- bu kod calýsmaz nedeni su biz bir kosul belirtmedik dolayýsýyla butun tablodaki telefon numaralarýný 
-- 1 yapacak buna izin vermez cunku biz yukarýda telefon numaralarýný unique(benzersiz) yapmýstýk dolayýsýyla 
-- telefon numaralarýnýn ayný olamasýna izin vermez
update CUSTOMERS set customer_phone = 1

-- býrden fazla guncellemeyi virguller ile ayýrarak yapabiliriz
-- butun sehirleri sivas olarak ve yukarda yaslara deger vermemýstýk burada butun yaslara 20 yasýný vererek guncelledik
update CUSTOMERS set city = 'Sivas', customer_age = 20

select * from CUSTOMERS

-- simdi musterilerin gercek yaslarýný bulalým ve onu guncelleyelim
-- bunlar sql fonksiyonlarýdýr: datediff(), getdate()
-- datediff fonksiyonu iki tarih arasýndaki farki alýr. icine parametreler verdik year parametresi farkýn yýl cýnsýnden bulunmasýný saglar,
-- customer_birthday ile musterinlerin yaslarýný verdik, getdate ile sýmdýki yaný bugunun tarýhý almasýný soyledýk
-- yani bugunun tarihinden musterýlerin dogum tarihlerini cýkaradý ve býze yýl olarak gosterdi

update CUSTOMERS set customer_age = DATEDIFF(YEAR,customer_birthday,GETDATE())

select * from CUSTOMERS

---DELETE ÝÞLEMÝ-------------------------------------------------------------------------------------------------------------

-- bir kosul belirmedigimiz icin tablonun icindeki kayýtlý olan butun musterileri siler lakin tabloyu silmez drop ile karýstýrma 
-- drop table direk tabloyu siler 

delete from CUSTOMERS

select * from CUSTOMERS

---TRUNCATE KOMUTU---------------------------------------------------------------------------------
--tabloyu ilk olusturdugumuz haline donderen bir komuttur.Sanki yeniden olusturmusuz gibi icindeki tum verileri silen bir komuttur
--peki delete komutundan farký nedir diye sorarsak? eger tablomuzda otomatýk artan bir ozellik varsa delete yaptýgýmýzda veriler
--silindiginde en son veri hangi degeri aldýysa yeni veri ekledigimizde oradan devam eder.Yani 1000 verimiz varsa ve
--otomatýk artan bir ozellik ise delete yaptýgýmzda yeni veri 1001'den devam eder. Ayrýca delete islemi yavas bir islemdir.
--truncate islemi ise hem delete islemine gore daha hizli hemde veriler silindiginde delete gibi kaldýgý yerden devam etmez
--sýfýrdan baslar dolayýsla silme islemlerinde delete degil truncate daha cok kullanilir
--truncate table tablo_adý seklýnde kullanilir
truncate table CUSTOMERS


---WHERE KOÞULU------------------------------------------------------------------------------------------
--where kosulu ile beraber kullanýlan bazi operatorler vardýr bunlar =, <, >, >=, <=, <>...
--where kosulu sadece select komutunda degil delete, update, insert gibi komutlarýnda da kullanilabilir
select * from CUSTOMERS where customer_name = 'Can ESER'
select * from CUSTOMERS where customer_age >= 50
select * from CUSTOMERS where city <> 'sivas'
select * from CUSTOMERS where not city = 'sivas'
-- <> 'sivas' ile not city 'sivas' ayný komuttur ikiside sivas disinda ki illeri getirir

select * from CUSTOMERS where customer_age between 20 and 30 
-- 20 yasý ile 30 yasý arasýndaki degerleri getirir 20 ile 30'da bu sýnýrlara dahil

select * from CUSTOMERS where customer_name like 'Gaf%'
--Gaf ile baslayan degeri getirir

select * from CUSTOMERS where customer_name like '%i%'
-- ismi icersinde i harfi olanlarý getirir

select * from CUSTOMERS where customer_name like '%Þ'
--ismi Þ ile bitenleri getirir

select * from CUSTOMERS where customer_name not like '%m%'
--ismi icinde m harfi icermeyenleri getirir

select * from CUSTOMERS where city in('Sivas','Mersin')
--sehiri sivas veya mersin olan kayýtlarý getirir

update CUSTOMERS set gender = 'F' where gender = 'K'
update CUSTOMERS set gender = 'M' where gender = 'E'

--cinsiyetlerin isimlerini guncelledik Male ve Female olarak where kosulunu koymasak hepsini ayný yapar

select * from CUSTOMERS where customer_age >=30 or city ='Mersin'
--birden fazla kosulu baglayýp sorgu yapabiriz

--Coklu kosula bir ornek yapalým ornegin:
-- select * from customers where city = 'Sivas' and district = 'Zara' and district = 'Kangal'
-- bu sorguda ilk bakýsta olarak dogru gibi gorunsede aslýnda mantýksal olarak yanlýs bir sorgudur
-- bu sorguda biz sehirini sivas diye belirttik bunda sikinti yok ama bolgesini ayni anda hem zara hemde kangal
-- olanlari sorguladýk bu durumda gecerli degildir birinin bolgesi ayný anda iki farklý yer olamaz dolayýsýyla bu sorgu 
-- yanlýstýr. Araya OR koyarsak o zaman dogru olur. 
-- select * from customers where city = 'Sivas' and district = 'Zara' or district = 'Kangal'
-- sehiri sivas olup bolgesi zara veya kangal olanlarý getir demis olduk

select * from CUSTOMERS where gender = 'M' and customer_birthday between '19450101' and '20220101'
-- cinsiyeti erkek olan ve dogum tarýhleri 01/01/1945 ile 01/01/2022 arasýnda ki kisileri getirdi
-- tarihi boyle tiresiz gondermek en dogru kullanýmdýr.boylece platformdan bagýmsýz oluyoruz.yine yýl-ay-gun seklýnde

--DISCTINCT KOMUTU------------------------------------------------------------------------------------------
-- tekil verileri cekmede kullanýlýr. Yani birden fazla tekrar eden verilerde hepsini getirmeyip tekli tekli getirmeye yarar
-- select distinct sutun adý from tablo adý

--customers tablosundan sehirleri getirir lakýn birden fazla ayný sehir varsa onlarý getýrmez bir tanesini getirir
select distinct city from CUSTOMERS

--customer tablosundan cinsiyeti getirir lakin denizlidekileri
select distinct gender from CUSTOMERS where city = 'Denizli'


--ORDER BY KOMUTU----------------------------------------------------------------------------------
-- order by sýralama da kullanýlýr iki degeri var ASC ve DESC 
-- ASC kucukten buyuge dogru sýralama yapar yada alfabetik olarakta A'dan Z'ye dogru
-- DESC buyukten kucuge dogru sýralama yapar yada alfabetik olarak Z'den A'ya dogru default degeri ASC

--musterýleri A'dan Z'ye dogru sýralar
select * from CUSTOMERS order by customer_name asc 

-- birden fazla sýralama yapýlabýlýr cinsiyeti kucukten buyuge dogru sýralar sonra isimlere gecer onlarýda Z'den A'ya sýralar
-- ilk once cinsiyeti sýralar sonra ismi siralar 
select * from CUSTOMERS order by gender asc, customer_name desc

--denizli sehirindeki musterileri tersten sýralar
select * from CUSTOMERS where city = 'Denizli' order by customer_name desc

--kolon numarasýna gorede sýralar yani 3. kolon olan dogum tarýhýne gore bir siralama yaptý
select * from CUSTOMERS order by 1

-- rastgele bir siralama yapmak istiyorsak NEWID() fonksiyonu kullanilir

select * from CUSTOMERS order by NEWID()
---TOP KOMUTU----------------------------------------------------------------------------------------------------
--Ne kadar veri cekmek veya gormek istiyorsak ona yarýyor
-- select top n sutun_adi from tablo adi varsa sartlý ifade
-- n burada ne kadar veri cekmek istiyorsak onu yazýyoruz

-- 3 tane musteri getirir ve isme gore sýrali bir sekilde
select top 3 * from CUSTOMERS order by customer_name 

-- percent yuzde demek yani burada 50%'ni getir dedik ve 3. kolona gore sýrala dedik yani dogum tarýhýne gore
select top 50 percent * from CUSTOMERS order by 3
