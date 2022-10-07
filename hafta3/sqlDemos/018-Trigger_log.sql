-- Trigger ile son kayıdı loglama

use HumanResources

-- 2. workers tablosu olusturalım.

create table WORKERS2
(
ID int primary key identity(1,1),
WORKERCODE varchar(20),
WORKERNAME varchar(50),
GENDER char(1),
BIRTHDATE date,
TCNO char(11),
WORKERCARDNO uniqueidentifier
)
-- bu tabloyu doldurmak icin crm databaseni kullanacagiz.

select top 1000 * from CRM2.dbo.CUSTOMERS order by ID

-- simdi bu customers tablosu ile workers2 tablosunun ortak sutunlarını belirleyelim
/*
workercode = tcno
workername = namesurname
gender = gender
birthdate = birthdate
tcno = tcno
workercardno = newid()
*/

-- simdi insert into select ile customers tablosundan workers2 tablosuna
-- deger atayacagız

insert into WORKERS2
(WORKERCODE, WORKERNAME, GENDER, BIRTHDATE, TCNO, WORKERCARDNO)
select top 1000 
TCNO, NAMESURNAME, GENDER, BIRTHDATE, TCNO, NEWID()
from CRM.dbo.CUSTOMERS order by ID

select * from WORKERS2

-- simdi birde workertransactions2 tablosu olusturalım ve calısanların
-- hareketlerini orada tutalım

create table WORKERTRANSACTIONS2
(ID int primary key identity(1,1),
WORKERID int foreign key references WORKERS2(ID),
TRANSACTIONDATE datetime,
IOTYPE char(1),
GATEID int
)

-- simdi bu tabloya calısanların rastgele giris veya cikis 
-- hareketleri ile dolduracagız. Bunun icin bir prosedur yazalım

create proc sp_Random_Worker_Transaction 
@WORKERID as int
as
begin
	declare @I as int = 0
	declare @BEGINDATE as datetime = '2022-01-01 08:00:00'
	declare @IOTYPE as char(1) = 'G'
	declare @DATE as datetime = @BEGINDATE

	while @I < 365
	begin
		
		IF DATEPART(DW,@BEGINDATE)<>1 AND RAND()>0.2
		BEGIN
		--SABAH GİRİŞ 
		SET @DATE=DATEADD(MINUTE,CONVERT(INT,RAND()*30),@DATE)
		INSERT INTO WORKERTRANSACTIONS2 (WORKERID,TRANSACTIONDATE,IOTYPE,GATEID)
		VALUES (@WORKERID,@DATE,'G',ROUND(RAND()*20,0)) 
 
		--İLK MOLA ÇIKIŞ SAATİ SAAT 10:00
		SET @DATE=DATEADD(HOUR,2,@BEGINDATE)
		SET @DATE=DATEADD(MINUTE,CONVERT(INT,RAND()*15),@DATE)

		INSERT INTO WORKERTRANSACTIONS2 (WORKERID,TRANSACTIONDATE,IOTYPE,GATEID)
		VALUES (@WORKERID,@DATE,'C',ROUND(RAND()*20,0)) 

		--İLK MOLADAN GELİŞ
		SET @DATE=DATEADD(MINUTE,8+CONVERT(INT,RAND()*10),@DATE)
 
		INSERT INTO WORKERTRANSACTIONS2 (WORKERID,TRANSACTIONDATE,IOTYPE,GATEID)
		VALUES (@WORKERID,@DATE,'G',ROUND(RAND()*20,0))
 
			--ÖĞLE YEMEĞİNE ÇIKIŞ 12:00
		SET @DATE=DATEADD(HOUR,4,@BEGINDATE)
		SET @DATE=DATEADD(MINUTE,CONVERT(INT,RAND()*15),@DATE)
		INSERT INTO WORKERTRANSACTIONS2 (WORKERID,TRANSACTIONDATE,IOTYPE,GATEID)
		VALUES (@WORKERID,@DATE,'C',ROUND(RAND()*20,0))
		--ÖĞLE YEMEĞİNDEN GELİŞ
		SET @DATE=DATEADD(MINUTE,55+CONVERT(INT,RAND()*15),@DATE)
		INSERT INTO WORKERTRANSACTIONS2 (WORKERID,TRANSACTIONDATE,IOTYPE,GATEID)
		VALUES (@WORKERID,@DATE,'G',ROUND(RAND()*20,0)) 

			--İKİNCİ MOLAYA ÇIKIŞ YEMEĞİNE ÇIKIŞ 15:00
		SET @DATE=DATEADD(HOUR,7,@BEGINDATE)
		SET @DATE=DATEADD(MINUTE,CONVERT(INT,RAND()*15),@DATE)
		INSERT INTO WORKERTRANSACTIONS2 (WORKERID,TRANSACTIONDATE,IOTYPE,GATEID)
		VALUES (@WORKERID,@DATE,'C',ROUND(RAND()*20,0)) 
		--İKİNCİ MOLADAN GELİŞ
		SET @DATE=DATEADD(MINUTE,8+CONVERT(INT,RAND()*10),@DATE)
		INSERT INTO WORKERTRANSACTIONS2 (WORKERID,TRANSACTIONDATE,IOTYPE,GATEID)
		VALUES (@WORKERID,@DATE,'G',ROUND(RAND()*20,0)) 

			--MESAİ BİTİŞİ 17:00
		SET @DATE=DATEADD(HOUR,9,@BEGINDATE)
		SET @DATE=DATEADD(MINUTE,-10+CONVERT(INT,RAND()*20),@DATE)
		INSERT INTO WORKERTRANSACTIONS2 (WORKERID,TRANSACTIONDATE,IOTYPE,GATEID)
		VALUES (@WORKERID,@DATE,'C',ROUND(RAND()*20,0))
		
	END
	SET @I=@I+1
 
	SET @BEGINDATE=DATEADD(DAY,1,@BEGINDATE)

	end
