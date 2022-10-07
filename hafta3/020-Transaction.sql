/*
Transaction Nedir ?

Transaction konusuna geçmeden önce veritabanında ACID kavramından 
bahsetmede fayda olacağını düşünüyorum. ACID kavramı, elektrik kesintisi,
sistem çökmesi gibi durumlarda geçerliliği garanti etmeye yarayan veritabanı
özelliklerinin bir dizi özelliğidir. ACID özelliklerini karşılayan veritabanı
işlemler dizisi, transaction olarak adlandırılır. Bir transaction özellikleri
aşağıda verilmektedir.

* Atomic: Veritabanında gerçekleştirilen tüm işlemlerin 
(insert, update, delete gibi) başarıyla gerçekleştirilmesini
(commit veya roll back edilmesini) garanti etmektedir.

* Consistent: Veritabanı tutarlılığını garanti almaktadır.
Bir transaction’da commit veya roll back işlemi gerçekleştiğinde 
veritabanı tutarlığını korumak önemlidir. Bu nedenle transaction 
işlemleri başarılıysa tüm değişiklikler veri tabanına uygulanır.
Eğer transaction ortasında hata gerçekleşirse, tüm değişiklikler
otomatik olarak geri alınır.

* Isolation: Her transaction işlemi bireyseldir. Transaction tamamlanıncaya
kadar, bir transaction diğer transaction’ların sonucuna erişemez. 
Bir transaction oturumu başladığında veriyi değiştirecek Insert, 
Update gibi ifadeler, sadece geçerli oturumda görünür.

* Durable: Bir transaction başarı ile tamamlandığında 
(commit gerçekleştiğinde), elektrik kesintisi veya program çökmesi 
durumunda değişiklikler veritabanında kalıcı olmalıdır.

Transactions birçok işletmede ve özellikle veri bütünlüğü anlamında
önemli rol oynamaktadır. Uygulamalarda başarı veya hatayı garanti 
eden operasyonlar listesi olarak tanımlayabiliriz. SQL kodumuzda herhangi
bir hata meydana geldiğinde işlemleri geriye alarak güvenli bir duruma
getirmeyi sağlar. Günlük olarak kullandığımız ATM’de para çekme esnasında
ister yazılımsal isterse donanımsal bir hata oluştuğunda paramızın
hesabımızdan çekilmediğini görürüz. İşte bu gibi durumlarda Transaction
yapısı devreye girerek paramızın hesabımıza geri dönmesini sağlar. 
Veritabanında gerçekleşecek olan işlemleri toplu olarak değerlendirip,
herhangi bir işlemde hata olması durumunda, tüm süreci geri alıp başlangıç
durumuna getirir. Böylece kritik işlemlerde veri bütünlüğünü garanti altına
almış oluruz.

* Bir transaction ilk olarak çalıştırılabilir bir SQL ifadesiyle başlar, 
COMMIT veya ROLLBACK işlemlerinden biri gerçekleşince tamamlanır.

* Bir transaction başladığında, işlem yapılacak tablolar başka sorgular 
içinde kullanılmaması için ilgili transaction bitene MsSQL tarafından 
otomatik olarak kilitlenir.

* Transaction süresince işlem başarılı bir şekilde gerçekleşirse COMMIT 
ile veritabanında kalıcı bir şekilde kaydedilir.

* Transaction süresince herhangi bir nedenden dolayı işlem başarısız 
olursa ROLLBACK ile tüm süreç geri alınır.

Ne zaman Kullanılır
* Kritik işlelerde verinin güvenli bir şekilde veritabanına kaydedilmesi veya
hata ile karşılaşıldığında sürecin geriye dönmesini istediğimiz durumlarda
kullanılır. Örneğin ATM’den para çekerken arıza oluşması durumunda paramızın 
hesabımızdan çekilmemesini sağlamak.

* Hem ilgili birden çok ilgili işlem için hem de veritabanını aynı anda 
güncelleyen birden çok kullanıcı için veri bütünlüğünü korumak için kullanılır.
Veritabanı işlemlerinin atomic olmasını sağlar.

* Bir tablo üzerinde değişiklik yapmak istediğimizde ve diğer tablolarda da
tutarlılığı olmasını istediğimizde transaction yapısı kullanılır. 
Customer (Müşteri) ve Order (Sipariş) tabloları üzerinden örnek verecek
olursak, Order tablosu Customer tablosuna bağlıdır. Bu durumda, müşteri
silindiğinde onunla igili siparişlerinde silinmesi gerekmektedir. 
Eğer silinmezse müşterisiz sipariş şeklinde tutarsız veri kaydı oluşur.
Bu gibi durumda transaction yapısı ile veri bütünlüğü sağlanır.

COMMIT (Onaylama): Veritabanında Insert, Update, Delete gibi işlemler başarılı
bir şekilde gerçekleştiğinde COMMIT komutu ile değişiklikler kaydedilir. 
Böylece Durable kavramına göre veritabanına kalıcı olarak kaydedilir.

ROLLBACK (Geri Dönüş): Veritabanında Insert, Update, Delete gibi işlemlerden
birinin başarısız olması durumunda ROLLBACK komutu ile tüm sürecin geri 
alınması sağlanır.

OLTP (On Line Transaction Processing) Nedir ?
Transaction yapısını destekleyen veritabanlaridir.

Bir kuruluşun günlük işlemlerinin yönetildiği çoğunlukla ilişkisel veri 
tabanı üzerine kurulu sistemlerdir. Veri tabanı üzerinde okuma, ekleme, 
güncelleme ve silme(DML) gibi sorgularla gerçek zamanlı olarak kısa da 
olsa çok sayıda çevrimiçi işlemi gerçekleştirmektir. OLTP sistemlerinin 
temel amacı veriyi işlemektir, analiz etmek değildir.

Verimlilik, saniyedeki bir dizi işlemle belirlenir. OLTP sistemlerinde aynı 
anda çok sayıda başarılı işlem gerçekleştirebilmek için, bu işlemlerin atomik,
tutarlı, yalıtılmış ve dayanıklı (ACID) olması gerekir. Günlük hayatta
kullanılan veri depolama sistemlerinin çoğu OLTP sistemleridir. 
Örnek olarak ATM, çevrimiçi bankacılık verilebilir.

OLAP (On Line Analytical Processing)
Karar destek sistemleri ve raporlama için veri analizi sağlayan sitemlerdir.
Bu sistemlerdeki asıl amaç ise veriyi işlemek değil, analiz etmektir. 
OLTP sistemlerine göre analiz ve raporlamaları çok daha performanslı 
yapmasından dolayı tercih edilmektedir. İşlemleri bu kadar hızlı 
yapabilmesinin sebebi ise raporlama ve analiz için gerekli olan 
hesaplamaların daha önceden yapılmış olmasıdır. Bütün veri ambarı 
sistemleri OLAP sistemidir. Örneğin Netflix film öneri sistemi veya
Amazon ürün öneri sistemi OLAP sistemi üzerinde çalışmaktadır.

Aralarındaki Fark
* OLTP günlük işlemleri gerçekleştirmek için kullanılırken OLAP, 
sorunları çözmek, karar vermeyi desteklemek, görevleri otomatikleştirmek 
için kullanılır.

* OLTP yapılandırılmış veriler ile çalışırken OLAP yarı yapılandırılmış
veya yapılandırılmamış verilerle de çalışabilmektedir.

* OLTP sistemlerinde bir işlem süresi milisaniye seviyelerinde olması
gerekirken OLAP sistemlerinde bu kadar hız beklenmez. Saatler sürebilir.

* OLTP sistemleri verilerin ana kaynağı iken OLAP sistemlerindeki veriler
OLTP sistemleri de dâhil çeşitli kaynaklardan toplanan verilerdir.

* OLTP sistemlerinde yedekleme çok önemlidir. OLTP sistemlerinde periyodik
olarak yedekleme işlemi yapılırken OLAP sistemlerinde çoğunlukla yedekleme
yerine veri kaynaklarından verinin yeniden çekilmesi tercih edilir.

OLTP Yapisi

-------------          -------------
| master    |          | log       |
| data      |          | data      |
| file      |          | file      |
| .mdf      |          | .ldf      |
-------------          -------------

Master Data File
Master data file, veritabanının başlangıç ​​noktasıdır, ana veritabanı
dosyalarıdır. Veritabanındaki diğer dosyalara işaret eder. Bu nedenle,
her veritabanı bir master data file dosyasına sahiptir. Tablolar, 
stored prosedürler, viewler, tetikleyiciler , fonksiyonlar vb. veritabanı
nesnelerindeki tüm veriler master data file dosyalarında saklanır. 
Dosya uzantısı .mdf olarak geçer.

Log Data File
SQL Server veritabanlarındaki log(günlük) dosyaları tüm günlük bilgilerini 
tutar. Bu bilgiler daha sonra veritabanını kurtarmak için kullanılabilir.
Log dosyasının boyutu, veritabanında kurduğunuz log kaydı düzeyine göre 
belirlenir. Her veritabanı için en az bir günlük dosyası olmalıdır.
Ancak tek bir veritabanı için birden fazla log dosyasına da sahip olabilir.
Simple, full ve bulk-logged loglara kaydedilme seçenekleridir.
Performans anlamında .ldf dosyalarının ayrı bir diskte tutulması bizlere
avantaj sağlayacaktır. Çünkü driveda eş zamanlı olarak hem .mdf dosyasına
yazmak hem de  .ldf dosyalarına yazmak, istediğimiz verimi sağlayamayabilir.
Dosya uzantısı .ldf olarak geçer.

Örnegin veritabanimiza bir insert into islemi yaptıgımızda ilk önce veri .ldf
dosyasına yazılır. Daha sonra .mdf dosyasına gelir eger ki herhangi bir problem 
yok ise .mdf dosyasına commit edilir. Boylece gercek verinin icine yazılmıs olur
Eger ki bir problem yasanırsa rollback olayı gerceklesir ve .mdf dosyasına 
yazılmadan tekrardan .ldf dosyasına gider ve buradan da temizlenerek işlem  
gerceklesmeden sistem korunmus olunur.

simdi rollback - commit islemlerini veritabani ortaminda nasıl yapıldıgını 
gorelim.
örnegimiz para transferi gerceklestirme ornegi olsun 
can ali'ye 1000 tl para gondersin bakalim neler olacak.
*/

