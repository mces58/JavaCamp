-- Trigger'lar
/*
Kelime anlamı tetikleyici demektir. Yani bir olay oldugunda baska bir olayın
otomatik olarak tetiklenme mekanızması yada otomatik olarak calısmasıdır.
Burada islem olarak kastedtigimiz ise data manipulasyonudur. 
Data manipulasyonları ise insert, update, delete islemleridir.
Trigger'lar insert, update veya delete islemlerinden sonra otomatik olarak
calısmasını istedigimiz islemleri calıstırırlar.

Trigger'lar icinde sanal olarak olusan inserted ve deleted tabloları
vardır. Gercekte yokturlar trigger'lar ile gelirler.Bu tablolar iclerinde bazi
veriler tutarlar.
inserted tablosu: yeni eklenen kayıdın ya da update edildiginde degisen
kayıdın yeni degerini tutar.
deleted tablosu: silinen kayıdı ya da degistirilen kaydın eski degerini tutar.

Trigger'lar genelde otomatik toplam hesaplama,son degeri alma ya da loglama 
amaclı kullanılır.

Tetikleyici (Trigger) yapısı, ilişkisel veri tabanı yönetim sistemlerinde,
bir tabloda belirli olaylar meydana geldiğinde veya gelmeden önce otomatik 
olarak çalışan özel bir store procedure türüdür. Bir tabloda ekleme,
güncelleme ve silme işlemlerinden biri gerçekleştiğinde veya gerçekleşmeden 
önce, aynı tabloda veya başka bir tabloda belirli işlemlerin yapılmasını
istediğimizde, trigger yapısını kullanırız. Örnek verecek olursak, satış
tablosunda satış işlemi gerçekleştiğinde ürünün stok miktarının eksiltilmesi,
banka hesabında işlem gerçekleştikten sonra otomatik olarak email gönderilmesi
gibi örnekler verilebilir.

* Tetikleyiciler veritabanı yöneticisi (Db admin) tarafından INSERT, UPDATE 
ve DELETE işlemlerinden önce veya sonra çalıştırılmak üzere tanımlanır.

* Tetikleyiciler kullanıcı tarafından manuel olarak çalıştırılamaz.

* Bir tetikleyici içinde, bir transaction commit ve rollback edilemez.

* Bir tetikleyici içinde, bir transaction commit ve rollback edilemez.

* Bir tetikleyici olayı meydana geldiğinde, trigger fonksiyonu uygun bir 
zamanda veriyi işlemek üzere çağrılır.

* DML (AFTER ve INSTEAD OF), DDL ve Logon tetikleyiciler olmak üzere üç 
yapı bulunmaktadır.

Nerelerde Kullanılır?
* Veri bütünlüğünu sağlamak için kullanılır. Veriler üzerinde bir işlem
yapıldığında, iş kurallarına uygun gerçekleşip gerçekleşmediği kontrol
edilerek, hatalı girişlerin yapılması önlenir.

* Referans bütünlüğünü sağlamak için kullanılır. Bir kullanıcı silindiğinde
onunla ilgili satış tablosundaki siparişleri silmek istediğimizde tanımlanır.

* ablolarda veya veritabanında mevcut olmayan ek bilgiyi türetmek için
kullanılır. Örneğin sipariş tablosunda miktar sütununda bir güncelleme
meydana geldiğinde toplam_fiyat sütununa karşılık gelen işlemi hesaplayabiliriz.

Tetikleyici (Trigger) Türleri
DML (Data Manipulation Language) Triggers:
INSERT, UPDATE ve DELETE gibi veri okuma ve işleme için kullanılan DML
ifadeleridir. DML tetikleyicileri, INSERT, UPDATE ve DELETE olayları 
kullanılarak veriler her değiştirildiğinde tetiklenir. DML tetikleyicileri 
iki tip olarak sınıflandırılır.

AFTER tetikleyicileri: Bir tabloda INSERT, UPDATE, DELETE işlemleri
yapıldıktan belli işlemlerin yapılması için kullanılmaktadır.

INSTEAD OF tetikleyicileri: Bir tablo veya view yapısında INSERT, UPDATE
veya DELETE işlemlerini atlayıp, bunun yerine tetikleyici içinde tanımlanan
diğer ifadeleri yerine getirirmektedir.

DDL (Data Definition Language) Triggers:
CREATE, ALTER, DROP gibi veritabanı ve tablo ile ilgili işlemler DDL 
ifadeleridir. DDL tetikleyicisinin amacı, bir DDL nesnesi oluşturmaya
(create), değiştirmeye (alter) veya düşürmeye (drop) çalışan kullanıcılara
kısıtlama getirilmesini sağlamaktadır. CREATE, ALTER ve DROP ifadeleri 
kullanıldığında devreye giren tetikleyici türüdür.

Logon Triggers:
Logon tetikleyicisi, SQL Server sunucusuna bağlanan bir kullanıcılara
belirli kısıtlamalar uygulayabiliriz. Logon tetikleyicileri, SQL
Serverde güvenlik ve kontrol amaçlı kullanılmaktadır. Örneğin kullanıcı
veritabanına dışarıdan bilinmeyen bir bilgisayarın bağlanmasını engelleyip,
sadece şirket bilgisayarından bağlanılmasına izin verilebilir.

Bu konu icin yeni bir database uzerinde calısalım.
*/

