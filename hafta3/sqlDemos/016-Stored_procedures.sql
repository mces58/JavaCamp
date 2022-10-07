-- Stored Procedure
/*
T-sql cumlelerinin sql server hafizasina kaydedilerek derlendigi ve
derlenmis hallerin calistiridigi yapılardir.

Stored procedure nedir örnek?
Stored Procedures SQL'de vazgeçilmez veri tabanı objelerindendir.
Türkçemizde karşılığı saklı yordam olarak kabul edilmektedir.
Bir takım SQL deyimlerinden oluşmaktadır ve özellikle C#, VB,
ASP.NET tabanlı projelerimizde veri tabanı ile işlem yaparken 
sık sık başvurduğumuz yöntemlerdendir.

Stored procedure hangi amaçla kullanılmaktadır?
Ağ trafiğini azaltmak istediğimizde kullanılır. Saklı Yordam 
SQL ifadelerini ağ ortamına çoklu göndermek yerine, toplu olarak
çalıştırabilir. Böylece trafiği azaltıp performans artılır. Daha
iyi veri güvenliği sağlar.

Stored procedure ne işe yarar?
Stored procedure'ler, SQL Server 'a esneklik ve hız kazandırırlar. 
Önceden derlenmiş olduğu için, normal kullanılan bir SQL sorgusunun 
tekrar tekrar çalıştırılmasına oranla daha fazla performans elde 
edilmesine sağlarlar. Bir kez yazılıp, tekrar tekrar kullanıldığı
için modüler bir yapıda program geliştirilmiş olur.

Ad-Hoc Query Nedir?
Ad hoc kelimesinin kökeni Latince'den gelir ve “amaç için” anlamına 
gelmektedir. Yani yazılan sorgunun bir amaç için yazılıp devamının
olmaması ya da nadiren olması durumuna yazılan bir sorguyu ifade
etmektedir. Örnek ile açıklamam gerekirse, kullanıcı bilgilerin yer
aldığı bir tablonuz olduğunu düşünün ve bu tablo üzerinden dinamik 
olarak farklı kullanıcı numarası üzerinden sorgulama yapıldığını
varsayalım. Bu durumda yazılan sorgu aslında bir Ad-Hoc query’dir.
Örnek olarak : Select * from Users bir ad hoc query olmaktadır.
Bundan onceki yazdığımız tüm sorgular birer ad hoc query'di cunku sorgunun
bir amacı yoktu yazılıp calıstırılıyordu.
Arka planda ad hoc query nasıl calısır biraz ona bakalım.

SELECT * FROM USERS
1 - Query Adımı:
Kullanıcının sorguyu gönderme aşamasıdır.Sorguyu göndermek icin herhangi 
bir ortamı kullanabilir.Örneğin Excel, management studio veya baska 
bir yerden gönderebilir.

2 - Parse Adımı:
Gönderilen sorgu dogru bir query mi diye kontrol edilir.Syntax 
yazılımına bakılır. Yani çalıstırabilir bir sorgu diye bakilir ek olarak
Syntax dogrudur ama tabloya veya view vb. seyleri gormeye yetkim yoktur.
Dolayısıyla bu yetki kontrollerininde yapldıgı yerdir.

3 - Optimize Adımı:
Bu adımda execution plan çıkarılır.Executon plan sorgunun calıstırılabilmesi
icin izlenilecek yoldur. Sql server execution planı cıkartırkende
en az maliyetli yol seçer. En az maliyetli yolu da istatistiklere
bakarak hesaplar.

4 - Compile Adımı:
Sorgunun makine diline cevirildigi asamadır. Sorgunun derlenip
calıstırlmaya hazır olması.

5 - Execute Adımı:
Derlenmiş sorgunun çalistirilması asamasıdır.

6 - Result Adımı:
Sonucun dönderildiği veya gösterildiği asamadır.

Temel anlamda bir ad hoc query boyle calısır. Peki bu sorgu bir stored
procedure olsaydı nasıl calısırdı birde ona bakalım.

EXEC SP_GETUSERS
Stored procedure ilk kez çalıstırıyorsak aynı ad hoc query gibi tum adımlar
calısır lakın ilk kez cagırmıyorsak yanı daha onceden calısmıssa iki 
adımda calısır 
1 - Execute Adımı: Yanı yine calıstır
2 - Result Adımı: Sonucları goster

İste stored procedure'nin avantaji sureklı olarak sorgularımızı sıfırdan
kontrol etmek, derlemek yerine sadece execute ederiz.

Bir kac özelligi:
* Stored procedure'un sonucları icerisinde dogrudan order by ya da where sarti
kullanılamaz.
* icersine bir ya da birden fazla parametre alabilir.
* sql injection'a karsi bir cozumdur.
* sorgular derlendigi icin ad-hoc query'lere gore daha hızlı calısır.
* bir procedure icinden baska bir procedure de cagrılabilir.

Bu konu icin yeni bir database uzerinde calısacagız.
*/

