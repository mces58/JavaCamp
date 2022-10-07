-- Viewlar

-- Bu konu icin ETRADE.bak dosyasi kullanilmistir
-- Yedekten donerek calısabilirsin

select 
U.USERNAME_ as 'Kullanıcı Adı', 
U.NAMESURNAME as 'Müşteri Adı',
C.COUNTRY as 'Ülke',
CT.CITY as 'Şehir',
T.TOWN as 'Bölge',
A.ADDRESSTEXT as 'Açık Adres',
O.ID as 'Sipariş Id',
O.DATE_ as 'Sipariş Tarihi',
ITM.ITEMCODE as 'Ürünün Kodu',
ITM.ITEMNAME 'Ürünün Adı',
ITM.BRAND as 'Ürünün Markası',
OD.AMOUNT as 'Stok Sayısı',
OD.UNITPRICE as 'Birim Fiyatı',
OD.LINETOTAL as 'Toplam Fiyat'
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

/*
Goruldugu gibi bizim tum bilgileri cekmek icin her defasında bu kadarlik bir
sorgu yazmamız gerekiyor. Bunun her defasında boyle yazmak yerine aslında 
gercekten tablo olmayan ama tablo gibi gorunen viewlar kullanılır. Boylece 
sorgu yukunden kurtulur ve view uzerinde calısma yapabiliriz.
View:
Bir veya birden fazla tablodan, ihtiyaç duyulan verileri almamızı saglayan sanal 
tablolardır.Normal şartlarda bir tablo sadece kendi verilerini içerebilir, ancak 
bir View birçok tablonun birleşiminden oluşabilir ve bir tablo gibi davranabilir.

* Sanal bir tablo gibi düşünülebilir.

* Bir View, içeri üzerinden sorgulama yapılmasına izin verir.

* View üzerinden veri girilebilir. Bir View üzerine eklenen, silineni güncellenen
kayıtlar tabloya aynen yansıtılır. Ancak View birden fazla tablo içeriyorsa ve 
veriler arasında ilişkisel bütünlük yoksa, View girilen verileri kabul etmez.

* View'ler veri saklamaz, tablodan veya birçok tablolardan yapılan sorgular
neticesinde, oluşturduğu tabloya bağlı olarak çalışır. Yani bağlı olduğu tablolar
silinirse, View hiçbir veri görüntüleyemez.

* Views tablo/tablolara bağlı olarak çalışır, böylece veri bütünlüğünü korumuş olur.

* View ile içerdiği tabloların veri erişimini sınırlandırmak mümkündür.

* View'e tabloymuş gibi select komutu yazılabilir.

* View için index tanımlamak mümkündür.

* Create ile oluşturulur, Alter ile değişiklik yapılır, Drop ile silinir.
*/

-- Bir tane view olusturalım

create view VW_Orders as
select 
U.USERNAME_ as 'Kullanici Adi', 
U.NAMESURNAME as 'Musteri Adi',
C.COUNTRY as 'Ulke',
CT.CITY as 'Sehir',
T.TOWN as 'Bolge',
A.ADDRESSTEXT as 'Acik Adres',
O.ID as 'Siparis Id',
O.DATE_ as 'Siparis Tarihi',
ITM.ITEMCODE as 'Urunun Kodu',
ITM.ITEMNAME 'Urunun Adi',
ITM.BRAND as 'Urunun Markasi',
OD.AMOUNT as 'Stok Sayisi',
OD.UNITPRICE as 'Birim Fiyati',
OD.LINETOTAL as 'Toplam Fiyat'
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

select * from VW_Orders
-- sanki bir tablo gibi calısıyor ve bizi uzun join islemlerinden kurtarıyor.

select * from VW_Orders  where Sehir = 'Sivas' order by Bolge

-- Gercek hayat ornekleri 1 ile devam edelim.

create view VW_Aylara_Gore_Satislar as
select 
DATEPART(YEAR, O.DATE_) as 'Yil', DATEPART(MONTH, O.DATE_) as 'Ay',
SUM(AMOUNT) as 'Toplam Miktar', SUM(LINETOTAL) as 'Toplam Tutar',
COUNT(OD.ID) as 'Urun Sayisi', COUNT(distinct O.ID) as 'Musteri Sayisi'
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

