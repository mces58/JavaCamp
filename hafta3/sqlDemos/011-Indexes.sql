-- Indexler

-- sql server'in en kucuk yapı tası page'lerdir ve her page'de 8kb'tan olusur.
/*
Veri tabanlarinin cogunlugu genel olarak okuma islemi yapar. Az bir kısmı ise 
yazma islemi yapar.Bu durum da veri tabanlarında okuma perfomansini artıracak 
her turlu islem veritabani sunucusunun performasının artırılmasında da dogrudan 
etkili rol oynayacaktır. İste bu  performansi artırmanın en etkılı yollarından
biriside indexlerdir.

Peki index nedir?
İndeks, verilerin indeksleme alanına göre sıralanmış ve tablo halini almış şeklidir.
Belirli bir sıra düzenine geçmek için indeks yapısı kullanılır. Bu şekilde veriler
istenilen sıraya göre dizilmiş olur ve verilerin olduğu sıradan daha farklı
şekilde görünümü sağlanır.

İndeks Oluşturmanın Faydaları?
Veritabınında saklanan verilerin sayısı arttıkça performansta düşüklüğe neden olur.
Dağınık bir yapıda olan verilerde istenilen veriyi aramak için tablo taraması
işlemi yapılır. Bu işlemi küçük boyutlu bir tabloda yapmak kolaydır. Artan veri
miktarına göre ise bu işlem vakit kaybettirir. Veriye erişim hızını arttırmak
için bu yöntem kullanılır.

İndexlerin amaçlari?
İndekslemenin amacı işlenen verinin daha az veri okunarak sorgu sonucunun daha
kısa zamanda getirilmesini sağlamaktır. Indeksleme kullanarak tablonun tamamını
okumaktansa oluşturacağımız indeks key'i aracılığı ile okumak istediğimiz kayıda
ulaşabilmemiz daha hızlı bir şekilde mümkün olacaktır. Bu sayede tamamlanması
saatler süren sorgunun uygun indeksler kullanılarak saniyeler içinde getirilmesini 
sağlayabiliriz.

Örnekler uzerinden gidecek olursak:

Elimizde bir sehirin ev telefonlarının kayıtlı oldugu bir defter olsun. Defterde ki
kayıtlı kısıler rastgele bir sırada yazılmıs olsun yani herhangi bir duzen olmadan.
örnegin ilk kayıt zeynep olsun sonraki kaan olsun gibi...(suana kadar ki durumu
sql'e benzetmek gerekirse elimizde bir tablo var ve bu tablo da primary key yok
kayıtlar ratgele ekleniyor. Duzen yok kısacası) Sımdı biz bu defterden Mehmetcan 
isimli kisinin ev telefonunu ogrenmek istiyoruz.(sql isetablomuzdan Mehmetcan
isimli kayıdı arıyoruz demek olur.) Neler yapabiliriz senaryolara teker
teker bakalım.

1. senaryo: Defterin en basını acarız ve tum kısılere teker teker bakarız taki 
istedigimiz kisiyi bulana kadar. Bu senaryo bizim icin en kotu senaryodur. Cunku
aldukca zaman ve performans harcamamız gerekır(sql'de ki benzetmesi aynıdır. 
Sql'de tablonun en basından baslar sonra teker teker tum kayıtları gezer sonunda 
aradıgımız kisiyi getirir. Bu duruma/aramaya/isleme sql'de table scan
[linear search'de benzemektedir.] denir.)

Anladık ki bu senaryo bizim icin en kotu durumdur.Simdi senaryoyu degistirelim.

Bu defter bizi cok yoruyor dedik ve cope attık(sql'de de tabloyu sıldık diyelim.)
ve yeni defter almaya karar verdik ama bu sefer isimlerin duzenlı, siralı bir
sekildeki olan defteri aldık.(sql'de ise tablomuzda primary key var kayıtlar o 
sıraya gore duzenleniyor.)

Biz yine Mehmetcan isimli kullaniciyi arıyoruz.

2. senaryo: Bu seferki defterimiz daha derlı toplu ama yine de Mehmetcan isimli
kisiyi bulmak icin tek tek bakmamız gerekıyor. İlk senaryoya gore iyi ama yine de
fazla performans isteyen bir durum.(sql'de ki benzetmesi ise ayni, veriler duzenli
lakın arama icin yine fazla performans gerekiyor. Boyle aramaya biz sql'de 
clustured index arama deniyor. Aslında her primary key otomatık olarak clustured
index olmaktadır.)

Anladık ki bu senaryo da is yapmıyor. Diger senaryoya gecelim.

3. senaryo: Bu sefer bu defter elimizde kalsın diyoruz sonucta duzeli, sırali 
bir sekilde yazılmıs isimler(sql'de ki benzetmesi bu tablomuz kalsın sonucta 
primary key var.)lakin bu deftere ek ikinci bir defter daha alalım ama alacagımız
bu defter sadece isimlerin alfabetik siralaması ve yanlarında ki numaraları 
seklinde olsun dıyoruz.(iste bu yapının sql'de ki karsılıgı nonclustured index 
oluyor. Biz isimlere gore index olusturmus oluyoruz).

Simdi Mehmetcan isimli kisiyi tekrar arayalım.

Sadece ikinci defterde arama yapacagız. Burada arama yaparken defteri
bastan baslayıp teker teker arama yapmaya gerek yok.Cunku bu ikinci defter
zaten isime gore sıralı. Aramayi soyle yapacagız. Defteri ikiye bolerız. Diyelim ki O 
harfi ile baslayan isimler geldi o zaman O harfinden sonra ki gelen isimlere bakmaya
gerek yoktur. Cunku biliyoruz ki O M'den buyuk dolayısıyla simdi ki bakacagımız yer
A ile O harflerinin ortası. Boyle her defasında ikiye bolerek Mehmetcan isimli
kisiyi bulacagız.(sql'de aynı sekilde indeximiz ikiye bolerek arama yapar bu 
aramaya binary search denir.) Evet kisiyi bulduk diyelim ve yaninda 2145 gibi bir 
sıra numarası yazsın. Simdi asıl defterimize giderek bu numarayı buluruz ayni sekilde
ikiye bolerek. Sonucta asıl defterimizde numaralara gore sıralı idi.En sonda bu 
numaraya karsılık gelen kisiyi buldugumuzda telefon numarasınıda bulmus olacagız.
(sql ise aynı islemler burada da var.İndex uzerinden aradıgımız kisinin id'sini
alırız sonra tabloya donerek id'yi arariz ikiye bolme ile. sonucta id'ler de sıralı
bir sekide artmaktadir. En son id bulunur ve o kayıdın tum bilgileri bulunmus olunur.
Bu isleme yani indexe git aranan degeri bul sonra id'si ile tabloya don orada id ile
arama yapma islemine KEY LOOKUP denir.)

Bu islem hem az maliyet hem de az performans gerektiren islem oldu. Maliyet 
diyorum sonucta defter satın alma bir maliyet ustune gitdik ikinci bir defter daha
aldık bu da bir malıyet ama ikinci defter daha az maliyet cunku sadece isimlerden 
olusuyor.(Bunun sql'de ki karısılıgı su: Asıl tablo bir yer kaplar bu bir maliyet
sonra index bir yer kaplar bu da bir maliyet ama index tablo kadar yer kaplamaz 
cunku sadece isimlerden olusmustur.)

Peki bundan daha hizlı, daha az performans gerektiren bir arama yapabilir miyiz diye 
soracak olursak ? 
Tabiki yapabiliriz. Goruldugu gibi 2. senaryoda index'te bir deger bulunuyor sonra
asıl tabloya donuluyordu yani key lookup vardı. Bu ara islemi aradan kaldırarak daha
hizlı calısan sorgular yazabiliriz. Peki key lookup nasıl kaldırırız. Bunu defter 
ornegi uzerinden acıklayalım. Biz ikinci bir defter almıstık sadece isimlerden olusan.
Bizim bu ikinci defteri sadece isimlerden olusmasın diger tum bilgilerde olsun dersek
ve bu defteri de isimlere gore siralar isek key lookup islemi aradan kalkmıs olur. 
Aslında biz birinci defterin kopyasını olusturduk sadece tek fark var bu defter 
isimlere gore sıralı. Yine ikiye bolme ile hemencecik aradıgımız kayıdı buluruz
ve tum bılgilerine ulasmıs oluruz. key lookup'ta ki gibi asıl tabloya gidim orada 
id uzerinden arama yapım falan olmaz.Sql'de bu diger tum kolonlarında indexe dahil
olmasına included column denir.

peki included columun dezavantajı nedir diye soracak olursak?
bunun cevabi maliyettır. Yani indeximiz daha fazla yer kaplar. Cunku tablomuzun
kopyasını olusturduk yanı aynı tablodan iki tane var. tek fark biri id'ye gore sıralı
digeri isimlere gore siralı.Biz burada indeximizi hep isimlere gore olusturduk
ama bu boyle olmak zorunda degil ister isimlere ister dogum gunu tarıhlereni gore 
ne uzerınde valısma yapıyorsak artık

İndex cesitleri:

1- Clustured İndex:
Clustered index bir tabloda yanlızca bir tane olur. Aslında bunu hepimiz kullanıyoruz
genelde.(primary key) Clustered index ile tablodaki kayıtlar, fiziksel olarak 
indeksleme alanına göre dizilmiş şekildedir.

Primary key – Clustered Index farkı nedir?
Tam bu noktada kafa karışıklığını önlemek için primary key ve clustered indexin 
farkını netleştirmek istiyorum. Primary key dediğimiz, tablodaki kaydın uniqueliğini
garantileyen bir alandır ve kaydın kimliğidir. Tanımlandığı gibi de clustered index
özelliği taşır. Peki clustered index nedir? Yukarıda da anlattığımız gibi bir veri
yapısı, dataya daha hızlı ulaşmak için oluşturulmuş bir indexleme şeklidir.
Genel olarak datanın fiziksel sıralamasını düzenleyerek dataya ulaşma süresini
optimize etmeyi amaçlarken, keyler ise datanın uniqueliğini sağlar.

2- Nonclustered İndex:
Non-clustered indexlemede durum biraz daha farklıdır. Bir kolonu Non-clustered 
index olarak indexlediğinizde, arka tarafta yeni bir tablo oluşur ve bu tablo 
sizin indexlediğiniz kolona karşılık kolon adresini tutar. Yani bir nevi pointer 
yapısı gibi düşünebilirsiniz. Non-clustered indekste verilere direkt erişilemez. 
Elde edilen indeksleme yapısına erişmek için kümelenmiş indeks yapısı kullanılmış
olur. Verileri herhangi bir alana göre sıralandığında erişim kümelenmiş indeks 
üzerinden anahtar değer referans alınarak yapılır. 

3- Unique İndex:
İndeksteki indeksleme alanı olarak seçilen sütundaki verilerin tekrar 
kullanılmaması için bu yapı kullanılır. Veriye erişim hızını arttırır. 
Bu indeksleme çeşidi kümelenmiş ve "nonclustered" indeksler üzerinde kullanılabilir.

indexler konusunu daha iyi anlamak icin buyuk bir veri tabanına ihtiyacimiz var.
Bunun icinde CRM.bak adlı dosayayı yedekten donmeliyiz.Databases kısmına sag tık yap.
Sonra restore database tıkla. Orada device kısmına tıkla ve CRM.bak dosyasının 
yolunu goster. Bu kadar.
 */