create database HumanResources
use HumanResources

create table WORKERS
(
ID int primary key identity(1,1),
WORKERCODE varchar(20) unique,
WORKERNAME varchar(50),
GENDER char(1) check(GENDER = 'E' or GENDER = 'K'),
BIRTHDATE date,
TCNO char(11) unique,
WORKERCARDNO uniqueidentifier
)

create table WORKERTRANSACTIONS
(
ID int primary key identity(1,1),
WORKERID int foreign key references WORKERS(ID),
TRANSACTIONDATE date,
IOTYPE char(1),
GATEID int
)

insert into WORKERS
(WORKERCODE, WORKERNAME, GENDER, BIRTHDATE, TCNO, WORKERCARDNO)
values('12345678901','Mehmetcan ESER','E','20010808','12345678901',NEWID())

insert into WORKERTRANSACTIONS
(WORKERID, TRANSACTIONDATE, IOTYPE, GATEID)
values
(1,'20220519 08:01:32','G',1),-- 8'de ise girdi 
(1,'20220519 10:02:12','C',5),-- 10'da mola icin cıkıs yaptı
(1,'20220519 10:18:01','G',2),-- Mola bitti giris yapti
(1,'20220519 12:03:54','C',3),-- Ogle arası icin cıkıs
(1,'20220519 13:13:45','G',2),-- Ogle arası bitti giris
(1,'20220519 15:01:10','C',3),-- 15'de mola icin cıkıs yaptı
(1,'20220519 08:00:00','G',5),-- Mola bitti giris yapti
(1,'20220519 17:31:31','C',1) -- Gun bitti isten cikti

select * from WORKERS, WORKERTRANSACTIONS

/*Calısanların kart numarasının gecerli olup olmadıgını gosteren 
stored procedure yazalım. Bunun ad hoc kodunu yazalım ilk*/

select * from WORKERS where WORKERCARDNO = '8BC12E47-2C28-4DC7-90AE-E072EFD9FB95'
/*boyle bir kart numarası varsa tabloda gorunur yoksa gorunmez bunu
stored procedure haline getirecegiz.
Stored procedure'ler create ile olusturulur alter ile degistirilirler
drop ile silinirler*/

create procedure sp_CardControl(@WORKERCARDNO as varchar(50))
as 
begin
	select * from WORKERS where WORKERCARDNO = @WORKERCARDNO
end
/*
1. Adım:
create procedure diyip procedure ismi veriyoruz.
create proc diyerekte yapabiliriz.

2. Adım:
procedure paramtre alıyorsa onuda yazarız.Bizim ki burada 
kart numarası aldigi icin onuda gonderiyoruz 

3. Adım:
as begin end diyip arasına kodu yazıyoruz.

fonksiyon yazmaya benziyor aynı*/

exec sp_CardControl @WORKERCARDNO = '8BC12E47-2C28-4DC7-90AE-E072EFD9FB95'
/*procedure parametre gondermenın ıkı yolu vardır
1.
parametrenin adini yazarak degeri gondeririz
2.
degeri direk gondeririz ama birden fazla parametre varsa bu parametrelerin
gonderilme sirası onemli
*/

-- simdi procedure uzerinde bir kac degisiklik yapalım 

