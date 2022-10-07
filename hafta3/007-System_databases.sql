/*sistem databaselerine giris

Her bir database icin sadece iki tane dosya vardır ve uzantıları .mdf ve .ldf'tir.

sql server sistem databaseleri olan master db model db ms db tep db ile 
kendini yonetir. Bunlarin icinde de en onemlisi master db idir. 

Master db
Bu kadar onemli olmasının nedeni sistem konfigrusyanu hakkuında tum bilgiler tutulur .
kullanıcılar, veritabanlari, sistem dosyalari, collation bilgisi gibi 
temel konfigurasyon bilgileri tutar master db.
Master db olmaz ise sql server calısmaz
.mdf ve log.ldf dosyaları

Model db
Sablon veritabanıdır.
Her bir olusturalacak veritabanı medel db'nin bir kopyasi olarak olusturulur.
Her veritabanın da otomatik olarak olmasını istedigimiz tipler, fonksiyonlar,
tablolar vs varsa bu vertabanının icine konulabilir
Model db olmaz ise sql server calısmaz
.mdf ve log.ldf dosyaları

Ms db
Sql server agent servisinin kullandigi veritabanidir.
Periyodik olarak calıstırılan her turlu islemler
(jobs, schedules, alerts)burada tutulur
Ms db bozulması sql server'in calısmasına engel degil iken
sql server agent'in calısmasına engel olmaktadır.
sql server agent calısmaz ise periyodik islemler yapılamaz

Temp db
Gecici tabloların olusturuldugu islemler burada gerceklesir.
Kullanici veritabanlarından cekilen dataları group by, order by, sum, count,
max, min gibi komutlarla ozetlemek amacıyla kullandıgımız aggregation islemleri
icin de temp db kullanilir
temp tablo olusturmak icin normal bir db olustur.
tablo adı verirken basına # isaretini koy
boylece temp tablo olusur. temp tabloları diskte yer kaplamaz
ram'de calısır. yanı calısma sayfasını kapattıgında tabloda 
silinir. Bir calısma sayfasında olusturdugun temp tabloyu
diger calısma sayfasından da ulasamazsın . ulasmak icin 
tabloyu olustururken isimin basına 2 tane # koymalısın
temp tabloları gercek tablolar degildir yanı kısacası
temp db olmasa bile sql server acılırken yine de 
kendi kendine olusturur
*/