create database TRIGGERS
use TRIGGERS

-- urunler icin bir tablo olusturalım.
create table PRODUCTS
(
ID int primary key identity(1,1),
PRODUCTCODE char(6) unique not null,
PRODUCTCATEGORY1 varchar(50) not null,
PRODUCTCATEGORY2 varchar(50) not null,
PRODUCTCATEGORY3 varchar(50) not null,
PRODUCTNAME varchar(50) not null,
PRODUCTDESCRIPTION varchar(100) 
)
-- bir kac kayıt girelim
insert into PRODUCTS
(PRODUCTCODE, 
PRODUCTCATEGORY1, 
PRODUCTCATEGORY2,
PRODUCTCATEGORY3,
PRODUCTNAME, 
PRODUCTDESCRIPTION)
values
('TRM161', 'KADIN', 'GİYİM', 'ELBİSE', 'TRENDYOLMİLLA', 'Kırmızı Yaka Detaylı Elbise'),
('KRA839', 'ERKEK', 'AYAKKABI', 'KRAMPON', 'HIRALIFE', 'Çim Saha Kırmızı Siyah Halısaha Krampon Erkek Futbol Spor Ayakkabı'),
('CEL105', 'KOZMETİK', 'CİLT BAKIMI', 'YÜZ TEMİZLEME', 'CELIMAX', 'Jojoba Yağı İçeren Siyah Nokta ve Makyaj Temizleme Yağı'),
('KRA317', 'SAAT & AKSESUAR', 'ERKEK', 'KRAVAT', 'DEFACTO', 'Desenli Kravat'),
('APP799', 'ELEKTRONİK', 'TELEFON', 'ŞARJ CİHAZLARI', 'APPLE', 'Iphone Orjinal Şarj Aleti Kablosu 1m Lightning Usb Kablosu'),
('BYC594', 'SPOR & OUTDOOR', 'BİSİKLET', 'DAĞ BİSİKLETİ', 'SALCANO HECTOR 24 V', 'Fren Çift Amortisör 24 Jant Dağ Bisikleti Yeni Model'),
('CAN953', 'KADIN', 'AKSESUAR & ÇANTA', 'ÇANTA', 'ATMOSPHEREBASIC', 'Unisex Önü Cepli Uzun Askılı For Happines Baskılı Seyahat Fitness Ve Spor Çantası'),
('TUL105', 'ÇOÇUK', 'BEBEK', 'TULUM & SALOPET', 'BEBELOJI BABY', 'Kız Bebek Bandanalı Çiçekli Meyveli Elbise Salopet BebelojiBaby'),
('FAR750', 'KOZMETİK', 'MAKYAJ', 'GÖZ MAKYAJI', 'FARMASI', 'Zen Maskara 8 ml'),
('BOX247', 'ERKEK', 'İÇ GİYİM', 'BOXER', 'BLACK SWALLOW', 'Erkek 10’lu Paket Likralı Pamuklu Boxer'),
('KOL909', 'SAAT & AKSESUAR', 'TAKI & MÜCEVHER', 'KOLYE', 'EVERGLOW JEWELRY', 'Su Yolu Taşlı Choker Tasma Kolye'),
('PAN318', 'ERKEK', 'GİYİM', 'PANTOLON', 'WAMOSS', 'Erkek Gri Jogger Pantolon'),
('SAN664', 'KOZMETİK', 'SAÇ BAKIMI', 'ŞAMPUAN', 'ELIDOR', 'Saç Bakım Şampuanı Güçlü ve Parlak 500 ML x3 + Saç Bakım Kremi 200 ML'),
('MNT556', 'ÇOÇUK', 'KIZ ÇOCUK', 'MONT', 'B&T', 'Kız Çocuk Siyah Peluşlu Kaban Mont'),
('BIL493', 'ELEKTRONİK', 'BİLGİSAYAR & TABLET', 'LAPTOP', 'MONSTER ABRA A5 V17.1.3', 'Intel Core I5 11400h 16gb 500gb Ssd Rtx3050 Freedos 15.6'),
('TYT241', 'SPOR & OUTDOOR', 'SPOR GİYİM', 'SPOR TAYT', 'TRENDYOLMİLLA', 'Lacivert Seamless Fitilli Spor Tayt'),
('ETK393', 'KADIN', 'GİYİM', 'ETEK', 'ZECHKKA', 'Bej Volanlı Mini Şortlu Etek'),
('PAR813', 'KOZMETİK', 'PARFÜM & DEODARANT', 'PARFÜM', 'BARGELLO', 'Kadın Parfüm 324 Oriental 50 ml'),
('GOM475', 'ERKEK', 'GİYİM', 'GÖMLEK', 'AVVA', 'Erkek Siyah Oxford Düğmeli Yaka Regular Fit Gömlek'),
('TAY074', 'AYAKKABI & ÇANTA', 'KADIN AYAKKABI', 'TOPUKLU AYAKKABI', 'EPAAVM', 'Dolgu Topuk Örgülü Vizon Ayakkabı'),
('SWE737', 'ÇOCUK', 'ERKEK ÇOCUK', 'SWEATSHIRT', 'DEFACTO', 'Erkek Çocuk Kapüşonlu Kaplan Baskılı 2’li Sweatshirt'),
('GEC147', 'KADIN', 'İÇ GİYİM', 'GECELİK', 'DEM MERYS', 'Beyaz Dantelli Ipek Saten Gecelik'),
('GGO849', 'SAAT & AKSESUAR', 'ERKEK', 'GÜNEŞ GÖZLÜĞÜ', 'HERMANAMODA', 'Güneş Gözlüğü'),
('BEZ910', 'ÇOCUK', 'BEBEK', 'BEBEK BEZİ', 'SLEEPY', 'Extra Günlük Aktivite Bezi 5 Numara Junior 160 Adet extr160'),
('XIA238', 'ELEKTRONİK', 'GİYİLEBİLR TEKNOLOJİ', 'AKILLI SAAT', 'XIAOMI', 'Mi Band 5 Akıllı Bileklik - Siyah'),
('TAK583', 'ERKEK', 'GİYİM', 'TAKIM ELBİSE', 'D’S DAMAT', 'Siyah Renk Erkek Takım Elbise Slim Fit'),
('FIT411', 'SPOR & OUTDOOR', 'FITNESS KONDİSYON', 'FITNESS ALETLERİ', 'DELTA', 'Uzunluğu Ayarlanabilir Deluxe Atlama Ipi'),
('JBL712', 'ELEKTRONİK', 'TV & GÖRÜNTÜ & SES', 'KULAKLIK', 'JBL', 'Tune 510bt Multi Connect Wireless Kulaklık'),
('PAN146', 'KADIN', 'GİYİM', 'PANTOLON', 'KOTON', 'Ekoseli Pantolon Ispanyol Paça Cepli Pamuklu'),
('TSH969', 'ERKEK', 'GİYİM', 'T-SHIRT', 'MAVI', 'Pro Logo Baskılı Beyaz Tişört Oversize'),
('MER928', 'ÇOCUK', 'OYUNCAK', 'OYUNCAK ARABA', 'MERCEDES', 'Benz E Kasa Amg Die Cast Metal Orjinal Lisanslı Araba Kırmızı'),
('TRA436', 'KOZMETİK', 'EPİLASYON & TIRAŞ', 'TIRAŞ KÖPÜĞÜ', 'GILLETTE', 'Satin Care Tıraş Jeli Hassas 200 ml'),
('BLZ838', 'KADIN', 'GİYİM', 'BLUZ', 'LC WAIKIKI', 'Kayık Yaka Düz Kadın Bluz'),
('SAP609', 'SAAT & AKSESUAR', 'KADIN', 'ŞAPKA', 'NIKE', 'Beyaz Unısex H86 Capmetal Swoosh Şapka'),
('FOR160', 'ERKEK', 'GİYİM', 'FORMA', 'ADIDAS', 'Juventus 2020-2021 Iç Saha Erkek Forma'),
('XBX746', 'ELEKTRONİK', 'OYUNCULARA ÖZEL', 'XBOX', 'MICROSOFT', 'Xbox Series S 512 GB Oyun Konsolu - Beyaz'),
('TOP348', 'SPOR & OUTDOOR', 'TOP', 'FUTBOL TOPU', 'FENERBAHÇE', 'Orjinal Lisanslı Futbol Topu No 5 Taraftar Topu '),
('TOP547', 'SPOR & OUTDOOR', 'TOP', 'BASKETBOL TOPU', 'NIKE', 'Jordan Playground 8p Basketbol Topu'),
('TER892', 'AYAKKABI & ÇANTA', 'KADIN', 'TERLİK', 'GEZER', 'Ortopedik Ayarlanabilir Cırt Detaylı Kadın Terlik'),
('PRE065', 'ERKEK', 'KİŞİSEL BAKIM', 'CİNSEL SAĞLIK', 'OKEY', 'Rötar Geciktiricili 45’li Prezervatif Fırsat Paketi')