alter proc sp_CardControl(@WORKERCARDNO as varchar(50))
as 
begin
	declare @WORKERNAME as varchar(50)
	select @WORKERNAME = WORKERNAME from WORKERS where WORKERCARDNO = @WORKERCARDNO

	if @WORKERNAME is null
	begin
		select 'Kart Geçersiz'
	end
	else
	begin
		select @WORKERNAME as WORKERNAME --sutun adı
	end
end

exec sp_CardControl @WORKERCARDNO = '8BC12E47-2C28-4DC7-90AE-E072EFD9FB95'
exec sp_CardControl @WORKERCARDNO = '11111111-1111-1111-1111-111111111111'

-- Bu procedure biraz daha gelistirelim
alter proc sp_CardControl(@WORKERCARDNO as varchar(50))
as 
begin
	declare @WORKERNAME as varchar(50)

	select @WORKERNAME = WORKERNAME from WORKERS where WORKERCARDNO = @WORKERCARDNO

	if @WORKERNAME is null
	begin 
		raiserror('KART GEÇERSİZ', 16,1)
		return
		-- return yaptık yani kodu burada bitirdik asagısını calıstırmaya
		-- gerek yok
	end

	else 
	begin
		select @WORKERNAME as WORKERNAME
	end
end

exec sp_CardControl '8BC12E47-2C28-4DC7-90AE-E072EFD9FB95'
exec sp_CardControl '11111111-1111-1111-1111-111111111111'

/*Yukarıda ki yaptıgımız degisilik ile:
SQL Server'da Raiserror hata fırlatmak için kullanılan bir yapıdır.
SQL Server'ın hata fırlatmasını beklemeden kendimiz sorgunun hata 
fırlatmasını istediğimiz zamanlarda kullanabiliriz. Kısaca Try-Catch 
ile yakalanamayan hataları kullanıcıya bildirebilmek için Try-Catch
yapısı içinde Raiserror yapısını kullanabiliriz.
Ornek olarak
*/
BEGIN TRY
	SELECT 155 / 0
END TRY
BEGIN CATCH
	RAISERROR('BÖYLE BİR İŞLEM OLAMAZ',16,1)
END CATCH
/*
Burada ki 16 ile 1 parametredir.
01-10 arası: Bilgi mesajlarını gosterir. Gercek olmayan hataları gosterır.
11-16 arası: Kullanici kaynaklı hataları gosterir.Girilen bilgilerin kontrol
edilmesi gerekir.
17: Yetersiz kaynak hatası.
diye devam eder.
*/

--simdi bir sirkete giris cıkıs proseduru yazalım bakalım.

create proc sp_Worker_Inout
@WORKERCARDNO as varchar(50),
@DATE as datetime,
@IOTYPE as char(1),
@GATEID as int
as 
begin
-- ilk once calisanin kart numarasının dogrulugunu kontrol edecegiz.
	declare @WORKERNAME as varchar(50),@WORKERID as int
	select @WORKERNAME = WORKERNAME, @WORKERID = ID
	from WORKERS where WORKERCARDNO = @WORKERCARDNO
	
	if @WORKERID is null 
	begin
		raiserror('OKUTULAN KART GEÇERSİZDİR.', 16,1)
		return
	end

-- ikinci kontrole geldik. Calısanın son hareketi ile suan ki yaptıgı hareket
-- aynı mi diye kontrol edecegiz. Yani disari iken hala disari cıkmaya calısıyorsa
-- hata vermeli.
-- Simdi calısanın son hareketini yakalamaliyiz.

	declare @LASTIO as char(1)
	select top 1 @LASTIO = IOTYPE from WORKERTRANSACTIONS 
	where WORKERID = @WORKERID and TRANSACTIONDATE >= CONVERT(date, GETDATE())
	order by TRANSACTIONDATE desc 
	-- date ile gunun kontrolunu de yapıyoruz

-- son hareketi yakaladık simdi bunun kontrolu yapılır.
	if @LASTIO = @IOTYPE
	begin
		if @IOTYPE = 'G'
		begin
			raiserror('ZATEN İÇERİDE GÖRÜNÜYORSUNUZ GİRİŞ YAPAMAZSINIZ.',16,1)
			return
		end

		if @IOTYPE = 'C'
		begin
			raiserror('ZATEN DIŞARIDA GÖRÜNÜYORSUNUZ ÇIKIŞ YAPAMAZSINIZ.',16,1)
			return
		end
	end