end

exec sp_Random_Worker_Transaction 1 
-- suan bu prosedur bir calısan icin calısıyor bız bunu butun calısanlar
-- icin yapmalıyız bunu da while ile yapacagız

declare @i as int = 1

while @i <= 1000 -- 1000 calısan oldugu icin
begin
	exec sp_Random_Worker_Transaction @i
	set @i += 1
end
-- bu dongu ile butun calısanlar icin hareket eklemis olacagız

select * from WORKERTRANSACTIONS2 

-- simdi bir calısanın son hareketını getirelim.

set statistics io on
select *, 
(select top 1 IOTYPE from WORKERTRANSACTIONS2 where WORKERID = WORKERS2.ID order by TRANSACTIONDATE desc) as HareketTuru,
(select MAX(TRANSACTIONDATE) from WORKERTRANSACTIONS2 where WORKERID = WORKERS2.ID) as SonHareketZamani
from WORKERS2 where ID = 1
-- bu sorgu icin 15048 tane page okunmus.
-- bunu tum calısanlar icin yaparsak kac page okuyacak ona bakalım

set statistics io on
select *, 
(select top 1 IOTYPE from WORKERTRANSACTIONS2 where WORKERID = WORKERS2.ID order by TRANSACTIONDATE desc) as HareketTuru,
(select MAX(TRANSACTIONDATE) from WORKERTRANSACTIONS2 where WORKERID = WORKERS2.ID) as SonHareketZamani
from WORKERS2
-- bu sorgu icinde 5.961.954 tane page okumus
select 5961954 * 8 / 1024 / 1024 as [GB TURUNDEN]
-- 45gb dosya okuması yapmıs.

/*iste bizim amacımız da bu okuma islemini azatma yonelik. Bunun icinde
her calısan bir giris veya cıkıs yaptıgı esnada onun giris veya cıkıs
bilgisini baska bir tabloya otomatık olarak yazılsa ve her seferinde 
kendini guncellerse bu kadarlık veri okuması yapmaya gerek kalmaz*/
-- calısanların son kaydını tutacak bir tablo olusturalım.

create table WORKERLASTTRANSACTION
(
ID int primary key identity(1,1),
WORKERID int foreign key references WORKERS2(ID),
LASTDATE datetime,
LASTIOTYPE char(1)
)
-- simdi bu tabloya sadece calısanların id'sini atayalım

insert into WORKERLASTTRANSACTION(WORKERID)
select ID from WORKERS2

select * from WORKERLASTTRANSACTION
-- sadece id'ler var son hareket ve son hareket tipi bos bunları trigger ile
-- dolduracagız.

create trigger TR_Transaction_Insert on WORKERTRANSACTIONS2 after insert
as
begin 
-- WORKERLASTTRANSACTION tablosunu doldurmak icin workerid,date,iotype
-- ihtiyacimiz var.