-- birde urunlerin giris cıkıs hareketlerini takıp eden bir tablo olusturalım.
create table PRODUCTTRANSACTIONS
(
ID int primary key identity(1,1),
PRODUCTID int foreign key references PRODUCTS(ID),
TRANSACTIONDATE datetime not null,
AMOUNT int not null,
IOTYPE smallint not null
)

-- simdi bu PRODUCTTRANSACTIONS tablosuna rastgele veri giren bir 
-- procedure yazalım

create proc sp_Insert_Transaction
as 
begin
	declare 
	@PRODUCTID as int,
	@TRANSACTIONDATE as datetime,
	@AMOUNT as int,
	@IOTYPE as smallint,
	@i as int = 0

	while @i < 1000000
	begin 
	set @PRODUCTID = ROUND(RAND() * 39, 0) + 1
	-- rastgele id uretme 1 ile 4 arasında 

	set @TRANSACTIONDATE = DATEADD(SECOND, -ROUND(rand() * 31536000, 0), GETDATE())
	-- rastgele tarıh uretiyoruz lakin rastgele 0 ile 31536000 arasında bir sayı
	-- uretip onu bugunun tarıhınden saniye olarak cıkartıyoruz.
	-- bir yıl 31536000 saniye ettigi icin

	set @AMOUNT = ROUND(rand() * 9, 0) + 1
	-- 1 ile 10 arasında sayı uretir.

	set @IOTYPE = ROUND(rand() * 1, 0)
	-- 0 ile 1 arasında bir deger uretir.1 girisi 0 cıkısı temsıl eder


	insert into PRODUCTTRANSACTIONS(PRODUCTID, TRANSACTIONDATE, AMOUNT, IOTYPE)
	values(@PRODUCTID, @TRANSACTIONDATE, @AMOUNT, @IOTYPE)

	set @i += 1
	end