-- kontoller yapıldı ve hepsinden gecti ise artık bu islemi workertransactions
-- tablusuna eklemeliyiz.

insert into WORKERTRANSACTIONS(WORKERID, TRANSACTIONDATE, IOTYPE, GATEID)
values(@WORKERID, @DATE, @IOTYPE, @GATEID)

-- en sonda kim nasıl eklenmis onu ekrana bastıralım
select @WORKERNAME as WORKERNAME, @DATE as TRANSACTIONDATE, @IOTYPE AS IOTYPE
end

-- simdi workertransactions tablosunu temizleyim ve prosedurumuzu calıstıralım
truncate table WORKERTRANSACTIONS

select * from WORKERTRANSACTIONS

exec sp_Worker_Inout 
@WORKERCARDNO = '8BC12E47-2C28-4DC7-90AE-E072EFD9FB95',
@DATE = '20220520 08:10:00',
@IOTYPE = 'G',
@GATEID = 1

--simdi workertransactions tablosuna eklemıs mı ona bakalım

select * from WORKERTRANSACTIONS

exec sp_Worker_Inout 
@WORKERCARDNO = '8BC12E47-2C28-4DC7-90AE-E072EFD9FB95',
@DATE = '20220520 08:10:00',
@IOTYPE = 'G',
@GATEID = 1

-- aynı işlemi tekrarlarsam hata verir cunku iceride oldugum halde giris 
-- yapma islemi yaptıgım icin

-- bir de cıkıs yapalım
exec sp_Worker_Inout 
@WORKERCARDNO = '8BC12E47-2C28-4DC7-90AE-E072EFD9FB95',
@DATE = '20220520 17:32:42',
@IOTYPE = 'C',
@GATEID = 3

select * from WORKERTRANSACTIONS

-- workertransactions tablosunda iotype bir kısıtlayıcı ekleyelim ki
-- sadece G(giris) ve C(cıkıs) harflerini alabilsin
alter table WORKERTRANSACTIONS add constraint CK_iotype_check
check(IOTYPE = 'G' or IOTYPE= 'C')

exec sp_Worker_Inout 
@WORKERCARDNO = '8BC12E47-2C28-4DC7-90AE-E072EFD9FB95',
@DATE = '20220520 17:32:42',
@IOTYPE = 'E',
@GATEID = 3
-- iotype degerini rastgele verdim ve insert islemine izin vermedi cunku
-- ya G yada C harflerine izin var

------------------------------------------------------------------
/*stored procedure'lar sadece toplu islemleri gerceklestirmek icin 
kullanılmaz. Raporlama veya view gibi seylerin yerlerine de kullanilabilir.*/

use ETRADE

