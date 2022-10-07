-- instead of triggers

/*asıl tablomuzda silinmesini istemedigimiz verileri kullaniciya silinmis
gibi gosterip aslında silinmemesidir. Boylece bilerek veya bilmiyerek
verilerimizin guvenligini saglamis olabiliriz. 
*/

-- instead trigger olusturalim.
use ETRADE

create trigger TR_Log_Items_Update_Delete_Instead_Trigger
on ITEMS instead of delete, update -- after degil instead of demeliyiz
as
begin 
	declare 
	@DELETEDCOUNT as int,
	@INSERTEDCOUNT as int

	select @DELETEDCOUNT = COUNT(*) from deleted
	select @INSERTEDCOUNT = COUNT(*) from inserted

	declare @ACTIONTYPE as varchar(20)

	if @DELETEDCOUNT > 0 and @INSERTEDCOUNT > 0
	-- iki tabloda da deger var demek bu da update islemi oluyor demektir.
		set @ACTIONTYPE = 'UPDATE'

	if @DELETEDCOUNT > 0 and @INSERTEDCOUNT = 0
	-- silme islemidir 
		set @ACTIONTYPE = 'DELETE'

	insert into ETRADE.dbo.ITEMS_LOG
	(
	[ITEMCODE], 
	[ITEMNAME],
	[UNITPRICE],
	[CATEGORY1],
	[CATEGORY2], 
	[CATEGORY3], 
	[CATEGORY4],
	[BRAND], 
	[LOG_ACTION_TYPE],
	[LOG_DATE],
	[LOG_USERNAME],
	[LOG_PROGRAMNAME],
	[LOG_HOSTNAME]
	)
	select 
	[ITEMCODE], 
	[ITEMNAME], 
	[UNITPRICE], 
	[CATEGORY1], 
	[CATEGORY2],
	[CATEGORY3],
	[CATEGORY4],
	[BRAND],
	@ACTIONTYPE,
	GETDATE(),
	SUSER_NAME(),
	PROGRAM_NAME(),
	HOST_NAME()
	
	from deleted
end

/*simdi silme veya guncelleme islemi yapasak ise yaramaz cunku onceki trigger
olan TR_Log_Items_Update_Delete pasif hale getirmeliyiz cunku bu trigger
gercekten siliyor veya guncelliyor.*/

-- pasif hale getirme

disable trigger ITEMS.[TR_Log_Items_Update_Delete] on ETRADE.dbo.ITEMS
-- etkisiz hale getirdik etkin hale getirmek icinde enable kullanilir.

select * from ETRADE.dbo.ITEMS where ID = 10
-- bu urunu silmeye calısalım items_log tablosunda boyle bir kayıt yok suan

select * from ETRADE.dbo.ITEMS_LOG where ID = 10

delete from ETRADE.dbo.ITEMS where ID = 10

select * from ETRADE.dbo.ITEMS where ID = 10

select * from ETRADE.dbo.ITEMS_LOG 
-- hem gercekten silinmedi hemde log tablosuna etkendi kullanici yanlıtmaya 
-- birebir.

-- Şifreli Trigger Oluşturma (With Encryption)
/*
Tetikleyicimizin düzenlenebilirliğini kapatmak için şifreleme işlemi 
uygulanır. Şifrelenen Tetikleyiciler üzerinde artık kendimiz dahi 
değişiklik yapamayız. Bunun için şifreli tetikleyici oluştururken 
tetikleyici kodlarının da yedeğini bir yerde saklamamız ilerde değişiklik
yapmak istediğimizde gerekli olabilir. Şifreli Tetikleyici, normal 
tetikleyici oluşturur gibi Tetikleyici isminden sonra WITH ENCRYPTION
ifadesi eklenerek oluşturulur.
*/

-- yukarıda ki triggeri sifreli hale getirelim.
alter trigger TR_Log_Items_Update_Delete_Instead_Trigger
on ITEMS
with encryption -- sifreli hale getirir.

instead of delete, update -- after degil instead of demeliyiz
as
begin 
	declare 
	@DELETEDCOUNT as int,
	@INSERTEDCOUNT as int

	select @DELETEDCOUNT = COUNT(*) from deleted
	select @INSERTEDCOUNT = COUNT(*) from inserted

	declare @ACTIONTYPE as varchar(20)

	if @DELETEDCOUNT > 0 and @INSERTEDCOUNT > 0
	-- iki tabloda da deger var demek bu da update islemi oluyor demektir.
		set @ACTIONTYPE = 'UPDATE'

	if @DELETEDCOUNT > 0 and @INSERTEDCOUNT = 0
	-- silme islemidir 
		set @ACTIONTYPE = 'DELETE'

	insert into ETRADE.dbo.ITEMS_LOG
	(
	[ITEMCODE], 
	[ITEMNAME],
	[UNITPRICE],
	[CATEGORY1],
	[CATEGORY2], 
	[CATEGORY3], 
	[CATEGORY4],
	[BRAND], 
	[LOG_ACTION_TYPE],
	[LOG_DATE],
	[LOG_USERNAME],
	[LOG_PROGRAMNAME],
	[LOG_HOSTNAME]
	)
	select 
	[ITEMCODE], 
	[ITEMNAME], 
	[UNITPRICE], 
	[CATEGORY1], 
	[CATEGORY2],
	[CATEGORY3],
	[CATEGORY4],
	[BRAND],
	@ACTIONTYPE,
	GETDATE(),
	SUSER_NAME(),
	PROGRAM_NAME(),
	HOST_NAME()
	
	from deleted
end