end

exec sp_Insert_Transaction

-- simdi hangi ürünlerin giris cıkıs hareketlerine bakalım
select *,
(select SUM(AMOUNT) from PRODUCTTRANSACTIONS where PRODUCTID = PRO.ID and IOTYPE = 0) as CIKIS,
(select SUM(AMOUNT) from PRODUCTTRANSACTIONS where PRODUCTID = PRO.ID and IOTYPE = 1) as GIRIS,
(
(select SUM(AMOUNT) from PRODUCTTRANSACTIONS where PRODUCTID = PRO.ID and IOTYPE = 1) -
(select SUM(AMOUNT) from PRODUCTTRANSACTIONS where PRODUCTID = PRO.ID and IOTYPE = 0)
) as STOK
from PRODUCTS as PRO

-- peki bu sorgunun bana maliyeti ne oldu bir de ona bakalım

set statistics io,time on
select *,
(select SUM(AMOUNT) from PRODUCTTRANSACTIONS where PRODUCTID = PRO.ID and IOTYPE = 0) as CIKIS,
(select SUM(AMOUNT) from PRODUCTTRANSACTIONS where PRODUCTID = PRO.ID and IOTYPE = 1) as GIRIS,
(
(select SUM(AMOUNT) from PRODUCTTRANSACTIONS where PRODUCTID = PRO.ID and IOTYPE = 1) -
(select SUM(AMOUNT) from PRODUCTTRANSACTIONS where PRODUCTID = PRO.ID and IOTYPE = 0)
) as STOK
from PRODUCTS as PRO

