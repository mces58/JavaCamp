-- Fonksiyon Tanımlama

-- Scalar-Valued Funciton
use ETRADE

create function dbo.topla(@sayi1 as int, @sayi2 as int)
returns int
as 
begin 
	declare @sonuc as int
	set @sonuc = @sayi1 + @sayi2
	return @sonuc
end

/*
Fonksiyon tanımlamak icin create function ile baslarız.
Sonra fonkisiyonun adını dbo(data base owner) ile yazariz.
Varsa parametreleri geceriz. 
Sonra fonksiyonun donus tipini belirleriz returns kullanırız dikkat.
Sonra as begin end arasında fonksiyon ne yapacaksa onu yazarız.
En son da ne donderek isek onu return ile dondeririz.

Bu yazdıgımız fonksiyonu programmability altında functions altında 
scalar-valued function altında gorebiliriz.

İCERSİNDE İNSERT, UPDATE, DELETE İSLEMLERİ KULLANILMAZ.

Fonksiyonu kullanalim bakalım.
*/
print 'Sonuc: ' +convert(varchar(5),dbo.topla(12,34))


-- simdi bu fonksiyonu 3 parametreli hale getirelim
-- alter kullanarak degisikligi yapabiliriz
alter function dbo.topla(@sayi1 as int, @sayi2 as int, @sayi3 as int)
returns int
as 
begin 
	declare @sonuc as int
	set @sonuc = @sayi1 + @sayi2 + @sayi3
	return @sonuc
end

print 'Sonuc: ' +convert(varchar(5),dbo.topla(12,34,46))

--fonksiyonu silmek istiyorsak yine drop komutu kullanilir.

drop function dbo.topla


/*
simdi tablolar uzerinde calısarak fonksiyonlar tanımlayalım.
Parametre olarak dogum tarıhı alıp sonuc olarak yas donderen bir 
fonksiyon yazalım.
*/

create function dbo.calculateAge(@birthdate as date)
returns int
as
begin
	declare @age as int
	set @age = DATEDIFF(YEAR, @birthdate, GETDATE())
	return @age
end

select top 1000 *, dbo.calculateAge(BIRTHDATE) as AGE from USERS

-------------------------------------------------------
-- Boyle bir sorguda aylar ve gunler icin gereksiz kod var bunlar icin 
-- fonksiyon tanımlayalım
select 
U.USERNAME_ as 'Kullanici Adi', 
U.NAMESURNAME as 'Musteri Adi',
U.TELNR1 as 'Telefon 1',
U.TELNR2 as 'Telefon 2',
C.COUNTRY as 'Ulke',
CT.CITY as 'Sehir',
T.TOWN as 'Bolge',
A.ADDRESSTEXT as 'Acik Adres',
O.ID as 'Siparis Id',
ITM.ITEMCODE as 'Urunun Kodu',
ITM.ITEMNAME 'Urunun Adi',
ITM.BRAND as 'Urunun Markasi',
ITM.CATEGORY1 as 'Kategori 1',
ITM.CATEGORY2 as 'Kategori 2',
ITM.CATEGORY3 as 'Kategori 3',
ITM.CATEGORY4 as 'Kategori 4',
OD.AMOUNT as 'Stok Sayisi',
OD.UNITPRICE as 'Birim Fiyati',
OD.LINETOTAL as 'Toplam Fiyat',
CONVERT(date, O.DATE_) as 'Siparis Tarihi',
CONVERT(time, O.DATE_) as 'Siparis Saati',
DATEPART(YEAR, O.DATE_) as 'Yil',
case
	when DATEPART(MONTH, O.DATE_) = 1 then '01 - Ocak'
	when DATEPART(MONTH, O.DATE_) = 2 then '02 - Şubat'
	when DATEPART(MONTH, O.DATE_) = 3 then '03 - Mart'
	when DATEPART(MONTH, O.DATE_) = 4 then '04 - Nisan'
	when DATEPART(MONTH, O.DATE_) = 5 then '05 - Mayıs'
	when DATEPART(MONTH, O.DATE_) = 6 then '06 - Haziran'
	when DATEPART(MONTH, O.DATE_) = 7 then '07 - Temmuz'
	when DATEPART(MONTH, O.DATE_) = 8 then '08 - Ağustos'
	when DATEPART(MONTH, O.DATE_) = 9 then '09 - Eylül'
	when DATEPART(MONTH, O.DATE_) = 10 then '10 - Ekim'
	when DATEPART(MONTH, O.DATE_) = 11 then '11 - Kasım'
	when DATEPART(MONTH, O.DATE_) = 12 then '12 - Aralık'
end
	as 'Ay',
case
	when DATEPART(DW, O.DATE_) = 2 then '1 - Pazartesi'
	when DATEPART(DW, O.DATE_) = 3 then '2 - Salı'
	when DATEPART(DW, O.DATE_) = 4 then '3 - Çarşamba'
	when DATEPART(DW, O.DATE_) = 5 then '4 - Perşembe'
	when DATEPART(DW, O.DATE_) = 6 then '5 - Cuma'
	when DATEPART(DW, O.DATE_) = 7 then '6 - Cumartesi'
	when DATEPART(DW, O.DATE_) = 1 then '7 - Pazar'
