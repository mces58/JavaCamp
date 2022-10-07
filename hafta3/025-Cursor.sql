/*
T-SQL her ne kadar bir veri tanımlama, işaretleme ve kontrol dili olsada
yapısal olarak bazen var olan konseptin dışında ihtiyaçlar doğrultusunda
kullanmamız gerekebilen programlama dilidir. Çekilen verileri bütünsel ve 
kümesel olarak her türlü işleme tabi tutabildiğimiz T-SQL konseptinde eğer
ki elde edilen veri kümesi içerisinde satır satır işlem yapmamız gereken bir
durum söz konusu olursa dilin yeteneği olan while döngüsünü birşekilde 
kullanabiliriz lakin özellikle bu işlem için geliştirilmiş Cursorları tercih
etmemiz daha doğru olacaktır. O halde gelin Cursor nedir, nasıl kullanılır?
inceleyelim…
*/

-- Cursor Nedir?
/*
Cursorlar, veri kümesindeki her bir veriyi adım adım bizlere getiren ve 
bu şekilde satırsal bazda işlem yapmamızı sağlayan yapılardır. Çalışma 
şekilleri varsayılan olarak ileri doğru olsada ileri ve geri olmak üzere 
sırasıyla tüm satırları elde etme usulüne dayanır. İleri doğru okuma işlemi 
yapan Cursorlar geriye doğru okuma işlemi yapanlardan kat be kat hızlı 
çalışmaktadırlar.
*/

-- Cursor Neden Kullanılır?
/*
Her yapının bir kullanım nedeni olduğu gibi Cursorların kullanım nedenleride
aşağıdaki durumlardır;

* Sorgu neticesinde elde edilen veri kümesinde satır satır gezinerek işlem
yapmak.
* Diğer kullanıcılar tarafından yapılan değişikliklerin görünürlük seviyesini
ayarlamak.

için kullanılır.
*/

-- Cursorları bir nevi dizi uzerinde dolasmak gibi dusunebilirsin. Veri seti
-- uzerinde dolasarak tek bir veri bazlı islemler yapılabilir.

-- Kullanimina bakalım.
/*
senaryo su etrade database'inde ki users tablosunu kullanarak bugun 
dogmus olan kullanicilara kisiye ozel olarak mail atmak.
*/

use ETRADE

-- tum kisiler
select * from USERS


-- bugun dogmus kısıler
select * from USERS 
where DAY(BIRTHDATE) = DAY(GETDATE()) and MONTH(BIRTHDATE) = MONTH(GETDATE())

-- bize lazım olan kullanicinin adı yası ve mail adresi 
-- bunları bir degisken uzerinden tanımlayarak yapacagız
-- mail adresleri gercek olmadıgı icin mail atamayacagız.

declare @name_surname as varchar(50)
declare @age as int
declare @mail as varchar(100)
declare @message as varchar(500)


-- 67. satırda cursor tanımlıyoruz. Dikkat ederseniz eğer cursor tanımının,
-- t-sql’de ki normal değişken tanımlarından farkı ‘@’ karakterini kullanmamaktır.
declare mail_cursor cursor 

-- 71. satırda veri kümemizi getirecek olan sorgu tanımlanmaktadır.
-- Yani cursor hangi veri kumesi uzerinde calısacak o sorguyu yazıyoruz.
for 
select NAMESURNAME, DATEDIFF(YEAR, BIRTHDATE, GETDATE()) as AGE, EMAIL from USERS
where DAY(BIRTHDATE) = DAY(GETDATE()) and MONTH(BIRTHDATE) = MONTH(GETDATE())

-- 77. satırda ise cursor açılarak, aktifleştiriliyor. Nihayetinde veri okuma işlemi
-- hazır hale gelmeli ve kaynak tüketimi başlatılmalıdır.
open mail_cursor

-- 84. satırda ise ilk satır ele alınmakta ve kolon değerleri sırasıyla 
-- değişkenlere atanmaktadır.
-- Sıradaki veri yakalanıyor ve hafızaya alınıyor. O anki veri 'mail_cursor' 
-- tarafından temsil ediliyor ve kolon değerleri ilgili değişkenlere sıralı 
-- bir şekilde atanıyor.
fetch next from mail_cursor into @name_surname, @age, @mail

-- 90. satırda bulunan ‘@@FETCH_STATUS‘ global değişkeni her yeni satır 
-- getirildiğinde(FETCH) güncellenir ve bize aşağıdaki dört farklı değer ile durum bildirir.
-- Bizlerde bildirilen bu durumlara göre cursor’ı ileri ya da geri hareket ettirerek 
-- satırlar arasında dolaşırız.
while @@FETCH_STATUS = 0
begin
-- yapilacak islemler buraya yazılır.
select 'name surname: ' + @name_surname +'age: ' + convert(varchar, @age) + 'mail: ' + @mail
as INFORMATION

/*
-- mail gondermeyi aktif etmedigim icin suanlık burası yorum satırı olarak kalacak
set @message = 'Sayın' + @name_surname + ', doğum gününüz kutlu olsun. ' + 
CONVERT(varchar, @age) + '. yaşınızı kutlar, nice mutlu yıllar dileriz.'

exec msdb.dbo.sp_send_dbmail
@profile_name = 'can',
@subject = 'Mutlu yıllar',
@body = @message,
@recipients = @mail
*/

-- 109. satırda ise 84. satırda olduğu gibi veri kümesindeki bir sonraki satıra geçiliyor.
fetch next from mail_cursor into @name_surname, @age, @mail
end

-- 115. satırda ise açılan cursor kapatılmaktadır. Cursor kapatılmadığı taktirde
-- gereksiz yere sistem kaynağından bir tüketim yapacağından dolayı kullanıldığı 
-- noktalarda olası hatalar alınabilir.
close mail_cursor

-- 119. satırda ise hafızada cursor’a ayrılan belleği boşaltıyoruz. Bu işlemi 
-- CLOSE komutu sağlamadığından dolayı DEALLOCATE komutuyla gerçekleştiriyoruz.
deallocate mail_cursor

