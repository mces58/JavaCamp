select CHARINDEX('e', 'Mehmetcan ESER')
-- e harfinin indexsini verir

select LEFT('Mehmetcan ESER', 3)
-- soldan baslar 3 karakter alýr

select RIGHT('Mehmetcan ESER',3)
-- sagdan baslar 3 karakter alýr

-- simdi isim ve soyisimin bir kolonda tututldugu dusunulsun ve isim ile soyisimin ayrýlmasý
-- gerekmektedir. isim ile soyisimi ayrýnýz

select 'Mehmetcan ESER' as isim_soyisim -- isim ile soyisimin bitisik hali

select LEFT('Mehmetcan ESER', CHARINDEX(' ','Mehmetcan ESER')- 1) as isim,
-- bosluga kadar aldi bosluk karakteri de dahil lakin 1 cýkarýrsak bosluk karakterini cýkarmýs oluruz
 RIGHT('Mehmetcan ESER', LEN('Mehmetcan ESER') - CHARINDEX(' ' , 'Mehmetcan ESER')) as soyisim
-- uzunluktan aradaki boslugun index numarasýný cýkarýrsak soyisimi buluruz

-- degýsken tanýmlama
-- cumle degiskeninin icinde bugun kelimesi kac defa geciyor bunu bulan komutu yazýnýz
declare @cumle as varchar(max)
set @cumle = 'Bugün hava çok güzel. Bugün dýþarý çýkacaðým.'

declare @len1 as int 
set @len1 = LEN(@cumle)
-- cumle degiskeninin uzunlugunu atadýk

set @cumle = REPLACE(@cumle,'Bugün','')
-- cumle degiskeninden bugun kelimesinin yerine '' koyduk. replace degistirmeye yarar

declare @len2 as int
set @len2 = LEN(@cumle)

select (@len1 - @len2) / LEN('Bugün')

-- len1'den len2'yi cýkarýp aradýgýmýz kelmenin uzunluguna bolersek kac defa gectigini buluruz