end
	as 'Haftanin Gunu'

from
ORDERDETAILS as OD
inner join ORDERS as O on OD.ORDERID = O.ID
inner join ITEMS as ITM on OD.ITEMID = ITM.ID
inner join USERS as U on U.ID = O.USERID
inner join ADDRESS as A on A.ID = O.ADDRESSID
inner join COUNTRIES as C on C.ID = A.COUNTRYID
inner join CITIES as CT on CT.ID = A.CITYID
inner join TOWNS as T on T.ID = A.TOWNID
inner join PAYMENTS as P on P.ORDERID = O.ID

-- once ay adlarını getiren fonksiyonu yazalim.

create function dbo.monthName(@date as datetime)
returns varchar(10)
as
begin
	declare @result as varchar(10)
		if datepart(month, @date) = 1  set @result =  '01 - Ocak'
		else if datepart(month, @date) = 2  set @result =  '02 - Şubat'
		else if datepart(month, @date) = 3  set @result =  '03 - Mart'
		else if datepart(month, @date) = 4  set @result =  '04 - Nisan'
		else if datepart(month, @date) = 5  set @result =  '05 - Mayıs'
		else if datepart(month, @date) = 6  set @result =  '06 - Haziran'
		else if datepart(month, @date) = 7  set @result =  '07 - Temmuz'
		else if datepart(month, @date) = 8  set @result =  '08 - Ağustos'
		else if datepart(month, @date) = 9  set @result =  '09 - Eylül'
		else if datepart(month, @date) = 10  set @result =  '10 - Ekim'
		else if datepart(month, @date) = 11  set @result =  '11 - Kasım'
		else  set @result =  '12 - Aralık'
	return @result
end

-- sımdide haftanın gunlerini getiren fonksiyonu yazalım

create function dbo.weekDays(@date as datetime)
returns varchar(10)
as
begin
	declare @result as varchar(10)
	/*iflerin birden fazla satiri varsa begin end arasında yazılır*/
	if DATEPART(DW, @date) = 1 
	begin
		set @result = '07 - Pazar'
	end

	else if DATEPART(DW, @date) = 2 
	begin
		set @result = '01 - Pazartesi'
	end

	else if DATEPART(DW, @date) = 3
	begin 
		set @result = '02 - Salı'
	end

	else if DATEPART(DW, @date) = 4 
	begin 
		set @result = '03 - Çarşamba'
	end

	else if DATEPART(DW, @date) = 5 
	begin 
		set @result = '04 - Perşembe'
	end

	else if DATEPART(DW, @date) = 6 
	begin 
		set @result = '05 - Cuma'
	end

	else 
	begin 
		set @result = '06 - Cumartesi'
	end
	
	return @result
end

-- sımdi yukardakı kodu sadelestirelim.

select 
U.USERNAME_ as 'Kullanici Adi', 
U.NAMESURNAME as 'Musteri Adi',
U.TELNR1 as 'Telefon 1',
U.TELNR2 as 'Telefon 2',
C.COUNTRY as 'Ulke',
CT.CITY as 'Sehir',
T.TOWN as 'Bolge',
A.ADDRESSTEXT as 'Acik Adres',
O.ID as 'Siparis Id',
ITM.ITEMCODE as 'Urunun Kodu',
ITM.ITEMNAME 'Urunun Adi',
ITM.BRAND as 'Urunun Markasi',
ITM.CATEGORY1 as 'Kategori 1',
ITM.CATEGORY2 as 'Kategori 2',
ITM.CATEGORY3 as 'Kategori 3',
ITM.CATEGORY4 as 'Kategori 4',
OD.AMOUNT as 'Stok Sayisi',
OD.UNITPRICE as 'Birim Fiyati',
OD.LINETOTAL as 'Toplam Fiyat',
CONVERT(date, O.DATE_) as 'Siparis Tarihi',
CONVERT(time, O.DATE_) as 'Siparis Saati',
DATEPART(YEAR, O.DATE_) as 'Yil',
dbo.monthName(O.DATE_) as 'Ay',
dbo.weekDays(O.DATE_) as 'Haftanin Gunu'

from
ORDERDETAILS as OD
inner join ORDERS as O on OD.ORDERID = O.ID
inner join ITEMS as ITM on OD.ITEMID = ITM.ID
inner join USERS as U on U.ID = O.USERID
inner join ADDRESS as A on A.ID = O.ADDRESSID
inner join COUNTRIES as C on C.ID = A.COUNTRYID
inner join CITIES as CT on CT.ID = A.CITYID
inner join TOWNS as T on T.ID = A.TOWNID
inner join PAYMENTS as P on P.ORDERID = O.ID

----------------------------------------------------

-- Urun analızı yapalim simdide 
-- urunlerin en dusuk fiyatini, en yuksek fiyatini, ortalama fiyatini ve
-- toplam fiyatini getirelim