create database BANKA

use BANKA

-- musteriler icin bir tablo olusturalım
create table Customers
(
id int primary key identity(1,1),
name varchar(20)
)

-- musterilerin banka hesaplarının tutuldugu tablo olusturalım
-- burada bir musterinin birden fazla banka hesabi olabilir buna dikkat et
create table Accounts
(
id int primary key identity(1,1),
customer_id int foreign key references Customers(id),
hesap_no varchar(20),
account_name varchar(30)
)

-- bu musterilerin hesaplarındaki bakiyelerin tutuldugu bir tablo olusturalım
create table Balances
(
id int primary key identity(1,1),
customer_id int foreign key references Customers(id),
account_id int foreign key references Accounts(id),
balance float default 0
)

-- bir de hesap hareketlerinin tutuldugu bir tablo olusturalım
create table Transactions
(
id int primary key identity(1,1),
account_id int foreign key references Accounts(id),
transaction_type tinyint,
amount float,
date datetime,
eft_code1 varchar(10),
eft_code2 varchar(10)
)

-- bir kac tane ınsert yapalim

insert into Customers(name) 
values('Can'),('Ali'),('Veli'),('Ayşe')

insert into Accounts(customer_id, hesap_no, account_name)
values
(1, 'Hesap No 1','Can''ın Hesabı'),
(1, 'Hesap No 2', 'Can''ın Hesabı'),
(2, 'Hesap No 3', 'Ali''nin Hesabı'),
(2, 'Hesap No 4', 'Ali''nin Hesabı'),
(3, 'Hesap No 5', 'Veli''nin Hesabı')

