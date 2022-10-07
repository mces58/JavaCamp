-- İstatistikler

use CRM2
select * from CUSTOMERS where NAMESURNAME = 'Ada Sözüer'
-- bu sorgudan 4 tane sonuc donuyor.Bu sorgu icin IX1 indexini kullaniyor

select * from CUSTOMERS where BIRTHDATE = '1996-03-09'
-- bu sorgudan 145 tane sonuc donuyor.Bu sorgu icin IX3 indexini kullaniyor

select * from CUSTOMERS where NAMESURNAME = 'Ada Sözüer' and BIRTHDATE = '1996-03-09'
-- Bu sorgudan bir tane sonuc donuyor.Bu sorgu icin de IX1 indexini kullaniyor.

/*
Peki soru su neden son sorgu da IX1 indexini kullaniyor?

Cunku 4 tane deger donderen icinde tarih aramak daha kolay oldugu icin once ada
sozueri buluyor bunun icinde IX1 kullaniyor sonrada tarıhe bakıyor.IX1 kolaya geliyor.

Peki sql nereden biliyorda IX1'i kullanarak arama daha kolay oluyor diyor.yani nereden
biliyor da 4 tane adı sozuer uzerinden arama yaparsam daha kolay bulurum diyor?

Bunun cevabi istatistiklerdir. istatistikler uzerinden anlıyor ve ona gore indexi 
secip arama yapıyor.

istatistikler:
SQL Server’da Query Optimizer, bir sorgunun nasıl çalıştırılacağıyla ilgili 
alternatifleri inceleyip karar veren bir yapıdır. Bu kararı verirken veri dağılım 
şeklinin çok önemli olduğu durumlar da olur. Mesela bir koşul acaba 100 bin satırdan
3′ünü mü döndürüyor yoksa 30 bini mi, bunu bilmesi gerekir ki indeks kullanıp 
kullanmamaya karar versin.
İstatistikler sayesinde, sorgu planı (Query Plan) oluşturulurken sorgudaki where 
bloğunda kullanılan kolon için dönecek tahmini kayıt sayısı bulunur. Bulunan bu d
eğer index’e erişim şeklini belirler. Temel amaç, datayı en hızlı ve en az maliyetli
şekilde kullanıcının karşısına getirmektir.

istatistikler icin ayri bir klasor vardır. Oradan o tabloya ait istatistikleri 
gorebiliriz. Goruldugunu gibi her index icin bir istatistik vardir ve buradan bilgi
alarak ona gore sorgularında index kullanimi yapar.

istatistiklerden birinin ustune cıft tıklayarak sonra da detail bolumune tıklayarak
hangi kayıtlarda kac tane var bunun bılgısını alabiliriz.

İstatistikler ne kadar guncel ise bizim sorgu performansimiz o kadar artar(iyi anlamda)
cunku dogru indexi bulması o kadar kolay olur.

istatistikleri guncellemek indexleri guncellemeye gore daha kolaydır dolayısıyla
istatistikler neredeyse gunluk guncellenir.

peki istatistikler nasıl guncellenir?
istatistikleri guncellemenin 3 yolu var 
*/

--1- rebuild veya reornagize yaparak. Lakin bu islemler zahmetli islemlerdir.
alter index all on customers reorganize
alter index all on customers rebuild

--2- sp_updatestats
exec sp_updatestats
-- calısılan veri tabanının tum istatistiklerini gunceller

--3- update statistics customers
update statistics customers
-- bir tablonun istatistiklerini gunceller

exec sp_helpstats customers,'all'
/*customers tablosunda ki istatistikleri ve bu istatistiklerin neye gore 
olustugunu veren sorgu*/

exec sp_statistics 'customers'
/*bu sorgu yukarıdakine gore daha detaylı bilgi veriyor*/