select
ITM.ITEMCODE as UrunKodu,
ITM.ITEMNAME as UrunAdi,
MIN(OD.UNITPRICE) as EnDusukFiyat,
MAX(OD.UNITPRICE) as EnYuksekFiyat,
AVG(OD.UNITPRICE) as OrtalamaFiyat
from ITEMS as ITM 
inner join ORDERDETAILS as OD on ITM.ID = OD.ITEMID
group by ITM.ITEMNAME, ITM.ITEMCODE

-- Simdi bu min, max ve avg islemlerini fonksiyon ile yapalim

create function dbo.minPrice(@itemId as int)
returns float
as
begin 
	declare @result as float
	select @result = MIN(UNITPRICE) 
	from ORDERDETAILS as OD where OD.ITEMID = @itemId
	return @result
end

create function dbo.maxPrice(@itemId as int)
returns float
as
begin 
	declare @result as float
	select @result = MAX(UNITPRICE) 
	from ORDERDETAILS as OD where OD.ITEMID = @itemId
	return @result
end

create function dbo.avgPrice(@itemId as int)
returns float
as
begin 
	declare @result as float
	select @result = AVG(UNITPRICE) 
	from ORDERDETAILS as OD where OD.ITEMID = @itemId
	return @result
end


-- toplam fiyatini getirelim

select
ITM.ITEMCODE as UrunKodu,
ITM.ITEMNAME as UrunAdi,
dbo.minPrice(ITM.ID) as EnDusukFiyat,
dbo.maxPrice(ITM.ID) as EnYuksekFiyat,
dbo.avgPrice(ITM.ID) as OrtalamaFiyat
from ITEMS as ITM
order by ITM.ITEMCODE

-- bu kod yaklasık 3 dakıka da 3 bin satır getirdi yani oldukca yavas
-- calısıyor. Bunun nedeni fonsyonlar satır satır calısır. Bunun hizlandirmak
-- icin yine indexlerden yararlanırız

CREATE NONCLUSTERED INDEX IX_OrderDetails_ItemId ON ORDERDETAILS 
( ITEMID )

exec sp_updatestats -- istatistikleride guncelleyelim

-- aynı sorguyu bir daha calıstıralım ve 3 saniyede getırdi tum kayıtları
-- bu ornektede indexlerin ne kadar onemli oldugunu goruyoruz

select
ITM.ITEMCODE as UrunKodu,
ITM.ITEMNAME as UrunAdi,
dbo.minPrice(ITM.ID) as EnDusukFiyat,
dbo.maxPrice(ITM.ID) as EnYuksekFiyat,
dbo.avgPrice(ITM.ID) as OrtalamaFiyat
from ITEMS as ITM
order by ITM.ITEMCODE

-- Table-Valued Function
/*Evet ne kadar da index kullansakta fonksiyonlar ile calısmak yavas 
bir işlemdir. Hele tek bir deger donderen fonksiyon ile calısmak. Bu tek deger
donderen fonksiyonlara Scalar-valued function denir.Yukarıda ki fonksiyonlar
Scalar-valued foksiyonlardır. Sql'de bir de tek deger donderen degilde tablo
donderen fonksiyonlarda yazmak mumkundur.Bunlara Table-valued function denir.
Eger biz tek sefer de birden fazla veri alacaksak Scalar-valued funciton
yerine Table-valued function kullanmak daha faydalı ve hızlıdır.*/

-- simdi bir tane table-valued funciton yazalım.
-- urunlerin bilgilerini geriye donderen bir fonksiyon

create function dbo.itemInfo(@itemId as int)
returns table
as
return
(
	select 
	MIN(UNITPRICE) as MinPrice,-- bunları bu tablonun bir sutunu gibi dusun
	MAX(UNITPRICE) as MaxPrice,
	AVG(UNITPRICE) as AvgPrice
	from ORDERDETAILS where ITEMID = @itemId
)

/*
table-valued function yazarken returns olarak table yazarız
burada begin-end yoktur. return icerisine sorguyu yazarız direk
*/
-- itemInfo bir tablo dikkat et. Verdigim id'ye gore o urunun
-- fiyatini getiriyor.tablo oldugu icin tekrardan dbo yazmaya gerek yok
select * from itemInfo(2)

-- simdi tum urunleri getiren sorguyu yazalım

set statistics time on
select 
ITM.ID as UrunId,
ITM.ITEMCODE as UrunKodu,
ITM.ITEMNAME as UrunAdi,
ITMINFO.MinPrice as EnDusukFiyat,
ITMINFO.MaxPrice as EnYuksekFiyat,
ITMINFO.AvgPrice as OrtalamaFiyat
from ITEMS as ITM
cross apply 
itemInfo(ITM.ID) as ITMINFO

/*burada inner join ile birbirine baglayamazdık tabloları cunku biri gercek
tablo biri tablo donduren fonksiyon dolayisiyla burada cross apply 
kullandik cunku biri gercek bir tablo(items) digeride tablo donduren 
fonksiyon(itemInfo)

set statistics time on ile ne kadar sure cpu'da calıstıgını gorebiliriz
*/