group by DATEPART(YEAR, O.DATE_), DATEPART(MONTH, O.DATE_)

select * from VW_Aylara_Gore_Satislar order by Yil, Ay

/*sonradan gelen bir talep ustune ay numaraları degil de ayların adları olsun
denilirse alter ile view degistirebiliriz*/

alter view VW_Aylara_Gore_Satislar as
select 
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
SUM(AMOUNT) as 'Toplam Miktar', SUM(LINETOTAL) as 'Toplam Tutar',
COUNT(OD.ID) as 'Urun Sayisi', COUNT(distinct O.ID) as 'Musteri Sayisi'
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

group by DATEPART(YEAR, O.DATE_), DATEPART(MONTH, O.DATE_)

select * from VW_Aylara_Gore_Satislar order by Yil, Ay


-- Gercek hayat ornekleri 2 ile devam edelim.

create view VW_Detayli as
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

select * from VW_Detayli 

/*viewlar illa joinli yapılarda kullanilmiyor
select'in dondurgu her seyin basına bir create view yazarsan olur sana
view tablosu
*/

create view VW_Can
as
select 'mehmetcan' as name
/*icinde sadece mehmetcan yazan bir view name burada kolon ismi*/

/*view'lar uzerinde de index tanımlayabiliyoruz boylece sorgu 
performansimizi artırabiliriz.*/

set statistics io on
select * from VW_Detayli where [Musteri Adi] = 'Oğuz Çankırılı'

/*goruldugu gibi her tablodan belli miktar page okumus.
Simdi hesabini yapalım.
Users - 153
Towns - 18
Cities - 18
Countries - 18
Address - 18
Orders - 1471
Payments - 696
Items - 113
Orderdetails - 3004

simdi execution plan yaparak sql bu sorguyu nasıl getirmis bir bakalım.
Evet oldukca dallanma yaparak getirmıs. Bize onerdigi indexi olusturalım ve
ondan sonra sorguyu bir daha calıstıralım.
*/


CREATE NONCLUSTERED INDEX IX_Orders
ON Orders
(
	USERID
)

set statistics io on
select * from VW_Detayli where [Musteri Adi] = 'Oğuz Çankırılı'
/*
Users - 454
Towns - 18
Cities - 18
Countries - 18
Address - 18
Orders - 2
Payments - 696
Items - 113
Orderdetails - 3004

goruldugu gibi orders tablosuna gore bir index olusturdugumuz icin oradaki okunan
page sayısı 1471'den 2'ye indi.
*/

-- birde orderdetails gore index olusturalim

create nonclustered index IX_Order_Details on ORDERDETAILS
(
	ORDERID
)

set statistics io on 
select * from VW_Detayli where [Musteri Adi] = 'Oğuz Çankırılı'

/*
simdi okunan page'lere baktıgımız da ise
Users - 153
Towns - 18
Cities - 18
Countries - 18
Address - 18
Orders - 20
Payments - 696
Items - 108
Orderdetails - 183

*/

-- view'lerimizi istersek sifreleyebiliriz. Boylece kullanici tarafından 
-- okunabilir hale gelir yani kullanici daha uzerinde degisiklik yapamaz
-- simdi bir tane sifreli view olusturalım

create view VW_Sifreli
with encryption as
select Sehir, [Haftanin Gunu], SUM([Toplam Fiyat]) as 'Toplam Fiyat'
from VW_Detayli
group by Sehir, [Haftanin Gunu]

select * from VW_Sifreli
/*sifrelemek icin with encryption ifadesi kullanilir.
Lakin artık design yapamayız yanı bu kodu kaybedersek bir daha baska bir yerden
bulamayız dolayısıyla sifreli view'larin kodunun yedegi alınır.*/

/*view'larda insert update vs. yapmal mumkun. Calıstıgın view uzerinde sag tık 
yaptıgında script view as basarak hangi islemi yapıyorsan ona gore bir script
cıkarıyor sql.*/