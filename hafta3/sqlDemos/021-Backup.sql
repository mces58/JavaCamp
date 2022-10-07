-- Backup alma islemleri

-- 1. yontem: full backup 
/* 
* Tüm veritabanının yedeğinin alınması işlemidir.
* Sistem çalışırken online olarak alınabilir.
* Sıkıştırma parametresi ile%95'lere kadar sıkıştırılarak alınabilir.
* Sadece backup alınan zamana dönülebilir.
*/

-- 2. yontem: differential backup
/*
* Alınan son full backup ile differential backup alınan zaman arasındaki 
değişim farkının alındığı backup türüdür.
* Full backup'a göre daha az yer kaplar.
* Sistem çalışırken online olarak alınabilir.
* Sıkıştırma parametresi ile%95'lere kadar sıkıştırılarak alınabilir.
* Sadece backup alınan zamana dönülebilir.
*/

-- 3. yontem: transaction log backup
/*
* Transaction log dosyasının yedeklenmesidir.
* En son alınan backup hangisi ise(Full,Differential yada Transaction Log 
farketmez)onunla arasındaki değişimi alır.
* Sistem çalışırken online olarak alınabilir.
* Sıkıştırma parametresi ile%95'lere kadar sıkıştırılarak alınabilir.
* Saniyelik olarak istediğimiz ana dönme imkanı verir.
*/

-- full backup alma
/*
* database sag tık yapılır.
* tasks tıklanır.
* backup tıklanır
* backtype ile yedek alma isleminin turu belirlenir
* yedek dosyasının yolu belirlenir default olarak sistem zaten belirler
* backup option bolumunden sıkıstırma yapmalıyız. burada compress backup
diyerek veritabanını sıkıstırarak yedegini alır

backup dosyalarının uzantısı .bak'tır.
*/
-- bu yedegin script karsıgı asagıdaki gibidir.
BACKUP DATABASE [TRIGGERS] TO  
DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL
\Backup\TRIGGERS.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'TRIGGERS-Full Database Backup', SKIP, 
NOREWIND, NOUNLOAD,  STATS = 10

-- restore ederekte yedekten donebiliz. script asagıdaki gibidir.yada
-- databases sag tık yapıpta restore edebiliriz
USE [master]
RESTORE DATABASE [TRIGGERS] FROM  DISK = N'C:\TIREGGERS.BAK'
WITH  FILE = 1,  NOUNLOAD,  STATS = 5

-- tasks bolumden diger backup alma turlerini de secerek ona gore de yedek
-- alınabilir.

-- farkli bir yedekten donme yolu ise;
-- eger elimizde bir veritabanın .mdf ve .ldf dosyaları var ise
-- onun uzerinde islem yapmak veya onu sql servere tanıtmak icin 
-- databases sag tık yapılır ve attach bolumune tıklanır oradanda add kısmına
-- tıklayarak veritabanını tanıtmıs oluruz

/*
genelde isletmeler gunde 4 defa full backup alırlar
06:00 -- 12:00 -- 18:00 -- 00:00 

ara dalan kalan saatlerde ise differential backup alınır ya yarım saatte bir
ya da bir saatte bir alınarak veri kaybı en aza indirgenmeye calısılır.
*/