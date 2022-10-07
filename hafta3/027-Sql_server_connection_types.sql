-- sql server baglantı sekilleri
/*
sql servera baglantı yapar biz genelde pc adı ile giris yapıyorduk buna alternatıf 
olarak . ile de localhost yazarakta baglantı yapabiliriz.
Bu baglantılardan harıc olarak network uzerindende baglantı yapılabilir.
bilgisayarın ip'si(127.0.0.1) uzerinden de baglantı saglanabilir.
Bunu direk yaparsak baglantı hata alırız. Cunku TCP/IP ile Named Pipes disable
durumdadır. Bunları bizim enable duruma getirmemiz gerekir. Bunları enable 
duruma getırmek icin sql server configuration manager acarak yapacagız.
Buradanda sql server network configuration tıklayıp oradan da protocols'e tıklayıp
enable hale getirecegiz. En sonda server'a restast yaparak sql server'a network
yani ip uzerindende baglanabilir hale gelecegiz

Bu 127.0.0.1 ip adresi kendi bilgisayarimizin ip adresidir.
Birde sanal makinenin ip adresi uzerinden de baglanabiliriz.
Bunu ogrenmek icin sanal makinemiz asıl makineye ethernet uzerinden baglıdır.

network 2 tıklanır yanı ethernet sembolunun ustune ipv4 adresi bizim sanal 
makinemizin ip adresi olmaktadır. bu adres ile de sql server'a baglanabılırız.

*/