declare 
@WORKERID as int,
@DATE as datetime,
@IOTYPE as char(1)

select @WORKERID =WORKERID, @DATE = TRANSACTIONDATE, @IOTYPE = IOTYPE
from inserted

update WORKERLASTTRANSACTION set LASTIOTYPE = @IOTYPE, LASTDATE = @DATE
where WORKERID = @WORKERID
end

-- simdi WORKERTRANSACTIONS2 tablosunu yeniden temizleyelim ve sonra 
-- proseduru tekrar calıstırıp icine deger atayalım boylece 
-- WORKERLASTTRANSACTION tablosunda ki degisiklikleri de gormus olacagız.

truncate table WORKERTRANSACTIONS2

declare @I as int = 1
while @I <= 1000
begin
	exec sp_Random_Worker_Transaction @I
	set @I += 1
end

select * from WORKERTRANSACTIONS2
-- hareketler eklendi

set statistics io on
select * from WORKERLASTTRANSACTION
-- burada ise son hareketler ve son hareket tarıhı var ayrıca 6 page okumus
--  5.961.954 tane page nere 6 tane page nere fark oldukca fazla

-- simdide etrade database uzerinden islemler yapalım.
/* items tablosunda urunlerin bilgileri tutuluyordu. Biz o urunler uzerinde
guncelleme yaparsak eski verilerin kaybolmaması icin bir tablo olusturup
eski verilerin o tabloda tutulmasını saglayabiliriz. Otomatık degisikligi ise
yine trigger ile yapacagiz.
*/

create table [ETRADE].[dbo].[ITEMS_LOG]
(
ID int primary key identity(1,1), 
ITEMCODE varchar(50), 
ITEMNAME varchar(100),
UNITPRICE float,
CATEGORY1 varchar(50), 
CATEGORY2 varchar(50),
CATEGORY3 varchar(50), 
CATEGORY4 varchar(50), 
BRAND varchar(50),
LOG_ACTION_TYPE varchar(50),
LOG_DATE datetime,
LOG_USERNAME varchar(50),
LOG_PROGRAMNAME varchar(50),
LOG_HOSTNAME varchar(50)
)
-- simdide trigger'ı olusturalım
create trigger TR_Log_Items_Update on [ETRADE].[dbo].[ITEMS] after update
as
begin
	insert into ETRADE.dbo.ITEMS_LOG
	(
	[ITEMCODE], 
	[ITEMNAME],
	[UNITPRICE],
	[CATEGORY1],
	[CATEGORY2], 
	[CATEGORY3], 
	[CATEGORY4],
	[BRAND], 
	[LOG_ACTION_TYPE],
	[LOG_DATE],
	[LOG_USERNAME],
	[LOG_PROGRAMNAME],
	[LOG_HOSTNAME]
	)
	select 
	[ITEMCODE], 
	[ITEMNAME], 
	[UNITPRICE], 
	[CATEGORY1], 
	[CATEGORY2],
	[CATEGORY3],
	[CATEGORY4],
	[BRAND],
	'UPDATE',
	GETDATE(),
	SUSER_NAME(),
	PROGRAM_NAME(),
	HOST_NAME()
	
	from deleted
end

select * from ETRADE.dbo.ITEMS where ID = 1
-- bu ürünün fiyati 5.15 biz bunu 10 ile guncelleyelim.

update ETRADE.dbo.ITEMS set UNITPRICE = 10 where ID = 1

select * from ETRADE.dbo.ITEMS where ID = 1
select * from ETRADE.dbo.ITEMS_LOG

/*ITEMS_LOG tablosunda da guncellenen urunun eski fiyati kim tarafindan ne 
zaman nerede guncellendigi bilgisi tutulmus olundu*/

-- bir de urun silinirse silinen o urunun verilerini otomatık olarak 
-- atayan bir trigger yazalım

create trigger TR_Log_Items_Delete on [ETRADE].[dbo].[ITEMS] after delete
as
begin
	insert into ETRADE.dbo.ITEMS_LOG
	(
	[ITEMCODE], 
	[ITEMNAME],
	[UNITPRICE],
	[CATEGORY1],
	[CATEGORY2], 
	[CATEGORY3], 
	[CATEGORY4],
	[BRAND], 
	[LOG_ACTION_TYPE],
	[LOG_DATE],
	[LOG_USERNAME],
	[LOG_PROGRAMNAME],
	[LOG_HOSTNAME]
	)
	select 
	[ITEMCODE], 
	[ITEMNAME], 
	[UNITPRICE], 
	[CATEGORY1], 
	[CATEGORY2],
	[CATEGORY3],
	[CATEGORY4],
	[BRAND],
	'DELETE',
	GETDATE(),
	SUSER_NAME(),
	PROGRAM_NAME(),
	HOST_NAME()
	
	from deleted