-- yedekten donmus halinde tabloda primary key var bir tane index var bunları silelim
-- sıfırdan kendimiz yapalım
use CRM
alter table customers drop constraint PK_CUSTOMERS
-- primary key silme PK_CUSTOMERS key'in adi idi.

drop index customers.IX1
-- index silme tablo adı ve index adi

select * from CUSTOMERS where NAMESURNAME like 'Mehmetcan ESER'
/*bu sorguyu calıstırdıgımızda bize gore oldukca hizli calısyor gibi gorunebilir
lakın arka planda nelerin dondugunu ogrenmemiz gerekiyor. Bizim sql'e bu 
sorguyu nasıl getirdin veya bu sorguyu getırmek icin hangi yollara basvurdun diye
sormamız gerekıyor. Boyle bir soruyu sormak oldukca kolay execute butonun 2 sagında
bulunan diplay estimated execution plan adlı bir buton var. Ona basarak bu soruyu
sormus oluruz yada ctrl + l basarak ta ayni islemi yapmıs oluruz*/

/*evet execution dedigimizde sql bize bu sorguyu getirmek icin table scan 
yontemini kullanmıs. Bu yontem yukarıda da acıklamıstık oldukca kotu bir yontem idi.
Peki neden table scan yapar diye soracak olursak ? cunku tablomuzda primary key 
yok dolayisiyla table scan yapar. O zaman tablomuza bir tane primary key ekleyelim.
*/

