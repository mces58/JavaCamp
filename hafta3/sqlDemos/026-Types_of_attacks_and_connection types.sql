-- Veritabanı sistemine saldiri nasıl yapılır?

/*
Temel anlama bir veritabanı sistemine giris yapmak icin
1 - fiziksel baglantı
2 - acık port
3 - kullanıcı adı
4 - sifre

eger saldıran kisi iceriden bir birisiyse yerel ag ile ilk iki 
asamayı ugrasmadan direk gecer. 3. asamada ise varsayılan
kullanicilar acık birakılır ve bu asamayıda gecmıs olur
geriye 4. asama kalır bu asamada sifre kırılmaya calısılır.
Sifre denemeleri yapma islemine(saldırısına) brute force
atakları denir.

Brute force saldırı yontemlerınde sadece biriydi.
Bir diger saldırı yontemi ise sql injection.
sql injection saldıriları ile sıfreye ihtiyac duymadan 
sisteme girme işlemidir.
Bu yontemde zararlı olmayan sql sorgu cumlelerinin icine
zararlı bir sql cumlesini enjekte etmektir(dahil etmektir.)
Boylece sistemde sql injection acıgı var ise saldırgan 
sisteme girerek istedigini yapabilir.

Saldırı yontemleri sadece bu ikisi degildir elbette
excel gibi genelde herkeste yuklu olan siradan uygulamalar 
ile veritabanı sistemine sızmalarda yapılabilir.

sql server'a bir saldırı gerceklestırebilmek icin her seyden once sql server'in 
baglantı islemlerinin ve sorgu islemlerinin nasıl gerceklestigini bilmek gerekir.

Veritabanı sistemleri nasıl calısır?



DB server  <-------------------------------------  client PC
							network
			fiziksel baglantı		acık port(1433)

			TCP/IP(windows)			names pipes(linux) bunlar protokollerdir.

TCP (Transmission Control Protocol), bilgisayarlar arasındaki iletişimin kayıpsız
olarak ve küçük paketler hâlinde gerçekleştirilmesine yarayan bir protokoldür. 
Aslında veriyi alırken ya da karşı tarafa gönderirken verinin bütünlüğünü 
sağlaması ve kimlik doğrulaması yapması TCP protokolünün en önemli özelliğidir.

Bu asamaları gectikten sonra server ile fiziksel baglantı gerceklesmis olur.

ikinci asama ise sql connection'dur. Bu asama da ise iki durum soz konusudur.
Birinci durum sql server authentication'dır. Yani kullanıcı adı ve sıfre'yi 
girerek baglanti saglamadır. diger durum ise windows authentication'dur. 
Yani kullanici adı ve sifre girmeden baglantı saglamadır. Benim baglanti seklım 
windows authentication'dır.Ben kullanici adı ve sıfre girmeden baglantı saglıyorum.

								network
				fiziksel baglantı		acık port(1433)
				TCP/IP(windows)			names pipes(linux) 
DB server  <-------------------------------------------------  client PC
						sql server connetion
			sql server authentication windows authentication
					

1- windows authentication nasıl gerceklesir?

						windows authentication
DB server  <-------------------------------------------------  client PC
		   ------------------------------------------------->
				baglandı					baglanamadı
						
Bilgisayara login oldugumuz zaman active directiory uzerinden user hash bilgisi
alınır. User hash bilgisi sql server'a gonderilir. Sql server ise bu bilgiyi 
active directory soruyor. Bilgi gecerli bir bilgisi ise baglanti saglaniyor, bilgi 
gecersiz ise baglanti saglanmiyor.

Active directory nedir
Active Directory bir dizin servisidir. Bu dizin servisi içerisinde; server, 
client, printer, user gibi bilgileri tutar. Bu bilgileri tuttuğu için aynı 
zamanda da bir veritabanıdır. Active Directory yönetimi merkezileştirir ve 
kolaylaştırır.

2 - sql server authentication nasıl gerceklesir?
Sql server'a kullanici adı ve sifresi gonderilir. Bilgiler dogru ise baglanti
saglanır. Yanlıs ise baglantı saglanmaz.

						sql server authentication
DB server  <-------------------------------------------------  client PC
		   ------------------------------------------------->
				baglandı					baglanamadı


*/