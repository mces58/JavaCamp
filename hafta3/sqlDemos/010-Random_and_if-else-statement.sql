create database TEST

use test
-- Random kişi olusturma ve sartlı ifadeleri kullanma

create table Isimler
(
id int identity(1,1) primary key,
isim varchar(30),
cinsiyet char(1) check(cinsiyet = 'E' or cinsiyet = 'K')
)

create table Soyisimler
(
id int identity(1,1) primary key,
soyisim varchar(30)
)

create table Kisiler
(
id int identity(1,1) primary key,
isim varchar(30),
soyisim varchar(30),
cinsiyet char(1) check(cinsiyet = 'E' or cinsiyet = 'K'),
dogum_tarihi date,
yas int,
yas_grubu varchar(30)
)

/*Bu kisiler tablosunu isimler ve soyisimler tablosundan dolduracagız
rastgele olarak.*/

declare 
@isim as varchar(30),
@soyisim as varchar(30),
@cinsiyet as char(1),
@dogum_tarihi as date,
@yas int,
@yas_grubu as varchar(30)

declare @i as int = 0

while @i < 1000
begin 

select @isim = isim, @cinsiyet = cinsiyet 
from Isimler where id = CONVERT(int, RAND() * 611)--611 olmasının nedeni 611 kayıt var
-- isimler tablosundan rasgele olarak isim ve cinsiyeti aldik

select @soyisim = soyisim from Soyisimler where id = CONVERT(int, RAND() * 1000)
-- soyisimler tablosundan rastgele soyisim aldık 

set @dogum_tarihi = DATEADD(DAY, CONVERT(int, RAND() * 18250), '1950-01-01')
set @yas = DATEDIFF(YEAR, @dogum_tarihi, GETDATE())

/*
if bloklarında birden fazla satır varsa begin end blogu arasında yazılır
if @yas < 10 
begin
	set @yas_grubu = 'Çocuk'
end
boylede kullanılır
*/
if @yas < 10 
	set @yas_grubu = 'Çocuk'

else if @yas between 10 and 25
	set @yas_grubu = 'Genç'

else if @yas between 26 and 40 
	set @yas_grubu = 'Yetişkin'

else if @yas between 41 and 60 
	set @yas_grubu = 'Orta yaşlı'

else
	set @yas_grubu = 'Yaşlı'

insert into Kisiler(isim, soyisim, cinsiyet,dogum_tarihi,yas, yas_grubu)
values(@isim, @soyisim, @cinsiyet, @dogum_tarihi, @yas, @yas_grubu)
set @i += 1
end

