--İndex bozulmaları(fragmentation)

/*Gercek hayatta veri tabaları boyle bizim yaptıgımız gibi statik degil. Gercek hayatta
veri tabanları dinamıktır. Veri sureklı eklenir veya silinir. Dolayısıyla bu islemler
yuzunden indexlerde de bozulma gorulur. Bu bozulmalar arama performansımızı kotu etkıler
Dolayısıyla bu da uzun suren sorgular anlamına gelir. Bu bozulmaları orneklendirecek
olursak. Elimizde yine telefonların kayıtlı oldugu bir defter olsun. Yeni bir kayıt
eklemek istedigimizde bu deftere. O an ki sayfaya kadar tum kayıtlar duzgun ve sıralı iken
yeni gelen kayıtlar atık sırasız bir hal almaa baslar. Sql'de bu olmaktadır. Yeni gelen 
kayıtlar sona eklendikce indexlerin bozulmasına neden olmaktadır.Cozumu ise indexlerin 
tekrardan olusturulması gerekır. Bu duzeltme tekrardan index olusturma islemine ise 
rebuild denir. Rebuild islemi database bakım planlarından biridir.Ayda bir hafta bir bu 
bakımlar yapılır.

İndex duzeltme islemleri maliyetli islemlerdir. Yani sistemler kapalı iken bu duzeltme 
islemleri yapilir. Ama bazı sistemler vardır ki 7/24 calısmak zorundadırlar. İste 
boyle sistemlerde index bozulmalarını geciktırmek icin bir islem vardır. Bu isleme 
fill factor denir.
Fill factor'u bir ornek uzerinden acıklamak gerekırsek elimizde yine telefonların kayıtlı
oldugu bir defter olsun. Biz bu defterin tum safyalarını full doldurmak yerine belli bir
mıktarını bos bırakarak yeni gelen kayıtlari ilgili yerlere yazarak daha kolay 
duzeltmeler yapılabiliriz.İste bu sql'de indexlerin bir miktarini bos bırakarak yeni gelen
kayıtlarda ilgili yerlere kayıt olur.Boylece index bozulmalarını geciktirmıs oluruz. Buna
fill factor(doluluk oranı) denir.

FILL FACTOR TABLOLARIN BOYUTUNDA HERHANGİ BİR DEGİSİKLİGE SEBEP OLMAZ

Bu ders icin CRM2.bak adlı database uzerinden calısacaz.
Onu yedekten donerek islemlerimizi yapabiliriz
*/
use CRM2

/*customers tablosunun altında ki indexlere baktıgımzda 4 tane index goruyoruz.
bunlardan birine cıft tık yaptıgımızda properties bolumune gelmis oluyoruz. Burada ise
fragmentation kısmına tıkladıgımzda indeximiz hakkında bilgilere sahip olabiliriz.Ornegin
page doluluk oranı(page fullness),toplam bozulma(total fragmentation),bu indexteki page
sayısı(pages), bir page'de ki minimum satır sayısı(minimum row size) veya bir page'de
bulunan maximum satır sayısı(maximum row size) gibi ozellikleri gorebiliriz.

yada kod ile gorebiliriz.
*/

SELECT a.index_id, name, avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(),
OBJECT_ID(''), NULL, NULL, NULL) AS a
JOIN sys.indexes AS b
ON a.object_id = b.object_id AND a.index_id = b.index_id;
/*tum tablolardaki index bozulmalarını gorebiliriz. Ayrıca sadece bir tablodaki 
index bozulmalarini gormek istiyorsak OBJECT_ID('') icine tablonun adını yazmak yeterlı
*/

/*goruldugu gibi indexlerimizde ki bozukluk oranı oldukca dusuk simdi bu indexleri
bozalım. Nasıl bozarız diye soracak olursan kayıt ekleyerek. programmability
altında stored procedures orada bir tana prosedur var. Bu prosedur 2500 kayıt
eklemeye yarıyor. Onu birkac defa calıstıralım ve indexleri bozalım*/

exec SPGENERATE_CUSTOMER