create proc sp_Satislar
@baslangicTarihi as date,
@bitisTarihi as date
as
begin
	SELECT
	U.USERNAME_ AS [Kullanici Adi],
	U.NAMESURNAME AS [Musteri Adi],
	U.TELNR1 AS [Telefon 1],
	U.TELNR2 AS [Telefon 2], 
	C.COUNTRY AS Ulke, 
	CT.CITY AS Sehir,
	T.TOWN AS Bolge,
	A.ADDRESSTEXT AS [Acik Adres],                         
	O.ID AS [Siparis Id],
	ITM.ITEMCODE AS [Urunun Kodu],
	ITM.ITEMNAME AS [Urunun Adi],
	ITM.BRAND AS [Urunun Markasi],
	ITM.CATEGORY1 AS [Kategori 1], 
	ITM.CATEGORY2 AS [Kategori 2],
	ITM.CATEGORY3 AS [Kategori 3], 
	ITM.CATEGORY4 AS [Kategori 4],
	OD.AMOUNT AS [Stok Sayisi],
	OD.UNITPRICE AS [Birim Fiyati], 
	OD.LINETOTAL AS [Toplam Fiyat],
	CONVERT(date, O.DATE_) AS [Siparis Tarihi], 
	CONVERT(time, O.DATE_) AS [Siparis Saati], 
	DATEPART(YEAR, O.DATE_) AS Yil,
	CASE 
	WHEN DATEPART(MONTH, O.DATE_) = 1 THEN '01 - Ocak' 
	WHEN DATEPART(MONTH, O.DATE_) = 2 THEN '02 - Şubat' 
	WHEN DATEPART(MONTH, O.DATE_) = 3 THEN '03 - Mart'
	WHEN DATEPART(MONTH, O.DATE_) = 4 THEN '04 - Nisan' 
	WHEN DATEPART(MONTH, O.DATE_) = 5 THEN '05 - Mayıs' 
	WHEN DATEPART(MONTH, O.DATE_) = 6 THEN '06 - Haziran' 
	WHEN DATEPART(MONTH, O.DATE_) = 7 THEN '07 - Temmuz'
	WHEN DATEPART(MONTH, O.DATE_) = 8 THEN '08 - Ağustos'
	WHEN DATEPART(MONTH, O.DATE_) = 9 THEN '09 - Eylül' 
	WHEN DATEPART(MONTH, O.DATE_) = 10 THEN '10 - Ekim'
	WHEN DATEPART(MONTH, O.DATE_) = 11 THEN '11 - Kasım' 
	WHEN DATEPART(MONTH, O.DATE_) = 12 THEN '12 - Aralık'
	END AS Ay, 

	CASE 
	WHEN DATEPART(DW, O.DATE_) = 2 THEN '1 - Pazartesi'
	WHEN DATEPART(DW, O.DATE_) = 3 THEN '2 - Salı'
	WHEN DATEPART(DW, O.DATE_) = 4 THEN '3 - Çarşamba'
	WHEN DATEPART(DW, O.DATE_) = 5 THEN '4 - Perşembe' 
	WHEN DATEPART(DW, O.DATE_) = 6 THEN '5 - Cuma' 
	WHEN DATEPART(DW, O.DATE_) = 7 THEN '6 - Cumartesi'
	WHEN DATEPART(DW, O.DATE_) = 1 THEN '7 - Pazar'
	END AS [Haftanin Gunu]
	FROM  ORDERDETAILS AS OD INNER JOIN
	ORDERS AS O ON OD.ORDERID = O.ID INNER JOIN
	ITEMS AS ITM ON OD.ITEMID = ITM.ID INNER JOIN
	USERS AS U ON U.ID = O.USERID INNER JOIN
	ADDRESS AS A ON A.ID = O.ADDRESSID INNER JOIN
	COUNTRIES AS C ON C.ID = A.COUNTRYID INNER JOIN
	CITIES AS CT ON CT.ID = A.CITYID INNER JOIN
	TOWNS AS T ON T.ID = A.TOWNID INNER JOIN
	PAYMENTS AS P ON P.ORDERID = O.ID
	WHERE O.DATE_ BETWEEN @baslangicTarihi AND @bitisTarihi
	order by u.NAMESURNAME
end

exec sp_Satislar '2019-01-01','2019-01-31'
-- ocak ayının satıslarını getirdi
-- simdi bu proseduru degistirelim ve sehir parametresi ekleyelim