end

delete from ETRADE.dbo.ITEMS where ID = 5
-- id = 5 olan urunu silelim

select * from ETRADE.dbo.ITEMS where ID = 5
-- boyle bir kayıt yok cunku silindi

select * from ETRADE.dbo.ITEMS_LOG
-- lakin silinen urun log tablosuna eklendi.

/*peki soru su tek trigger ile bu sorunu cozebilir miydik yani update icin 
ayrı bir trigger delete icin ayrı bir trigger yazacagimiza ikisini bir arada
yapabilicek trigger yazamaz mıydık ? tabiki yazabiliriz. insert, update, delete
ucunu bir arada yapan trigger yazılabilir lakin bize burada insert islemi 
gerekmedigi icin delete ve update islemlerini yapan trigger yazacagız.
o zaman eski triggerlari silelim ve tek bir trigger yazalım
*/

drop trigger TR_Log_Items_Update, TR_Log_Items_Delete

create trigger TR_Log_Items_Update_Delete on ITEMS after update,delete
as 
begin
-- bizim update mi delete mi islemi oldugu yakalamamız gerekiyor.

-- hadi onu yakayalım.Update isleminde inserted tablosu da deleted tablosuda dolu
-- olur. Cunku ortada bir veri vardir.

-- delete isleminde ise inserted tablosu bos deleted tablosu dolu olur
-- cunku eski veriler tutulur orada

-- insert isleminde ise inserted tablosu dolu deleted tablosu bos olur
-- cunku yeni veriler inserted tablosuna eklenir.

-- o zaman bu tabloların bosluk ve dolulugundan update mi delete mi oldugunu
-- anlayabiliriz.

	declare 
	@DELETEDCOUNT as int,
	@INSERTEDCOUNT as int

	select @DELETEDCOUNT = COUNT(*) from deleted
	select @INSERTEDCOUNT = COUNT(*) from inserted

	declare @ACTIONTYPE as varchar(20)

	if @DELETEDCOUNT > 0 and @INSERTEDCOUNT > 0
	-- iki tabloda da deger var demek bu da update islemi oluyor demektir.
		set @ACTIONTYPE = 'UPDATE'

	if @DELETEDCOUNT > 0 and @INSERTEDCOUNT = 0
	-- silme islemidir 
		set @ACTIONTYPE = 'DELETE'

	insert into ETRADE.dbo.ITEMS_LOG
	(
	[ITEMCODE], 
	[ITEMNAME],
	[UNITPRICE],
	[CATEGORY1],
	[CATEGORY2], 
	[CATEGORY3], 
	[CATEGORY4],
	[BRAND], 
	[LOG_ACTION_TYPE],
	[LOG_DATE],
	[LOG_USERNAME],
	[LOG_PROGRAMNAME],
	[LOG_HOSTNAME]
	)
	select 
	[ITEMCODE], 
	[ITEMNAME], 
	[UNITPRICE], 
	[CATEGORY1], 
	[CATEGORY2],
	[CATEGORY3],
	[CATEGORY4],
	[BRAND],
	@ACTIONTYPE,
	GETDATE(),
	SUSER_NAME(),
	PROGRAM_NAME(),
	HOST_NAME()
	
	from deleted
end
truncate table 

select * from ITEMS where ITEMCODE = 15
-- fiyati 8.26 'dan 13.14 cıkaralım.

update ITEMS set UNITPRICE = 13.14 where ID = 2

select * from ITEMS where ID = 2
-- fiyati 13.14 oldu
select * from ETRADE.dbo.ITEMS_LOG
-- eskı fiyati ise burada tutuldu ve update islemi oldugu anlamıs

-- bir de silme yapalım.

delete from ITEMS where ID = 3

select * from ITEMS where ID = 3
-- sılındıgı icin boyle bir kayıt yok

select * from ETRADE.dbo.ITEMS_LOG
-- silinen kayıt buraya geldi ve delete islemi oldugu anladı