alter table customers add primary key(ID)
-- bu sorgu ile bir tane primary key ekleriz lakın primary key'in adı default olarak
-- sıstem tarafından verilir.Primary key'in adini bizim verebilecegimiz bir 
-- sorgu yazalım

alter table customers add constraint PK_Customers primary key(ID)
-- key'in adını PK_Customers koyduk

-- simdi aynı sorguyu bir daha calıstıralım ve execution plan yapalım
select * from CUSTOMERS where NAMESURNAME like 'Mehmetcan ESER'
/*bu sefer ise bu sorguyu getirebilmek icin clustered index scan kullanmıs.
Neden bunu yaptı cunku tabloda primary key var. Clustered index scan ne demek?
fiziken tabloda ki verilerin sıralanma seklı yazılma seklıdır.Lakin isme gore 
bir sıralama yok. Sayisal bir sıra var. Defter orneginde vermistim. 2. senaryoya 
ornek burası.*/

-- bakalım bizim sorgumuzu getirmek icin sql ne kadarlık bir okuma yapıyor.
-- set statistics io on ne kadarlık okuma yaptıgını gosteren komuttur.
-- messages bolumunden sonucu gorebilirsin.
set statistics io on
select * from CUSTOMERS where NAMESURNAME like 'Mehmetcan ESER'
-- evet sql bu komudu getirebilmek icin 31188 tane okuma yapıyor. Peki bu 31188 tane
-- okunan seyin birimi ne diye soracak olursan ? bunun birimi page olmaktadir.
-- yani bu basıt sorgu icin sql 31188 tane page okumaktadır. Bunu daha iyi anlamak 
-- icin basıt bir hesaplama yapalım