select * from Kisiler
/*
İsimler tablosu

Abdulkadir	E
Abdullah	E
Abdulsamet	E
Abdurrahman	E
Ada	K
Adem	E
Adil	E
Adnan	E
Ahmet	E
Ahmet Efe	E
Aleyna	K
Ali	E
Ali Eymen	E
Ali Osman	E
Aliye	K
Alparslan	E
Alper	E
Alperen	E
Alya	K
Amine	K
Anıl	E
Aras	E
Arda	E
Arif	E
Arife	K
Arin	K
Arya	K
Arzu	K
Asel	K
Asiye	K
Aslı	K
Aslıhan	K
Asmin	K
Asya	K
Atakan	E
Ayaz	E
Aydın	E
Ayfer	K
Ayhan	E
Aykut	E
Aylin	K
Aynur	K
Aysel	K
Aysima	K
Aysun	K
Ayşe	K
Ayşe nur	K
Ayşegül	K
Ayşenur	K
Ayten	K
Azad	E
Azat	E
Aziz	E
Azra	K
Bahar	K
Baran	E
Barış	E
Batuhan	E
Bayram	E
Bedirhan	E
Bedriye	K
Bekir	E
Belinay	K
Berat	E
Beren	K
Berfin	K
Beril	K
Berivan	K
Berk	E
Berkay	E
Berke	E
Berna	K
Berra	K
Betül	K
Beyza	K
Beyza nur	K
Beyzanur	K
Bilal	E
Birgül	K
Birol	E
Birsen	K
Boran	E
Buğlem	K
Buket	K
Burak	E
Burcu	K
Burhan	E
Buse	K
Bülent	E
Bünyamin	E
Büşra	K
Cafer	E
Can	E
Canan	K
Caner	E
Cansel	K
Cansu	K
Celal	E
Cem	E
Cemal	E
Cemil	E
Cemile	K
Cemre	K
Cengiz	E
Cennet	K
Ceren	K
Ceyda	K
Ceylan	K
Ceylin	K
Cihan	E
Cuma	E
Çağla	K
Çetin	E
Çınar	E
Çiğdem	K
Damla	K
Defne	K
Demet	K
Deniz	E
Deniz	K
Derin	K
Derya	K
Devran	E
Didem	K
Dilan	K
Dilara	K
Dilek	K
Diyar	E
Doğan	E
Doğukan	E
Doruk	E
Döndü	K
Döne	K
Dudu	K
Duran	E
Durmuş	E
Dursun	E
Duru	K
Duygu	K
Ebrar	K
Ebru	K
Ebubekir	E
Ece	K
Ecrin	K
Eda	K
Edanur	K
Efe	E
Ege	E
Egemen	E
Ekin	K
Ekrem	E
Ela	K
Ela nur	K
Elanur	K
Elif	K
Elif ada	K
Elif naz	K
Elif nur	K
Elif su	K
Elife	K
Elifnur	K
Elifsu	K
Elmas	K
Emel	K
Emin	E
Emine	K
Emir	E
Emircan	E
Emirhan	E
Emrah	E
Emre	E
Enes	E
Engin	E
Ensar	E
Enver	E
Eray	E
Ercan	E
Erdal	E
Erdem	E
Erdi	E
Erdoğan	E
Eren	E
Erhan	E
Erkan	E
Erol	E
Ersin	E
Ertuğrul	E
Erva	K
Esila	K
Eslem	K
Esma	K
Esma nur	K
Esmanur	K
Esra	K
Evren	E
Eylül	K
Eymen	E
Eyüp	E
Ezel	K
Ezgi	K
Fadime	K
Fahrettin	E
Fahri	E
Faruk	E
Fatih	E
Fatma	K
Fatma nur	K
Fatma zehra	K
Fatmanur	K
Ferdi	E
Ferhat	E
Feride	K
Fevzi	E
Feyza	K
Fırat	E
Fikret	E
Fikriye	K
Filiz	K
Funda	K
Furkan	E
Gamze	K
Gizem	K
Gökçe	K
Gökhan	E
Gönül	K
Görkem	E
Gözde	K
Gülay	K
Gülcan	K
Güler	K
Gülhan	K
Güllü	K
Gülseren	K
Gülsüm	K
Gülşah	K
Gülşen	K
Gülten	K
Gülüzar	K
Güneş	K
Gürsel	E
Habibe	K
Hacer	K
Hafize	K
Hakan	E
Hakkı	E
Halil	E
Halil İbrahim	E
Halime	K
Halit	E
Hamdi	E
Hamide	K
Hamit	E
Hamza	E
Hanım	K
Hanife	K
Harun	E
Hasan	E
Hasan Hüseyin	E
Hatice	K
Hatice kübra	K
Hatun	K
Hava	K
Havin	K
Havva	K
Haydar	E
Hayrettin	E
Hayriye	K
Hayrunnisa	K
Hazal	K
Hediye	K
Helin	K
Hikmet	E
Hilal	K
Hira	K
Hira nur	K
Hiranur	K
Huriye	K
Hülya	K
Hümeyra	K
Hüseyin	E
Irmak	K
İbrahim	E
İbrahim Halil	E
İhsan	E
İkra	K
İkranur	K
İlayda	K
İlhan	E
İlker	E
İlknur	K
İlyas	E
İpek	K
İrem	K
İrfan	E
İsa	E
İsmail	E
İsmet	E
İzzet	E
Kaan	E
Kader	K
Kadir	E
Kadriye	K
Kamil	E
Kamile	K
Kardelen	K
Kayra	E
Kazım	E
Kemal	E
Kenan	E
Kerem	E
Kerim	E
Kevser	K
Kezban	K
Keziban	K
Kıymet	K
Kumsal	K
Kuzey	E
Kübra	K
Levent	E
Leyla	K
Lina	K
Lütfiye	K
Mahir	E
Mahmut	E
Makbule	K
Masal	K
Medine	K
Mehmet	E
Mehmet Akif	E
Mehmet Ali	E
Mehmet Can	E
Mehmet Efe	E
Mehmet Emin	E
Mehmet Emir	E
Mehtap	K
Melahat	K
Melek	K
Melih	E
Meliha	K
Melike	K
Melis	K
Melisa	K
Meltem	K
Memet	E
Meral	K
Mert	E
Mertcan	E
Merve	K
Meryem	K
Mesut	E
Mete	E
Metehan	E
Metin	E
Mevlüt	E
Mihriban	K
Mina	K
Mine	K
Mira	K
Miraç	E
Miray	K
Muammer	E
Muhammed	E
Muhammed Ali	E
Muhammed Emin	E
Muhammed Emir	E
Muhammed Enes	E
Muhammed Eymen	E
Muhammed Mustafa	E
Muhammed Talha	E
Muhammed Yusuf	E
Muhammet	E
Muhammet Ali	E
Muhammet Emin	E
Muharrem	E
Murat	E
Musa	E
Mustafa	E
Muzaffer	E
Mücahit	E
Münevver	K
Müzeyyen	K
Naciye	K
NAİME	K
Naime	K
Naime	K
Narin	K
Naz	K
Nazar	K
Nazife	K
Nazlı	K
Nazlıcan	K
Nazmiye	K
Nebahat	K
Necati	E
Necdet	E
Necla	K
Nehir	K
Neriman	K
Nermin	K
Neslihan	K
Nesrin	K
Neşe	K
Nevin	K
Nevzat	E
Nihal	K
Nihat	E
Nilgün	K
Nilüfer	K
Nimet	K
Nisa	K
Nisa nur	K
Nisanur	K
Niyazi	E
Nuran	K
Nuray	K
Nurcan	K
Nurettin	E
Nurgül	K
Nuri	E
Nuriye	K
Nurten	K
Nurullah	E
Oğuz	E
Oğuzhan	E
Okan	E
Oktay	E
Onur	E
Orhan	E
Osman	E
Ozan	E
Ömer	E
Ömer Asaf	E
Ömer Faruk	E
Ömer Halis	E
Öykü	K
Özcan	E
Özge	K
Özgür	E
Özkan	E
Özlem	K
Öznur	K
Pakize	K
Pelin	K
Perihan	K
Pınar	K
Polat	E
Poyraz	E
Rabia	K
Rahime	K
Ramazan	E
Ravza	K
Raziye	K
Recep	E
Remzi	E
Remziye	K
Resul	E
Reyhan	K
Rıdvan	E
Rıza	E
Rojin	K
Rukiye	K
Rumeysa	K
Rümeysa	K
Rüzgar	E
Saadet	K
Sabri	E
Sabriye	K
Sadık	E
Safiye	K
Salih	E
Saliha	K
Salim	E
Samet	E
Sami	E
Saniye	K
Sare	K
Satı	K
Savaş	E
Sebahat	K
Sebahattin	E
Seda	K
Sedanur	K
Sedat	E
Sedef	K
Sefa	E
Seher	K
Selahattin	E
Selçuk	E
Selda	K
Selim	E
Selin	K
Selma	K
Sema	K
Semanur	K
Semih	E
Semiha	K
Semra	K
Sena	K
Serap	K
Sercan	E
Serdar	E
Serhat	E
Serkan	E
Serpil	K
Seval	K
Sevcan	K
Sevda	K
Sevgi	K
Sevil	K
Sevim	K
Sezer	E
Sıla	K
Sıraç	E
Sibel	K
Simge	K
Sinan	E
Sinem	K
Soner	E
Songül	K
Suat	E
Sude	K
Sude naz	K
Sudenaz	K
Sudenur	K
Sultan	K
Suna	K
Süleyman	E
Sümeyye	K
Şaban	E
Şahin	E
Şaziye	K
Şenay	K
Şengül	K
Şenol	E
Şerafettin	E
Şerife	K
Şevket	E
Şevval	K
Şeyda	K
Şeyma	K
Şilan	K
Şule	K
Şükran	K
Şükriye	K
Şükrü	E
Taha	E
Tahir	E
Tahsin	E
Talha	E
Taner	E
Tansu	K
Tarık	E
Tayfun	E
Tolga	E
Toprak	E
Tuana	K
Tuba	K
Tugay	E
Tuğba	K
Tuğçe	K
Tunahan	E
Tuncay	E
Turan	E
Turgay	E
Tülay	K
Tülin	K
Türkan	K
Ufuk	E
Uğur	E
Umut	E
Utku	E
Ümit	E
Vedat	E
Veli	E
Veysel	E
Volkan	E
Yağız	E
Yağmur	K
Yakup	E
Yalçın	E
Yaren	K
Yasemin	K
Yasin	E
Yaşar	E
Yavuz	E
Yavuz Selim	E
Yeliz	K
Yeşim	K
Yeter	K
Yıldız	K
Yılmaz	E
Yiğit	E
Yunus	E
Yunus Emre	E
Yusuf	E
Yusuf Ali	E
Yusuf Eymen	E
Yüksel	E
Yüksel	K
Zafer	E
Zahide	K
Zehra	K
Zeki	E
Zekiye	K
Zeliha	K
Zerda	K
Zeynep	K
Zilan	K
Ziya	E
Zübeyde	K
Zümra	K

Soyisimler tablosu

ABAK
ACISU
AÇIKALIN
AÇIKGÖZOĞLU
ADACAN
ADAYOLU
ADIYAMAN
AGIRBAŞLI
AĞAÇAYAK
AĞRAĞ
AĞSARAN
AKAR
AKARSLAN
AKBAY
AKCAN
AKGÜNDÜZ
AKINCI
AKKUÇ
AKOSMAN
AKSAKAL
AKSESUAR
AKTAN
AKTAŞ
AKTUGBA
AKTÜRK
AKURAL
AKYAĞCI
AKYAZI
AKYOL
ALAŞAR
ALAŞLI
ALATA
ALBAĞLAR
ALBAY
ALDAÇ
ALEGÖZ
ALGAÇ
ALHANTEKİN
ALINAK
ALİCAN
ALİPAŞAOĞLU
ALMAÇ
ALMADAĞI
ALNIAÇIK
ALPAGUT
ALPTEKİN
ALTINAY
ALTUNKOZAOGLU
ALTUNTAL
ALTÜRK
ANAKAYA
ANCIN
ANIK
ANTEPLİ
APAY
APOSTOLİ
ARAS
AREL
ARGUN
ARPACI
ARSAV
ARSOY
ARULAT
ARVİŞ
ARZU
ASLANAGA
ASLANALP
ASLANBABA
ASLANER
ASLANSOY
ASLIMTÜRK
AŞIRT
AŞKAR
ATACAN
ATAHAN
ATAK
ATALAR
ATALAY
ATAN
ATICI
ATSAK
ATTİLA
AVUNCAN
AYARCI
AYAS
AYDOS
AYGÖREN
AYGÜNDÜZ
AYIŞ
AYTAC
AYTAŞ
AYTEŞ
AYYILMAZ
AZAKLI
BABATÜRK
BACER
BADA
BAGCAĞIZ
BAĞCI
BAHADI
BAHTİYAROĞLU
BAKICI
BAKIM
BAKOĞLU
BAKSI
BAKSİ
BALBAŞOGLU
BALBAŞOĞLU
BALCICI
BAMYACI
BARATOĞLU
BASSİRİ
BAŞA
BAŞALP
BAŞKAL
BAŞKALAYCI
BAŞODA
BATIR
BAYAR
BAYKAL
BAYKUŞ
BAYRAKTUTAR
BAYRAMÇAVUŞ
BAYSEL
BAYTEKİN
BEGİSİ
BEĞBURS
BEĞEN
BEHLÜL
BEKİL
BEKLEN
BEKTAS
BELGİN
BENDER
BENİCE
BEREÇ
BEREKET
BERSE
BEŞKAYA
BEZCELİ
BİCİ
BİLEN
BİLGİLİER
BİLGİNGÜLLÜOĞLU
BİNALİ
BİRGİL
BİRLİK
BİRSAN
BİŞAR
BOCUT
BOĞAÇACI
BOLLUKCU
BORDEMİR
BORUZAN
BOYBEYİ
BOYRAZ
BOYVATLI
BOZDAĞAN
BOZOĞLUER
BÖBER
BURTAKUÇİN
BUSTAN
BUYER
BÜTEV
BÜYÜKALTAY
BÜYÜKKOYUNCU
BÜYÜKOSMA
BÜYÜKSOY
CAKIROGLU
CAKMAN
CAMDAL
CAMİ
CAMSARI
CANGÜL
CANKI
CANKO
CANKUL
CANLIER
CANMAYA
CANSU
CAVDAR
CEBESOY
CEBİR
CEBİŞLİ
CENGİZOGLU
CESAR
CITTANOĞLU
CIVAN
CİFCİ
CİMENCAN
CİNDORUK
CİNOĞLU
COÇKUN
COMUK
COŞGEL
ÇABUKYÜRÜYEN
ÇAĞLIATALAY
ÇAĞŞIRLI
ÇAKIRCA
ÇAKMAKÇI
ÇALANGU
ÇALKA
ÇALTIK
ÇAMLI
ÇAMLIDAĞ
ÇAVDAROĞLU
ÇAVUŞLU
ÇAVUŞOĞLU
ÇAYGÜL
ÇEKGÜL
ÇEKİCEL
ÇEKİŞLİ
ÇELEBİOĞLU
ÇELENK
ÇELİKCAN
ÇELİKEĞE
ÇELİKOK
ÇELİKTAŞ
ÇENGEL
ÇERKRZ
ÇETİK
ÇETİNBAŞ
ÇETİNKOL
ÇEVRE
ÇIKIŞIR
ÇITLAATLI
ÇİFÇİ
ÇİFTGÜMÜŞ
ÇİLEK
ÇİMİLLİ
ÇİPER
ÇİTOĞLU
ÇİVAŞ
ÇİVİ
ÇOKDOĞAN
ÇOKKEÇECİ
ÇONA
ÇORA
ÇORAKÇIOĞLU
ÇÖMEN
ÇÜÇEN
DAGASAN
DAĞDELER
DALER
DALMAN
DANA
DEDELER
DEĞİRMEN
DELEN
DELİAK
DELİGÖZ
DELİKUŞ
DELİPOYRAZ
DEMIRCI
DEMİRALP
DEMİRKOL
DEMİRÖZÜ
DEMİRTAÇ
DEMİRTOKA
DENEK
DENGES
DENİZKURDU
DENLİ
DEPO
DERİNCEGÖZ
DERİNPINAR
DEVRİLMEZ
DİDMİN
DİKSAÇ
DİLAKŞİBUR
DİLBAS
DİLBAZ
DİLEK
DİLEKÖZ
DİNÇASLAN
DİNÇSOY
DİNECİ
DİNLER
DİRİHER
DMİRTAŞ
DOĞANEL
DOĞANGÖNÜL
DOĞDU
DOĞUTAN
DOKGÖZ
DOKUMACI
DOLUCA
DONBAYCI
DORLAY
DOYRANER
DÖLGEN
DÖRDER
DURAN
DURBAK
DURMAN
DURSUNKARA
DUTLUCALI
DUVAN
DÜLGERLER
DÜŞÜN
DÜZALAN
DÜZENLİ
DÜZLER
DÜZLEYEN
ECİRLİ
EDİNCİK
EFENDİOĞLU
EFESOY
EĞİNKAYA
EKELİK
EKER
EKİNCİ
ELAGÜNÜÇ
ELBAŞI
ELBİR
ELDEMİR
ELEKTİRİK
ELİŞİ
ELLİALTI
EMAN
EMAR
EMİL
EMİREL
EMLEK
EMRAN
ENİS
ENSEL
ENVES
ERALP
ERBERBER
ERCAN
ERCİN
ERÇAĞ
ERDİKMEN
ERDOĞMUŞ
ERDURMUŞ
ERECAN
EREN(CENNET)
ERGEL
ERGÖZ
ERGÜL
ERİM
ERİN
ERİŞMİŞ
ERKASAP
ERKEKKARDEŞ
ERKLOĞ
ERKOÇA
ERMAHİŞ
ERSEV
ERSÖZLÜ
ERTUÇ
ERTUĞRUL
ERTUNGA
ERTÜRKLER
ERYİK
ERZORLU
ESERTEPE
ESGİN
ESKİTÜRK
ETEKE
ETİLER
EVKURAN
EYİCE
EYİGÜN
EYÜP
EYÜPREİSOGLU
EYVAZ
FENAR
FERAH
FERATOĞLU
FERLİÇOLAK
FIRIN
FİDANBAY
FİDANCİ
FİLİK
GARAN
GARGILI
GARİPKUŞ
GAZCI
GEÇTÜRK
GEDİKÇİ
GELGEÇ
GELİŞEN
GENÇELİ
GENÇER
GENÇTÜRK
GEYLAN
GEZE
GİYİM
GÖCELİ
GÖÇERİ
GÖĞEBAKAN
GÖKDEMİR
GÖKMEN
GÖKMENOĞLU
GÖLTAŞ
GÖRDÜ
GÖRHAN
GÖRÜCÜ
GÖZE
GÖZTEPE
GÖZÜ
GÖZÜKIZIL
GÖZÜM
GÜÇTEKİN
GÜÇYETMEZ
GÜDÜMOĞ
GÜLÇİÇEK
GÜLDAĞI
GÜLDİKER
GÜLERİ
GÜLLÜ
GÜLLÜCE
GÜLSEROĞLU
GÜLTER
GÜMÜŞKALE
GÜMÜŞTAŞ
GÜNAÇTI
GÜNDAY
GÜNDOGDU
GÜNEL
GÜNEŞDOĞDU
GÜNGÖL
GÜNGÖRÜR
GÜNGÜL
GÜRBULAK
GÜRHAN
GÜRKAYNAK
GÜRSENGİL
GÜRSU
GÜRTÜRK
GÜSER
GÜVENDİK
GÜVENER
GÜVENOGLU
GÜZELTUNA
ĞÜVEN
HAKVERDİ
HALİ
HAMDİ
HAMİTYENEN
HARMANCI
HASALTIN
HASBAHÇELİ
HASÇELİK
HASKÖY
HASÖKSÜZ
HASPOLAT
HEPAĞARTAN
HEYBET
HEZER
HINISLIOĞLU
HIRSİN
HIZAR
HIZMAN
HİZMETLERİ
HOTEL
HÜNERLİ
HÜRSEVER
ILGAZ
IŞIKOĞLU
IŞIKVER
IŞLAK
IZDEROĞLU
İÇAÇAN
İDİS
İĞCİ
İLATA
İLGÜN
İLİMAN
İLKEHAN
İLME
İNCEDAYI
İNCEGÖZ
İNDAP
İNEKÇİOĞLU
İNER
İNTİKAM
İSMİSÖNMEZ
İSPİR
İSPİRDEN
İŞCİ
İŞIK
İYİGÜN
İZOL
JKARGIN
KABAKCIOĞLU
KABAKLIOĞLU
KAHRAMANOĞLU
KAHYAOĞLU
KAKIZ
KAKLIK
KALCAR
KALEİCİ
KALYON
KAMACI
KANDAK
KANPINAR
KANTAŞLI
KAPLANKAYA
KAPLANOĞLU
KAPUSUZ
KARAAHMET
KARABAGLI
KARABICAK
KARABUL
KARACAN
KARAÇAVUŞ
KARAÇİVİ
KARAÇUBAN
KARADAG
KARADEMIR
KARAER
KARAGÖLLÜ
KARAİSMAİL
KARAKADILAR
KARAKARAKOÇ
KARAKULLUKCU
KARAKUZ
KARAMEMİŞ
KARAMUK
KARATOP
KARAYAZILI
KARLITEPE
KARMIŞ
KAROL
KARPAT
KARSLI
KARŞIN
KASAPÇI
KASIM
KASINOĞLU
KATAROĞLU
KATKAYA
KAVCI
KAVUKLU
KAVURMACIOĞLU
KAVUŞTURAN
KAYGIN
KAYIKOĞLU
KAYTAZOĞLU
KAZDAĞ
KECECİ
KEÇEÇİ
KEÇİCİ
KEÇKİL
KELAMLI
KELER
KELEŞLİ
KEMAL
KHAN
KIDEMLİ
KILIÇEL
KINAL
KINAR
KIRANATLIO
KIRBOĞA
KIRÇİÇEK
KIRIMLI
KIRMAN
KIRTAY
KISTIR
KIŞLA
KIŞLAL
KIVRIKOĞLU
KIYAR
KIYMET
KIZILARIK
KIZILDEMİR
KIZILSAÇ
KİRACIOĞLU
KİREN
KOCABEY
KOCABIYIKOĞLU
KOCAER
KOCAEREN
KOCAÖZ
KOÇANALI
KOÇAŞ
KOÇDAŞ
KOÇHAN
KOÇÖZ
KODAZ
KOLAŞ
KOLDEMİR
KONAKÇI
KONGUR
KONT
KONUYCU
KORAMAZ
KORUR
KOZLU
KOZLUCA
KÖKCÜ
KÖKENEK
KÖKER
KÖKÖZ
KÖMÜRLÜOĞLU
KÖMÜŞÇÜ
KÖSEHALİLOĞLU
KÖSER
KÖTEN
KÖYBAŞI
KÖZİĞE
KUBUR
KUCUKOĞLU
KUDAK
KULANER
KULEÇİ
KULÜBÜ
KUMBAY
KUMSARI
KURBET
KURDOĞLU
KURFEYS
KURİŞ
KURTAN
KURTEL
KURUBAL
KURUTEPE
KUSGÖZ
KUŞAKÇI
KUTBAY
KUTLUSAN
KUYUCUOĞLU
KÜÇÜKAHMETOĞLU
KÜÇÜKALTAY
KÜÇÜKGÖK
KÜÇÜKKÖSE
KÜÇÜKLER
KÜÇÜKÖNER
KÜÇÜKTIĞLI
KÜNTER
KÜREKÇİ
LAFCI
LENGER
LİVÇAPAR
LİVGÖÇMEN
LİVKEBAPÇI
LOJİSTİK
MADANOĞLU
MADRAN
MAHMUT
MANDI
MANTICI
MARAŞLI
MARDİNLİOĞLU
MATA
MAYADAĞ
MERDAN
MERTCAN
MEŞEGÜLÜ
MEZARCI
MISIR
MİNTAŞ
MİRAP
MOLLAOĞLU
MOLO
MOLU
MORDUZ
MORGÜL
MUCAK
MUÇKOVİAK
MUNZUR
MÜEZZİNOĞLU
MÜŞTERİLERİ
NAKİPOĞLU
NALBANTOĞLU
NALDEMİRCİ
NALİCİ
NAMAL
NARMAN
NART
NASIROĞLU
NAZLIOĞLU
NEFES
NESLİ
NURANSOY
NURİÜNLÜKAYA
NURSACAN
NUSUMBU
OFLAS
OFLAZ
OĞAN
OĞURLU
OKKAN
OLGUNDENİZ
ONAÇ
ONAZ
ONGUN
ORALLI
ORANLI
ORCAN
ORTABAY
OSMAY
OTAR
OYRAN
OZBEKAR
ÖCER
ÖGEN
ÖĞÜNÇ
ÖKMEN
ÖKSÜZ
ÖMERHOCA
ÖNYÖRÜ
ÖRDEK
ÖRİKLİ
ÖRTEN
ÖZAKIN
ÖZAYTÜRK
ÖZBURSA
ÖZDÖNMEZ
ÖZELCAN
ÖZENÇ
ÖZEROĞLU
ÖZFİDANCI
ÖZGİRAY
ÖZGÖNCÜ
ÖZGÜDER
ÖZKALIPÇI
ÖZKUL
ÖZKUZUCU
ÖZOCAK
ÖZPAÇA
ÖZSEVİM
ÖZTAŞKENT
ÖZTEMEL
ÖZÜBEK
ÖZVURMAZ
ÖZYILMAZ
PAÇARO
PALABIYIK
PALAMUT
PAMUK
PARLA
PARLAKLI
PARMAKVİRANLIGİL
PAYAS
PAYLAŞTIRAN
PEDÜK
PEHLİVAN
PEHLÜL
PEKCAN
PEKESEN
PEKSEN
PELVANOĞLU
PERDE
PİNYAL
POÇAN
POLAT
RAÇA
RAKALAR
RENDA
RIZA
RODITIS
RUHTEMİZ
RUNİ
SABAS
SAÇU
SAGIRLI
SAGTEKİN
SAĞDIÇ
SAĞLANMAK
SAKARKAYA
SAKARTEPE
SAKI
SALDI
SALĞAR
SALMAZ
SALONLARI
SANDIĞI
SANDIKÇI
SANGU
SAPMAZ
SARACOGLU
SARGUT
SARIBIYIK
SARIBOGA
SARIERGİN
SARIGÖL
SARISAÇ
SARSU
SAVAS
SAVLUĞ
SAVRANLAR
SAYER
SAYGIN
SAYGİL
SAZDAĞ
SEÇER
SEKBAY
SELAYET
SEMEN
SEVİÇ
SEVİLEN
SEYHAN
SEYMENOGLU
SEYRAN
SICAKYÜZ
SINIFI
SIRMA
SIRTMAÇOĞLU
SİNİR
SİREL
SİSTEMLERİ
SOLUKCU
SONKUR
SORGULU
SOYDEĞER
SÖYÜNMEZ
SÜALP
SÜLER
SÜRE
SÜZER
ŞABANOGLU
ŞAHİNEL
ŞAKO
ŞALVARCI
ŞANLITÜRK
ŞAVKİN
ŞEFKATLİ
ŞEKERCİ
ŞEKUR
ŞENDURGUT
ŞENGÜLEROĞLU
ŞİMDİ
ŞİMŞEKLİ
ŞİMŞEKOĞLU
ŞİRVANİ
TABAN
TABAŞ
TAHMAZ
TAHTACI
TAKAN
TALAN
TALHAOGLU
TAMUR
TANAYDIN
TANKUŞ
TANRITANIR
TARAKÇI
TARİFÇİ
TAŞALIR
TAŞANLI
TAŞKINSU
TAŞLICALI
TAŞOCAK
TATAROGLU
TATİK
TAVAN
TAVSANCIOGLU
TAVUKCU
TECİMER
TEKELİOĞLU
TEKGÖZ
TEKME
TEKYÜREK
TELEKE
TELOĞLU
TEMİR
TEMURÇİN
TEREKLİ
TESİSLERİ
TIKIROĞLU
TİNGAZ
TOGAN
TOĞCAR
TOKLUMAN
TOMBAZ
TOPALAN
TOPCAN
TOPOĞLU
TOPRAĞIN
TOPRAKCI
TOPRAKKAYA
TOPUZLU
TOROS
TOYGAR
TOYRAN
TOZAK
TÖNGÜL
TÖRELİ
TUAÇ
TUĞLU
TUĞRUL
TUNADASENERİ
TUNÇBİLEK
TUNÇÖZ
TURAN
TURCU
TURGAL
TUTU
TUZCUKAYA
TÜFENKÇİ
TÜKEL
TÜNE
TÜNGER
TÜREMİŞ
UÇARCI
UĞURELLİ
ULUDAĞLI
UMAY
URAS
USLULAR
USMAN
UYAL
UYAROĞLU
UYUMSAL
UZBİLEK
UZDEMİR
UZUNBAYIR
UZUNÇINAR
UZUNOK
ÜÇAL
ÜÇHÖYÜK
ÜÇYILDIZ
ÜLGENER
ÜLKÜMEN
ÜNGÖR
ÜNGÜR
ÜNLÜCE
ÜNLÜKARA
ÜNSÜR
ÜNVER
ÜREDİ
ÜSTEL
ÜSTGÜL
ÜSTÜNBAŞ
ÜZÜMCÜ
VANLILAR
VARDARLI
VARIŞ
VARNALI
VATANSEVER
VERİM
VURANLAR
VURANOK
YAGIZ
YAGLECE
YAKALI
YALEZE
YALNIZ
YANALAK
YANIKDAM
YAREN
YARGI"
YARKIN
YARUKLUK
YASKI
YAŞAROĞLU
YAŞDAL
YAYA
YAZICIOGLU
YAZIÇI
YAZKI
YEDİPARMAK
YELMEN
YENER
YEREL
YERER
YEŞİLADALI
YEŞİLÇAM
YEŞİR
YETEK
YETER
YETKİNER
YILDIRIIM
YILDIRIMLAR
YILDIZAN
YILDIZTEKİN
YILMAN
YILMAZLAR
YIRTIK
YİGEN
YİĞENOĞLU
YİĞİTLER
YORGANCI
YÖRÜNG
YUMUŞAK
YURDASAHİP
YURTALAN
YURTDAŞ
YURTYAPAN
YUSUFOĞLU
YÜCELAN
YÜCEPUR
YÜCEYURT
YÜKSEKKAYA
YÜRER
YÜRK
ZEMBİLCİOĞLU
ZERENER
ZERENOĞLU
ZERMAN
ZIHLI
ZORGÜL
ZORLU
ZUVİN
ZÜRAP
*/