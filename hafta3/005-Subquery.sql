--Subquery 

-- urunlerin fiyat analizi
use Northwind

/*sub query ile birden fazla alt sorgu yapabiliriz. burada joinler ile de yapýlabilirdi boylece daha uzun bir
kod yazmýs ama daha okunabilir durmaktadýr ayný kodun birde joinlerle yapalim*/

select p.ProductID as urun_kodu, p.ProductName as urun_adi,
(select min(UnitPrice) from [Order Details] where p.ProductID = [Order Details].ProductID) as en_dusuk_fiyat,
(select max(UnitPrice) from [Order Details] where p.ProductID = [Order Details].ProductID) as en_yuksek_fiyat,
(select avg(UnitPrice) from [Order Details] where p.ProductID = [Order Details].ProductID) as ortalama_fiyat,
(select sum(Quantity) from [Order Details] where p.ProductID = [Order Details].ProductID) as toplam_adet
from Products as p

order by p.ProductName
------------------------------------------------------------
-- urun fiyati analizi
select p.ProductID as urun_kodu,
p.ProductName as urun_adi,
min(od.UnitPrice) as en_dusuk_fiyat,
max(od.UnitPrice) as en_yuksek_fiyat,
avg(od.UnitPrice) as ortalama_fiyat,
sum(od.Quantity) as toplam_adet

from [Order Details] as od

inner join Products as p on od.ProductID = p.ProductID

group by p.ProductID, p.ProductName
order by p.ProductName

/*nerede subquery nerede join kullanacagimiza karar verebilmek icin sorgumaza bagli oldugu gibi okunabilirlik
ve performansa da baglidir. performansi gorebilmek icin asagida ki komut kullanilabilir*/

set statistics io on
/*bu komutu sorgu ile beraber calýstýr
messages bolumune gelip oradan hangi tablodan kac tane okuma yapmýs bunu gorebiliriz. boylece iki sorgu 
arasýnda ki okuma farkýný gorebiliriz. peki bu okuma degerinin turu nedir diye sorarsan yani kb mi mb mi gb mi?
bu okuma ýsleminin turu page'dir. her page 8 kilobyte denktir. burada hesaplamaya katacagýmýz yer logical page sayýsýdýr*/
-- bu sorgu icin performansi hesaplayalim
select (154 + 11) * 8 / 1024.0 as megabyte --megabyte cýnsýnden performansi bulduk yukarýda ki sorgu icinde perfonmans bulunabilir
--------------------------------------------------------------------------------------------------------