alter proc sp_Satislar
@baslangicTarihi as date,
@bitisTarihi as date,
@sehir as varchar(30)
as
begin
	SELECT
	U.USERNAME_ AS [Kullanici Adi],
	U.NAMESURNAME AS [Musteri Adi],
	U.TELNR1 AS [Telefon 1],
	U.TELNR2 AS [Telefon 2], 
	C.COUNTRY AS Ulke, 
	CT.CITY AS Sehir,
	T.TOWN AS Bolge,
	A.ADDRESSTEXT AS [Acik Adres],                         
	O.ID AS [Siparis Id],
	ITM.ITEMCODE AS [Urunun Kodu],
	ITM.ITEMNAME AS [Urunun Adi],
	ITM.BRAND AS [Urunun Markasi],
	ITM.CATEGORY1 AS [Kategori 1], 
	ITM.CATEGORY2 AS [Kategori 2],
	ITM.CATEGORY3 AS [Kategori 3], 
	ITM.CATEGORY4 AS [Kategori 4],
	OD.AMOUNT AS [Stok Sayisi],
	OD.UNITPRICE AS [Birim Fiyati], 
	OD.LINETOTAL AS [Toplam Fiyat],
	CONVERT(date, O.DATE_) AS [Siparis Tarihi], 
	CONVERT(time, O.DATE_) AS [Siparis Saati], 
	DATEPART(YEAR, O.DATE_) AS Yil,
	CASE 
	WHEN DATEPART(MONTH, O.DATE_) = 1 THEN '01 - Ocak' 
	WHEN DATEPART(MONTH, O.DATE_) = 2 THEN '02 - Şubat' 
	WHEN DATEPART(MONTH, O.DATE_) = 3 THEN '03 - Mart'
	WHEN DATEPART(MONTH, O.DATE_) = 4 THEN '04 - Nisan' 
	WHEN DATEPART(MONTH, O.DATE_) = 5 THEN '05 - Mayıs' 
	WHEN DATEPART(MONTH, O.DATE_) = 6 THEN '06 - Haziran' 
	WHEN DATEPART(MONTH, O.DATE_) = 7 THEN '07 - Temmuz'
	WHEN DATEPART(MONTH, O.DATE_) = 8 THEN '08 - Ağustos'
	WHEN DATEPART(MONTH, O.DATE_) = 9 THEN '09 - Eylül' 
	WHEN DATEPART(MONTH, O.DATE_) = 10 THEN '10 - Ekim'
	WHEN DATEPART(MONTH, O.DATE_) = 11 THEN '11 - Kasım' 
	WHEN DATEPART(MONTH, O.DATE_) = 12 THEN '12 - Aralık'
	END AS Ay, 

	CASE 
	WHEN DATEPART(DW, O.DATE_) = 2 THEN '1 - Pazartesi'
	WHEN DATEPART(DW, O.DATE_) = 3 THEN '2 - Salı'
	WHEN DATEPART(DW, O.DATE_) = 4 THEN '3 - Çarşamba'
	WHEN DATEPART(DW, O.DATE_) = 5 THEN '4 - Perşembe' 
	WHEN DATEPART(DW, O.DATE_) = 6 THEN '5 - Cuma' 
	WHEN DATEPART(DW, O.DATE_) = 7 THEN '6 - Cumartesi'
	WHEN DATEPART(DW, O.DATE_) = 1 THEN '7 - Pazar'
	END AS [Haftanin Gunu]
	FROM  ORDERDETAILS AS OD INNER JOIN
	ORDERS AS O ON OD.ORDERID = O.ID INNER JOIN
	ITEMS AS ITM ON OD.ITEMID = ITM.ID INNER JOIN
	USERS AS U ON U.ID = O.USERID INNER JOIN
	ADDRESS AS A ON A.ID = O.ADDRESSID INNER JOIN
	COUNTRIES AS C ON C.ID = A.COUNTRYID INNER JOIN
	CITIES AS CT ON CT.ID = A.CITYID INNER JOIN
	TOWNS AS T ON T.ID = A.TOWNID INNER JOIN
	PAYMENTS AS P ON P.ORDERID = O.ID
	WHERE O.DATE_ BETWEEN @baslangicTarihi AND @bitisTarihi AND
	CT.CITY like @sehir
end

-- simdide yine ocak ayinin verdigimiz sehirdeki satislarını getirsin

exec sp_Satislar '2019-01-01','2019-01-31','Sivas'
-- ocak ayının sivasta ki satısları

exec sp_Satislar '2019-01-01','2019-01-31','S%'
-- ocak ayının S ile baslayan sehirlerinde ki satislari

exec sp_Satislar '2019-01-01','2019-01-31','%'
-- ocak ayının tum sehirlerde ki satısları.

-- biz stored procedure'un parametrelerine baslangıc olarak default deger
-- verebiliriz

