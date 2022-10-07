-- Degisken tanımlama

create database TEST

use test

declare @isim as varchar(20)
-- degisken tanımlamak icin basına declare ifadesi yazılır
-- degiskenin basına da @ ifadesi konulur
-- sonrada degiskenin tipi belirtilir. suan degiskenin herhangi bir degeri yok
-- dolayısıyla null degerine sahıp
select @isim

declare @isim2 as varchar(20) = 'can'
select @isim2
-- baslangic degeri atanabilir

declare @isim3 as varchar(20)
set @isim3 = 'can'
select @isim3
-- sonradan da deger atanabilir

declare @sayi1 as integer 
set @sayi1 = 10

declare @sayi2 as integer 
set @sayi2 = 20

declare @toplam as integer 
set @toplam = @sayi1 + @sayi2

select @sayi1 as sayi1, @sayi2 as sayi2, @toplam as toplam
-- boyle degiskenler ayrı ayrı da tanımlanabilir
-- yada hepsi bir anda da tanımlanabilir

-- tek seferde declare yazarak tanımldık degiskenleri
declare @ad as varchar(10),
@soyad as varchar(10),
@ad_soyad as varchar(20)

set @ad = 'can'
set @soyad = 'eser'
set @ad_soyad = @ad + ' ' + @soyad

select @ad as ad, @soyad as soyad, @ad_soyad as [ad soyad]

-- buraya kadar degiskenlere deger atammayı statık olarak yaptık
-- birde degiskenlere tablolar uzerinden deger atayalım

create table isimler
(id int identity(1,1) primary key,
isim varchar(10), telefon char(10))

insert into isimler(isim, telefon)
values('can','23567'),('emos','45678'),('furkan','67890')
-- tabloyu olusturduk simdi de degiskenleri olusturalım

declare @name as varchar(10), @phone as char(10)

select @name = isim, @phone = telefon from isimler where id = 1
-- deger atama islemi where ile kosulumuzu belirtiyoruz
select @name as ad, @phone as telefon 

-- string fonksiyonları degiskenler ilede kullanilabilir

declare @kelime as varchar(50)
set @kelime = 'Merhaba Dünya'

select SUBSTRING(@kelime, 1,7)as [substring],
LOWER(@kelime) as [lower],
UPPER(@kelime) as [upper],
RIGHT(@kelime, 5) as [right],
LEFT(@kelime,7) as [left],
REPLACE(@kelime, 'ü','u') as [replace]

declare @kelime as varchar(50)
set @kelime = 'Merhaba Dünya'
select * from string_split(@kelime, ' ')
-- string_split parcalamaya yariyor lakin kullanımı  diger fonksiyonlardan
-- farklı string_split geriye bir tablo donderir dolayısıyla * from seklınde
-- kullaniriz. Burada string'i bosluk karakterine gore bolduk