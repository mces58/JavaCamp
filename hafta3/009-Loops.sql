-- donguler
-- t-sql'de for donguleri yoktur bunun yerine while dongusu kullanılır
-- yapisi asagıdaki gibidir

declare @i as int = 0 -- i degiskeni olusturduk

while @i < 10
begin

print @i -- i'yi ekrana basma select'te kullanilabilir
set @i += 1

end -- yapacagımız islemler begin end arasına yazılır

-- while dongusune bir ornek yapalım tabloya deger ekleme tarzında

create database TEST 

use TEST

create table Tarihler(
id int identity(1,1) primary key,
tarih datetime)

declare @j as int = 0
while @j < 10
begin
insert into Tarihler(tarih) values(GETDATE())
set @j += 1
end

select * from Tarihler
-- boylece 10 defa tarih eklemis olduk
-- lakın sıstem cok hizlı bir sekilde ekleme islemi yaptıgı icin 
-- milisaniye cınsinden farkı gorebiliyoruz sadece bu while dongusunun
-- biraz daha yavas calısmasını istersek waitfor delay komutunu kullanmaliyiz

declare @j as int = 0
while @j < 10
begin
insert into Tarihler(tarih) values(GETDATE())
waitfor delay '00:00:01'-- saat:dakika:saniye seklinde
set @j += 1
end

select * from Tarihler
-- goruldugu gibi her 1 sanıyede bir kayıt eklemis