-- birkac defa calıstırdıktan sonra indexlerimizin fragmentation baya bozulmus
-- bu bozulmalar sorgularımızın daha gec gelmesi daha cok page okunması anlamına geliyor
/*Peki indexleri nasıl duzeltiriz. Bunun icin iki yol bir reorganize digeride rebuild
bozuk indeximizin ustunde sag tık yaptıgımızda bunlar karsımıza cıkar bunlardan birine
basar indeximizi duzeltırız veya kod ile de bu duzeltmeleri yapabiliriz.*/

ALTER INDEX IX1 ON Customers REORGANIZE
-- reorganize etmek icin alter index index_adi on tablo_adı reorganize yapısı kullanilir

ALTER INDEX ALL ON Customers REBUILD
-- rebuild etmek icinde alter index index_adi on tablo_adi rebuild yapısı kullanılir
-- burada all kullandik bunun anlamı customers tablosunda ki tum indexleri rebuild
-- et demektir

/*Peki reorganize ile rebuild arasında ki farka bakacak olursak. Reorganize
indexlerin icindeki verileri sılmeden kayıtları kendi aralarında duzeltir.
Rebuild ise indexi siler ve tekrardan duzelmıs halini olusturur. Genelde 
fragmentation yuzdesi %40 ustunde ise rebuild %40 altında ise reorganize yapılır.
Lakin bunların arasında ki farkta pek muhim degildir. İkside kullanilabilir. Ama
garanti olsun dıyorsan rebuild kullanmak daha iyidir.*/

-- birde fill factorden bahsetmıstık. fill factor ile indexlerin bozulmalarını 
-- geciktirebiliriz diye. Simdide onun uzerınde calısalım.

/*Fill factoru ayarlamak icin indeximiz uzerine cıft tık yaptıgımızda
option bolumunde fill factor bolumu var. Oradan fill factoru ayarlayabiliriz.
Ornegin 70 verirsek bunun anlamı indexin %70 dolu %30 bos olacak demektir.
Page fullness oranı bize ne kadar dolu oldgunu gosterir
bu islemin kod ile yapılısına bakalım bir de*/

CREATE NONCLUSTERED INDEX IX_NameSurname ON Customers
( 
	NAMESURNAME ASC 
) 
WITH ( FILLFACTOR = 70 )
/*sıfırdan bir index olustururken fill factor ayarı with ile veriliyor.*/

ALTER INDEX IX_NameSurname ON Customers REBUILD WITH (FILLFACTOR = 70)
/*yada daha onceden varolan bir indexin fill factor oranını degistirmek icinde
alter komutunun yanı sıra rebuild kullanılır. Cunku rebuild ederken index 
silinip tekrardan olusturuluyor demistik. Lakin reorganize yaparken fill factor
oranını degistiremeyiz cunku reorganize de indexi silme yoktur yani o indexin fill
factor oranı olusturulurken verilmis olmalıydı*/

ALTER INDEX IX_NameSurname ON Customers REORGANIZE WITH (FILLFACTOR = 70)
-- hatalı kod

ALTER INDEX ALL ON Customers REBUILD WITH (FILLFACTOR = 70)
-- bu komut customers tablosunda ki tum indexlerin fill factor oranını 70 yapar

/*eger biz bundan sonrakı olusacak tum indexlerin fill factor orani bizim 
belirledigimiz orana gore olussun diyorsak.Server bazında bir degislik yapmamız gerekir.
Bunun icin MSEDGEWIN10(server) sag tık yapıp properties kısmına gideriz. Buradan
database settingse tıklayarak zaten en uste fill factor ayarı cıkar. Buradan 
ayarlayabiliriz.*/

EXEC sp_helpdb crm2
/*Bunu calıstırırsak, sys.databases katalog görünümündeki tüm veritabanlarıyla 
ilgili bilgileri döndürür.*/

EXEC sp_databases
/*sistemde ki tum databaseleri ve boyutlarını gosterir KB cinsinden*/

use CRM2
exec sp_spaceused 
/*o an ki kullandigin database'in boyutunu ne kadarını kullandigini indexlerinin
boyutunu vs seyleri gosterir*/
