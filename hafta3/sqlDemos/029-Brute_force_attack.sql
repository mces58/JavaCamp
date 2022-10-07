exec xp_readerrorlog
/*bu prosedur bize yapılan denemeleri gosterir yanı servera baglanmak icin
yapılan denemeleri gosterir. ayrıca managenment kısmının altında sql server logs
var buradan da bu denemeleri gorebiliriz.
Bu denemeleri daha okunaklı olması ıcın bir tabloya atabiliriz.
*/

-- gecici tablo olusturduk ısımız bıttıgınde ucup gitsin diye
create table #LOG
(
logDate datetime,
processInfo varchar(100),
text varchar(max)
)

-- bu tabloyu doldurmak icin yukarıda ki proseduru kullanacagiz
insert into #LOG exec xp_readerrorlog

select * from #LOG -- degerleri tabloya attık

/*simdi bu tabloya bakarak saldırı var mı yok mu anlayacagız.
Bunu anlamak icin fail olan girisleri aramak yeterlidir.*/

select * from #LOG where text like 'login failed%'
-- tum fail girisleri cekti 2949 tane

/*lakin bizim icin zamanda onemli yani hangi zamanlarda saldırı yapılımıs
bunu da filtrelememiz gerekir.*/

select * from #LOG where text like 'login failed%' 
and logDate >= DATEADD(MINUTE,-3, GETDATE())
/*bu sorguda son 3dk icinde fail olan sifre denemesi oldu mu onu gosteren bir
sorgudur. Sonux olarak bir sey gelmedi demek ki son 3 dk bir saldırı olmamıs demek
*/

/*buraya kadar yaptıklarımız saldırıyı tespıt etmek idi. 2. adım ise sistem 
yoneticisine bir bilgilendirme mesajı(mail) gondermemız gerekıyor.*/

/*
ornek mesaj olarak sunu diyebiliriz.
sisteminiz saldırı altında. 127.0.0.1 ip adresli makine 14:03:26 ile 14:03:30 
arasında 2949 defa yanlıs sifre denemesinde bulundu.
*/
-- mesajdaki dinamık yerleri yakalamamız gerekiyor.

declare @ip as varchar(100)
declare @count as int
declare @beginDate as datetime
declare @endDate as datetime
declare @text as varchar(max)
declare @message as varchar(1000)

select @count = COUNT(*), @beginDate = MIN(logDate), @endDate = MAX(logDate),
@text = text from #LOG where text like 'login failed%' 
and logDate >= DATEADD(MINUTE,-3, GETDATE()) 
group by text
having COUNT(logDate) > 100

select @ip = RIGHT(@text, LEN(@text) - CHARINDEX('[' , @text))
set @ip = REPLACE(@ip, ']', '')
set @ip = REPLACE(@ip, 'CLIENT:', '')

set @message = 'Sisteminiz saldırı altında.' + @ip + ' ip adresli makine ' + 
CONVERT(varchar, @beginDate, 108) + ' ile ' + CONVERT(varchar, @endDate, 108) + 
' saatleri arasında ' + CONVERT(varchar, @count) + 
' defa yanlıs sifre denemesinde bulundu.'

select @message

if @count > 100
begin
	exec msdb.dbo.sp_send_dbmail
	@profile_name = 'SQLMAIL',
	@recipients = 'eserc865@gmail.com',
	@body = @message,
	@subject = 'SALDIRI'
end

-- yukarıda mail gonderdık yani yoneticiyi bilgilendirdik saldırı altındayız
-- diye lakın saldırıya karsı bir onlem almadık simdi onlem almaya calısalım.
-- bunun icin server bazlı trigger yazlıp giris yapmaya calısan ip adresi engellenir