alter proc sp_Satislar
@baslangicTarihi as date,
@bitisTarihi as date,
@sehir as varchar(30) = '%'--default olarak tum sehirler gelecek
as
begin
	SELECT
	U.USERNAME_ AS [Kullanici Adi],
	U.NAMESURNAME AS [Musteri Adi],
	U.TELNR1 AS [Telefon 1],
	U.TELNR2 AS [Telefon 2], 
	C.COUNTRY AS Ulke, 
	CT.CITY AS Sehir,
	T.TOWN AS Bolge,
	A.ADDRESSTEXT AS [Acik Adres],                         
	O.ID AS [Siparis Id],
	ITM.ITEMCODE AS [Urunun Kodu],
	ITM.ITEMNAME AS [Urunun Adi],
	ITM.BRAND AS [Urunun Markasi],
	ITM.CATEGORY1 AS [Kategori 1], 
	ITM.CATEGORY2 AS [Kategori 2],
	ITM.CATEGORY3 AS [Kategori 3], 
	ITM.CATEGORY4 AS [Kategori 4],
	OD.AMOUNT AS [Stok Sayisi],
	OD.UNITPRICE AS [Birim Fiyati], 
	OD.LINETOTAL AS [Toplam Fiyat],
	CONVERT(date, O.DATE_) AS [Siparis Tarihi], 
	CONVERT(time, O.DATE_) AS [Siparis Saati], 
	DATEPART(YEAR, O.DATE_) AS Yil,
	CASE 
	WHEN DATEPART(MONTH, O.DATE_) = 1 THEN '01 - Ocak' 
	WHEN DATEPART(MONTH, O.DATE_) = 2 THEN '02 - Şubat' 
	WHEN DATEPART(MONTH, O.DATE_) = 3 THEN '03 - Mart'
	WHEN DATEPART(MONTH, O.DATE_) = 4 THEN '04 - Nisan' 
	WHEN DATEPART(MONTH, O.DATE_) = 5 THEN '05 - Mayıs' 
	WHEN DATEPART(MONTH, O.DATE_) = 6 THEN '06 - Haziran' 
	WHEN DATEPART(MONTH, O.DATE_) = 7 THEN '07 - Temmuz'
	WHEN DATEPART(MONTH, O.DATE_) = 8 THEN '08 - Ağustos'
	WHEN DATEPART(MONTH, O.DATE_) = 9 THEN '09 - Eylül' 
	WHEN DATEPART(MONTH, O.DATE_) = 10 THEN '10 - Ekim'
	WHEN DATEPART(MONTH, O.DATE_) = 11 THEN '11 - Kasım' 
	WHEN DATEPART(MONTH, O.DATE_) = 12 THEN '12 - Aralık'
	END AS Ay, 

	CASE 
	WHEN DATEPART(DW, O.DATE_) = 2 THEN '1 - Pazartesi'
	WHEN DATEPART(DW, O.DATE_) = 3 THEN '2 - Salı'
	WHEN DATEPART(DW, O.DATE_) = 4 THEN '3 - Çarşamba'
	WHEN DATEPART(DW, O.DATE_) = 5 THEN '4 - Perşembe' 
	WHEN DATEPART(DW, O.DATE_) = 6 THEN '5 - Cuma' 
	WHEN DATEPART(DW, O.DATE_) = 7 THEN '6 - Cumartesi'
	WHEN DATEPART(DW, O.DATE_) = 1 THEN '7 - Pazar'
	END AS [Haftanin Gunu]
	FROM  ORDERDETAILS AS OD INNER JOIN
	ORDERS AS O ON OD.ORDERID = O.ID INNER JOIN
	ITEMS AS ITM ON OD.ITEMID = ITM.ID INNER JOIN
	USERS AS U ON U.ID = O.USERID INNER JOIN
	ADDRESS AS A ON A.ID = O.ADDRESSID INNER JOIN
	COUNTRIES AS C ON C.ID = A.COUNTRYID INNER JOIN
	CITIES AS CT ON CT.ID = A.CITYID INNER JOIN
	TOWNS AS T ON T.ID = A.TOWNID INNER JOIN
	PAYMENTS AS P ON P.ORDERID = O.ID
	WHERE O.DATE_ BETWEEN @baslangicTarihi AND @bitisTarihi AND
	CT.CITY like @sehir
end

exec sp_Satislar '2019-01-01','2019-01-31'
-- sehir parametresini vermedigim halde calısıyor cunku sehir paremetresinin
-- default bir degeri var.