select 31188 * 8 / 1024.0
-- buradan 243 MB gelmektedir. Yani bunun anlamı tek bir kayıt icin 243 MB dosya 
-- okuması yapmaktadır.

/*Aklımiza hemen su soru gelebilir. Bu tablonun boyutu nedir ki bu sorgu icin
243 MB dosya okuyor.Tablonun boyutu ogrenmek icin exec sp_spaceused tablo adı 
kullanıbilir*/
exec sp_spaceused CUSTOMERS
-- goruldugu gibi reserved (tablonun boyutu) 248088 KB kadarmıs bunu MB cevirelim
select 248088 / 1024.0
/*yaklasık olarak 242 MB yapmaktadır. Yani tablo boyutu 242 MB. Sorgu sonucu 
dosya okuma da 243 MB. Bunun anlamı sql bu sorguyu bulabilmek icin butun tabloyu
aramıs(okumus) demektir.Diger bir tabirle 2.5 milyon satırı tek tek okumus demektir.
Peki bizim amacımız neydi? bizim amacimiz bu okuma sayısını azalmaktı. Peki nasıl 
azaltırız simdi de ona bakalım.
Bu durumu duzeltmek icin sql bize oneriler de bulunabiliyor. Bu onerileri gormek
 icin execution plan yaparak gorebiliriz lakın like yerine = kullanmamız gerekiyor.*/

select * from CUSTOMERS where NAMESURNAME = 'Mehmetcan ESER'
/*bu sorgu da execution plan yaptıgımızda yesil yazi icinde sql bize bir oneride 
bulunuyor. Yesil yazıda missing index(impact 99.8701): create nonclustured index 
yaziyor yani eksik bir index var diyor eger sen index olustursan ben 99.8701 kat 
daha hizli calısırım dıyor.Hatta yesil yaziya sag tık yapıp missing index details
dersek scripti bile gorebiliriz lakın biz simdi elimizle yazalım.*/

create nonclustered index IX_NameSurname on Customers
(
	NAMESURNAME asc
)
/*evet ilk indeximizi olusturduk bunun icin nonclustured index yazıp index
adı sonra on tablo adı seklınde devam ettik. Parantezler icine ise hangi sutunların
indexini olusturacagimizi soyledik */

-- simdi sorgumuzun perfomansina bir daha bakalım

set statistics io on
select * from CUSTOMERS where NAMESURNAME = 'Mehmetcan ESER'
--Evet fark cok acık bir sekilde ortada simdi okudugu page sayısı 6
select 6 * 8 / 1024.0
/*yaklasık olarak 0.04 MB yapmaktadir.Execution plan yaptıgımızda ise 
index seek (yani bizim olusturdugumuz indexi kullanarak binary seaarch yapmıs) ve
key lookup (nonclustered uzerinde arama yapıp index uzerinde olmayan alanları 
primary key uzerinden getirmektir) kullanarak bu sorguyu getirdım diyor. 
Bunların neler oldugunu en yukarıda acıkladım*/

select NAMESURNAME from CUSTOMERS where NAMESURNAME = 'Mehmetcan ESER'
/*bu sorguda ise sadece namesurname alanını istedik ve execution plan yaptıgımızda
ise sadece index seek kullanmıs.Bunun nedeni zaten indeximiz namesurname gore yanı
baska bir tabloya gitmesine gerek yok(yani key lookup'a gerek yok)*/

-- bazen bu key lookup olmadan calıstırmamız gerekebilir. Boylece sorgularimiz
-- daha da hızlı calısır. Bunun icin included column yapısını kullaniriz. Bunun 
-- kullanarak buldumuz degeri hemen dondeririz baska bir tabloya gitmeye gerek kalmaz.