-- 15588 tane page okumus oldukca fazla 
-- oysa stockların tutuldugu bir tablo olsaydı isler farklı olurdu.
-- simdi stockarın tutuldugu bir tablo yapalım.

create table STOCKS 
(
ID int primary key identity(1,1),
PRODUCTID int not null,
STOCK int not null
)

select ID,
(select SUM(AMOUNT) from PRODUCTTRANSACTIONS where PRODUCTID = PRO.ID and IOTYPE = 1) -
(select SUM(AMOUNT) from PRODUCTTRANSACTIONS where PRODUCTID = PRO.ID and IOTYPE = 0)
as STOK 
from PRODUCTS as PRO order by ID
-- bu sorgunun sonuclarını STOCK tablosuna atacagız.

-- simdi stokları yeniden getirelım ve kac page okunmus ona bakalım

set statistics io, time on
select * from STOCKS
-- goruldugu gibi 2 page okumus. 15588 page nere 2 page nere.

-- simdi PRODUCTTRANSACTIONS tablosunda bir degisiklik oldugunda biz bunu STOCK
-- tablosuna elle yazarak duzeltik bundan sonra bir trigger yazarak 
-- PRODUCTTRANSACTIONS tablosunda bir degisiklik olursa bunu bizim yerimize
-- trigger yapacak. Yeniden sifirdan yapalım

truncate table PRODUCTTRANSACTIONS

update STOCKS set STOCK = 0 -- tum stokları sıfırladık
-- simdi PRODUCTTRANSACTIONS tablosuna bir insert oldugun da STOCKS tablosuna
-- da stok adedi girilecek 

create trigger TR_Transaction_Inserted on PRODUCTTRANSACTIONS
after insert
as 
begin
	declare 
	@PRODUCTID as int,
	@AMOUNT as int,
	@IOTYPE as smallint

	select @PRODUCTID = PRODUCTID, @AMOUNT = AMOUNT, @IOTYPE = IOTYPE 
	from inserted

	if @IOTYPE = 0 
	begin 
		update STOCKS set STOCK  = STOCK - @AMOUNT where PRODUCTID = @PRODUCTID
	end
	else 
	begin
		update STOCKS set STOCK  = STOCK + @AMOUNT where PRODUCTID = @PRODUCTID

	end