/*Burada aslında bir sikinti var. Simdi prosedurden bize bir sonuclar geliyor
lakin biz bu sonuclar uzerinde islem yapamıyoruz yani ornegin biz kategorısı
gida olan urunleri cekmek istiyoruz. Bunun icin tekrardan prosedure bunu bir 
parametre olarak verirsek sıkıntı olabilir. Cunku her sartimiz icin o zaman
prosedure bir parametre eklemis oluruz. Buda prosedurun yapısını bozabilir
yada bizim prosedure mudahele yetkimiz yoktur. Ama kategorisi gida olan 
urunleri de cekmemız lazım. Bunun icin yine tablolar kullanılır. Yani
prosedurden donen sonucları yine bir tabloya atabiliriz. Boylece 
tablo uzerınde istedigimiz sarti koyabiliriz. Peki Ahmet adli biri bu sonucları
bir tabloya attı diyelim adına da rapor adını verdi diyelim. Mehmet adli biri
de kategorisi oyuncak olan urunleri cekti o da sonucları bir tabloya atmak 
istedi ne hikmetse o da tabloya rapor adını vermek istedi. Lakın sistem buna
izin vermedi Cunku rapor adında bir tablo zaten vardı Ahmet olusturmustu.
Peki ne yapacaz tablo olusturamayacak mıyız. Tabi ki hayır. Boyle durumlar
da iste sistem databaselerinden biri olan tempdb hayat kurtarıyor. 
Konunun en basında sistem database'lerinden bahsetmistik. Tempdb bize gecici
islemler icin kolaylıklar saglıyordu. Örnegin iki farklı kullanıcı veya sunucu
aynı adda tablolar olusturabilirler birbirlerini görmezler ve o olusturulan
tablolar gercek tablolar olmakdıkarı icin işleri bittiklerinde silinirler. 
O zaman temp bir tablo olusturalım ve prosedurden donen sonucları ona atayalım
*/

create table #RAPOR
(
[Kullanici Adi]  varchar(50),
[Musteri Adi] varchar(100) , 
[Telefon 1] varchar(15), 
[Telefon 2] varchar(15),
Ulke varchar(50),
Sehir varchar(50),
Bolge varchar(50),
[Acik Adres] varchar(500),
[Siparis Id] int,
[Urunun Kodu] varchar(50),
[Urunun Adi] varchar(100),
[Urunun Markasi] varchar(50),
[Kategori 1] varchar(50),
[Kategori 2] varchar(50),
[Kategori 3] varchar(50),
[Kategori 4] varchar(50),
[Stok Sayisi] int,
[Birim Fiyati] float, 
[Toplam Fiyat] float,
[Siparis Tarihi] date,
[Siparis Saati] time,
[Yil] int,
[Ay] varchar(15),
[Haftanin Gunu] varchar(15)
)
--tempdb altında temporary tables altında gecici tablolarımızı gorebiliriz

-- simdi tabloya prosedurden gelen degerleri atayalım
insert into #RAPOR
exec sp_Satislar '2019-01-01','2019-01-31'
/*exec ile yine prosedurumuzu calıstırırız insert into ile 
sonucları temp tabloya atarız. Burada dikkat edilmesi gereken. Sutunların
turlerının uyması ona gore temp tablo olusturulur*/

select * from #RAPOR where [Kategori 1] = 'Gıda'

-- en sonda isimiz bittikten sonra temp table ramdan silinir.
-- calıstıgımız bu sayfa kapandıktan sonra silinir zaten
drop table #RAPOR

---------------------------------------------------------------

-- stored procedure'in istatistiklerine bakabiliriz boylece sistemde kim
-- ne kadar calısmıs, kim ne kadar surede calısmıs anlayıp iyilestirmeler 
-- yapabiliriz.
-- bu istatistikleri gormek icin asagıda ki kod yazılır.

select * from sys.dm_exec_procedure_stats

-- bu komut tum prosedurlerin istatistiklerini getirir lakin biz belli bir
-- database'in prosedurlerine bakmak istiyorsak asagıdaki komutu kullanabiliriz

select DB_NAME(database_id) as db_name,
OBJECT_NAME(object_id) as proc_name,*
from sys.dm_exec_procedure_stats where DB_NAME(database_id) = 'ETRADE'

/*Bu komutlar ile prosedurlerin performansini olculebilir oldugunu 
goruyoruz yani calısma süresi veya okudugu page sayisiyla performansi gorebiliriz
*/