insert into Balances(customer_id, account_id, balance)
values(1, 1, 1000),(2, 3, 0)

-- inner join ile kimin hesabında ne var goruyoruz simdi
select C.name, A.account_name, B.balance from Customers as C 
inner join Accounts as A on C.id = A.customer_id 
inner join Balances as B on B.account_id = A.id

-- 1. adım
-- para transfer islemini gerceklestirelim.
-- once can'ın hesabında hareket islemi yapılır.
insert into Transactions
(account_id, transaction_type, amount, date, eft_code1, eft_code2)
values(1, 2, 1000, '2022-06-30 14:05:43', '123456789', '')
-- transaction_type 2 yani para cıkısı

-- 2. adım
-- simdi ise can'in hesabından parayı azaltalım
update Balances set balance -= 1000 where account_id = 1

-- 3. adım
-- simdi ali'nin hesabının hareketini ekleyelim
insert into Transactions
(account_id, transaction_type, amount, date, eft_code1, eft_code2)
values(3, 1, 1000, '2022-06-30 15:05:43', '123456789', '987654321')

-- 4. adım
-- ali'nin hesabını guncelleyelim
update Balances set balance += 1000 where account_id = 3

-- Bu 4 adım ile can'ın hesabından ali'nin hesabına para transferi gerceklesti.
select * from Transactions
select C.name, A.account_name, B.balance from Customers as C 
inner join Accounts as A on C.id = A.customer_id 
inner join Balances as B on B.account_id = A.id