-- simdi de included column olusturalim.

create index IX_Included_Column on customers
(
	NAMESURNAME asc
)
include
(
	ID, GENDER, BIRTHDATE, CITY, TOWN, TELNR, NAME_, SURNAME, TCNO
)
/*index olusturmadan farkı include diyip diger sutunları da eklemek. Burada dikkat 
edilmesi gereken olay NAMESURNAME sutunun tekrardan include bolumune dahil etmememiz.*/

-- sorgu performansimiza bakalim.
set statistics io on
select * from CUSTOMERS where NAMESURNAME = 'Mehmetcan ESER'
/*Goruldugu gibi 3 tane page okumus yukarıda 6 tane page okumustu.
execution plan yaptıgımız da ise IX_included_column indexini kullandıgını goruyoruz.*/

-- peki included column index kullanmanın maliyetine bakalım biraz da.
-- Bunu anlamak icin indexlerimin hepsini silip tekrardan olusturacagız.

drop index customers.IX_Included_Column, customers.IX_NameSurname

-- sımdı tablomuzun boyutuna bakalım
exec sp_spaceused customers
/*
reserved: 248088 KB
data: 247504 KB
index_size: 432 KB
*/

-- simdi included column icermeyen indexi tekrardan olusturalım.
create index IX_NameSurname on customers
(
	NAMESURNAME asc
)

-- tablo boyutuna tekrar bakalım
exec sp_spaceused customers
/*
reserved: 317296 KB
data: 247504 KB
index_size: 69560 KB
*/

-- sımdide included column olan indexi tekrar olusturalım

create index IX_Included_Column on customers
(
	NAMESURNAME asc
)
include 
(
	ID, GENDER, BIRTHDATE, CITY, TOWN, TELNR, NAME_, SURNAME, TCNO	
)

-- tablo boyutuna bir daha bakalım
exec sp_spaceused Customers
/*
reserved: 558408 KB
data: 247504 KB
index_size: 310584 KB

gorulugu gibi datamizin boyutu sabit kalsada tablomuzun boyutu oldukca arttı 
*/

-- simdi sorgumuzu biraz degistirelim ve birden fazla indexler uzerinde calısmaya bakalım

set statistics io on
select * from CUSTOMERS where TELNR = '03468722468'
/*bu sefer telefon numarası uzerinden bir arama yaptık ve yine sql 30636 tane page 
okumus. Yine oldukca kotu bir performans. Execution plan baktigimizda ise 
included_column indexini kullanidigini goruyoruz. Bu index bu sorgu icin uygun olmadıgı
icin bu kadar kotu bir performans sergiledi. Lakin sql yine bize bir oneride bulunuyor.
telefon numaralarına gore index olstur diyor bize. Peki biz de olusturalım.*/

create index IX_Telnr on customers
(
	TELNR asc
)

set statistics io on
select * from CUSTOMERS where TELNR = '03468722468'
/*Evet okudugu page sayısı yine 6 oldu execution plana baktıgımız da ise telnr indexi 
ile key lookup yatıgını goruyoruz. Eger bu indexi included column seklınde yapsaydık
key lookup olmayacaktı.*/

set statistics io on
select * from CUSTOMERS where NAMESURNAME = 'Mehmetcan ESER' or TELNR= '02862391360'
/*boyle bir sorgu da 12 tane page okurken execution plan'da ise hem telnr hem de 
included column indexlerini kullandıgını goruyoruz.*/

-- sımdide unique indexlere bakalım.

select * from CUSTOMERS where NAMESURNAME = 'Mehmetcan ESER'
/*bu sorguda bir tane kayıt donuyor lakın sistem bu sorgunun bir tane kayıt 
dondurup dondurmeyecegini bilmiyor. Yani bir tane Mehmetcan ESER bulduktan sonra baska 
bir tane daha Mehmetcan ESER var mı diye aramaya devam ediyor. Oysa biz sql'e bunun tekil
unique bir alan oldugunu soylemis olsak sql bir tane kayıt buduktan sonra tablonun geri
kalanına bakmaz (zaten max bir var demek unique) ve sorgumuz daha hızlı ve daha az 
performans harcar.Unique indexler daha cok tekil sutunlar icin kullanilir. ornegin 
tcno icin sonucta herkesin bir tane tc numarası var ve bu alan icin unique index 
olusturulabilir.

Unique index olusturmak oldukca basıttır. normal index olusturken extra birde unique
yazarız.*/

create unique index IX_Tcno on customers 
(
	TCNO asc
)

set statistics io on
select * from CUSTOMERS where TCNO = '19354821567'
-- 6 tane page okumus
