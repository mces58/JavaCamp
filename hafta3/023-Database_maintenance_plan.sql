 -- sql server ile mail gondermek mumkundur. 
 
 -- PERİYODİK BAKIM PLANLARI

 -- İndex bozulmaları
 /*
 sql server'da yeni kayıtlar olustukca, kayıtlar silindikce ve guncellendikce
 indexler bozulur. Bozulan indexleri duzeltmek icin index rebuild ya da index
 reorganize islemi yapılır.
 */

 -- İstatistikleri guncellemek
 /*
 sql server'da sistem dogru indexi bulabilmek icin istatistiklere bakar.
 Yeni kayıtlar olustukca, kayıtlar silindikce ve guncellenikce bir indexte 
 hangi kaydın ne kadar oldugu(kayıt frekansi) degisir. İstatistikler ne kadar 
 guncel ise sistem dogru indexi o kadar iyi bulur.
 */

 -- Database shrink
 /*
 sql server'da bir database'e yeni kayıt eklendikce database buyur ama kayıt
 silindikce kuculmez. Eger buyuyen bir veritabanı kucultulmek istemiyorsa
 shrink islemi gerceklestirilir. 
 */

 -- Database backup
 /*
 bir veya birden fazla database'in yedeginin alınma islemidir. Full, differential
 ya da transaction log backup olarak istenen sekilde otomatik olarak calısacak
 backup islemidir.
 */

 -- Check database integrity
 /*
 database index ve table page'lerde herhangi bir sıkıntı olup olmadıgını
 kontrol eder. Yani database'lerde bir bozukluk olup olmadıgına bakar.
 */ 

 /*
 bu islemleri managenment bolumunden yapabiliriz
 management tıklanir
 oradan da maintenance plans'a sag tıkl yapılır
 maintenance plan wizard ile toplu ve kolayca bakımlar yapılabilir
 ya da new maintenance plan diyerek ayrı ayrı yapılabilir.
 */

 /*
 maintenance clean up task bakım islemi aslında biriken veya eskimis
 backup dosyalarını otomatize etmeye yarar. Yani elimizde 10 gunluk bir
 backup varsa 11. gune ayarlagımız silme islemi ile eski backuplar silinir
 */

 /*
 toolbox'taki gorevlerin anlamlari:

 Backup Database Task: Veritabanı Yedekleme.

 Check Database Integrity Task: Veritabanı Bütünlük Kontrolü.

 Execute SQL Server Agent Job Task: Sistem üzerinde yer alan farklı 
 bir iş planını çalıştırmanızı sağlar.

 Execute T-SQL Statement Task: Sistem üzerinde sizin yazacak olduğunuz 
 bir T-SQL kodunuzu çalıştırmanızı sağlar.

 History Cleanup Task:Sistem üzerinde işlem gören eski olaylara yönelik 
 belirli bir zamandan önceki geçmiş kayıtlarının temizlenmesini sağlar.

 Maintenance Cleanup Task: Daha önceki bakım işlemlerinden kalan 
 dosyaların temizlenmesini sağlar.

 Notify Operator Task: Yapılan işlem aşamasında sunucu üzerinde tanımlı
 operator mail adresine bilgilendirme gönderimini sağlar.

 Rebuild Index Task: Veritabanı üzerinde Index yapılarını yeniden oluşturur.

 Reorganize Index Task: Veritabanı üzerinde Index yapılarını düzenler, bakımını yapar.

 Shrink Database Task: Veritabanına bakım yaparak boyutunu küçültür.
 Shrink islemi ne kadar da faydali bir islem gibi gorunsede aslında tehlıkeli bir
 istir dolayısıyla bu isi otomatize etmek yerine manuel yapmak daha saglıklıdır.

 Update Statistics Task: Veritabanı üzerindeki istatistikleri yeniden düzenler.
 */