-- problemsiz calısan bir sistemde sıkıntı yok peki bu adımlardan birinde bir
-- sıkıntı olsaydı ne olacaktı o zaman sıkıntı olurdu 
-- biz bu 4 adımı ayrı birer islemler gibiymis gibi davrandık oysa bunları 
-- bir butun sekilde gormeliyiz. cunku bu adımların herhangi bir asamasinda 
-- bir sıkıntı yasanirsa sistem eski haline donsun diye.
-- bunun icin begin tran veya begin transaction ile baslarız

begin transaction
-- 1. adım
insert into Transactions
(account_id, transaction_type, amount, date, eft_code1, eft_code2)
values(1, 2, 1000, '2022-06-30 14:05:43', '123456789', '')
-- 2. adım
update Balances set balance -= 1000 where account_id = 1
-- 3. adım
insert into Transactions
(account_id, transaction_type, amount, date, eft_code1, eft_code2)
values(3, 1, 1000, '2022-06-30 15:05:43', '123456789', '987654321')
-- 4. adım
update Balances set balance += 1000 where account_id = 3

-- bu halde birakırsak transactionu bitirmemıs oluruz yanı yaptıgımız islemler
-- .ldf dosyasında kalır bunu .mdf dosyasına kaydetmek icin commit etmemiz gerekir
-- sistemde hata olursa rollback ilede eski haline doneriz
-- @@ ile baslayan ifadeler sql'de global degiskenler anlamina gelir.
-- simdi kontrolleri ekleyelim
begin transaction
-- 1. adım
insert into Transactions
(account_id, transaction_type, amount, date, eft_code1, eft_code2)
values(1, 2, 1000, '2022-06-30 14:05:43', '123456789', '')
if @@ERROR > 0 --0'dan buyuk ise hata vardir demek
begin
	rollback tran
	return
end
-- 2. adım 
update Balances set balance -= 1000 where account_id = 1
if @@ERROR > 0
begin 
	rollback tran
	return
end
-- 3. adım
insert into Transactions
(account_id, transaction_type, amount, date, eft_code1, eft_code2)
values(3, 1, 1000, '2022-06-30 15:05:43', '123456789', '987654321')
if @@ERROR > 0 
begin
	rollback tran
	return
end
-- 4. adım
update Balances set balance += 1000 where account_id = 3
if @@ERROR > 0
begin 
	rollback tran
	return
end

commit tran -- hata yok ise commit et ve verileri .mdf dosyasına kaydet

-- aslında sql de her islem bir transaction islemidir biz sadece basına
-- begin transaction yazmayız
-- asagıdaki bir islem bunun da basına begin tran commit rollback kullanabiliriz 
begin tran
select 10 / ROUND(RAND() * 2, 0)
if @@ERROR > 0
begin
	rollback
	print '0''a bölüm tanımsızdır'
	return
end
commit tran

-- triggerlar da transactionun bir parcasıdır. yani bir trigger ile islem 
-- yapıyorsak ve asıl tabloda hata oldu ise rollback yaptıgımızda triggerdaki
-- islemlerde geri alınmıs olunur

-- Tabloları kilitleme (LOCK)
/* 
biz transaction islemlerimizde eger transactionı bitirmez isek yani
begin tran diyip commit yazmaz isek transaction bitmemis olur yanı islem devam
ediyor gorunur.
Bu durum sakıncalı bir durumdur. Cunku bizim sorgumuzun isi bitmeden baska bir
kullanıcı aynı tablo uzerınde islem yaparsa onun sorguları hatalı veya calısmaz
olur. Bu durumu onlemek yani diger kullanıcıların bizim yaptıgımız transactiondan
etkilenmemesi icin nolock kullanilir. 
*/

select * from Balances with(nolock) 
-- nolock ile diger kullanicilar bizim islemlerimizden etkilenmez

begin transaction
-- 1. adım
insert into Transactions
(account_id, transaction_type, amount, date, eft_code1, eft_code2)
values(1, 2, 1000, '2022-06-30 14:05:43', '123456789', '')
-- 2. adım
update Balances set balance -= 1000 where account_id = 1
-- 3. adım
insert into Transactions
(account_id, transaction_type, amount, date, eft_code1, eft_code2)
values(3, 1, 1000, '2022-06-30 15:05:43', '123456789', '987654321')
-- 4. adım
update Balances set balance += 1000 where account_id = 3

dbcc opentran
-- bu komut acık yani kapanmamıs transactionları gosterir yukarıdaki 
-- komut kapanmamıs transactiondur opentran calıstırdıgımızda spid kısmında
-- hangi kullanıcıda acık kaldıgını gorebiliriz