end
/*create trigger diye baslarız sonra bir isim veririz. Sonra bu trigger'in 
hangi tablo uzerinde calısacagını belirleriz. Sonra da ne zaman calısacagini
belirler icini doldurmaya baslarız. Stocks tablosunu guncelleyebilmemiz icin 
productid, amount, iotype bilgilerini bilmemiz lazım dolayısıyla bir degisken
olusturarak baslıyoruz ise. Bu degiskenler deger atamak icin INSERTED tablosunu
kullanıyoruz. Gercekte INSERTED tablosu diye bir sey yoktu lakın trigger icin
boyle bir tablo olusuyordu.Eklenen son kayıdın degerini okumaya yarıyordu.
Sonra iotype tipine gore stok sayisini belirliyoruz. 1 ise ekleme 0 ise cıkarma 
idi.
*/

insert into PRODUCTTRANSACTIONS([PRODUCTID], [TRANSACTIONDATE], [AMOUNT], [IOTYPE])
values(1,GETDATE(),5,1)
-- simdi 5 tane urun ekleyelim. Bu islem aynı zaman da STOCKS tablosunda da
--  etkılı olacak

select * from PRODUCTTRANSACTIONS
select * from STOCKS

-- simdi bunu 1 milyon urun icin yapalim
exec sp_Insert_Transaction

-- birde delete islemi sonrasında calısan trigger yazalım.
-- ve deleted tablosu kullanildi.

create trigger TR_Transaction_Delete on PRODUCTTRANSACTIONS after delete
as
begin 
	declare 
	@PRODUCTID as int,
	@AMOUNT as int,
	@IOTYPE as smallint

	select @PRODUCTID = PRODUCTID, @AMOUNT = AMOUNT, @IOTYPE = IOTYPE from deleted

	if @IOTYPE = 0
	begin 
		update STOCKS set STOCK = STOCK + @AMOUNT where PRODUCTID = @PRODUCTID
	end

	else
	begin
		update STOCKS set STOCK = STOCK - @AMOUNT where PRODUCTID = @PRODUCTID
	end
end

select * from PRODUCTTRANSACTIONS where PRODUCTID = 1
-- 8270 satır geldi ve ilk islem de 5 tane urun eklemıs
select * from STOCKS where PRODUCTID = 1 --  stoktada 73 urun var
-- simdi silme yapalım

delete from PRODUCTTRANSACTIONS where ID = 1

select * from PRODUCTTRANSACTIONS where PRODUCTID = 1
select * from STOCKS where PRODUCTID = 1 
-- PRODUCTID = 1 olan urun icin 68 urun var yanı otomatık olarak guncellemis

-- simdide update trigger yazalım

create trigger TR_Transaction_Update on PRODUCTTRANSACTIONS after update
as 
begin
	declare 
	@PRODUCTID as int,
	@IOTYPE as int,
	@OLDAMOUNT as int,
	@NEWAMOUNT as int,
	@AMOUNT as int

	select @PRODUCTID = PRODUCTID, @IOTYPE = IOTYPE, @OLDAMOUNT = AMOUNT
	from deleted

	select @NEWAMOUNT = AMOUNT from inserted

	set @AMOUNT = @OLDAMOUNT - @NEWAMOUNT

	if @IOTYPE = 0
	begin 
		update STOCKS set STOCK = STOCK - @AMOUNT where PRODUCTID = @PRODUCTID
	end

	else
	begin
		update STOCKS set STOCK = STOCK + @AMOUNT where PRODUCTID = @PRODUCTID
	end
end

-- bir guncelleme yapalım

select * from PRODUCTTRANSACTIONS where ID = 3
-- amount degeri 10 biz bunu 5 ile guncelleyelim
select * from STOCKS where PRODUCTID = 19
-- stok sayısı da -437 bakalım stocks tablosunda nasıl bir guncelleme olacak

update PRODUCTTRANSACTIONS set AMOUNT = 5 where ID = 3

select * from PRODUCTTRANSACTIONS where ID = 3
-- amount 5 oldu
select * from STOCKS where PRODUCTID = 19
-- stock -432 oldu
