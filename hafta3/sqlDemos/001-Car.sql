--Burada sql fonksiyonlari ve GROUP BY islenmistir
use cars

create database cars

drop table if exists CAR_PRICES

create table CAR_PRICES(
	id int not null primary key identity(1,1),
	brand varchar(50)  not null,
	model varchar(50) not null,
	hardware varchar(200) not null,
	engine int not null,
	fuel_type varchar(50) not null,
	amount int not null,
	gear_type varchar(50) not null,
	price int not null,
	production_date datetime not null,
	year_of_production date, 
	website varchar(50) not null,
)

--https://github.com/nuriakman/Ornek_Veri_Setleri/blob/master/OtomobilFiyatlari.sql
--araba bilgilerini aldigim link
insert into CAR_PRICES(brand, model, hardware, engine, fuel_type, amount, gear_type, price, production_date, website) 
VALUES
('Smart', 'Forfour', '1.0 71 BG', 1000, 'Benzin', 6, 'Otomatik', 74600, '2021-10-10 18:07:25', 'http://tr.smart.com/'),
('Smart', 'Forfour Turbo', '1.0 90 BG', 1000, 'Benzin',	3, 'Otomatik', 77200, '2021-09-05 01:40:27', 'http://tr.smart.com/'),
('Smart', 'Fortwo Cabrio Turbo', '1.0 90 BG', 1000, 'Benzin', 2, 'Otomatik', 83300, '2020-07-16 07:47:59', 'http://tr.smart.com/'),
('Smart', 'Fortwo Coupe', '1.0 71 BG', 1000, 'Benzin', 12, 'Otomatik', 69300, '2019-12-07 10:24:20', 'http://tr.smart.com/'),

('Nissan', 'X-Trail', '1.6 dCi DESIGN PACK ALL MODE 4X4-i',	1600, 'Dizel', 2, 'Düz', 154285, '2021-09-09 02:35:01', 'https://www.nissan.com.tr/'),
('Nissan', 'Qashqai', '1.6 dCi VISIA', 1600, 'Dizel', 6, 'Otomatik', 117656, '2019-05-26 03:16:41', 'https://www.nissan.com.tr/'),
('Nissan', 'Pulsar', '1.5 dCi TEKNA', 1500, 'Dizel', 11, 'Düz', 82753, '2018-09-22 10:30:04', 'https://www.nissan.com.tr/'),
('Nissan', 'Navara', '2.3 dCi 4X4 VISIA', 2300, 'Dizel', 14, 'Düz', 92419, '2019-04-26 16:11:48', 'https://www.nissan.com.tr/'),
('Nissan', 'Micra', '1.2 STREET', 1200, 'Benzin', 6, 'Otomatik', 57941, '2018-10-20 18:17:58', 'https://www.nissan.com.tr/'),
('Nissan', 'Juke', '1.6 TEKNA', 1600, 'Benzin',	13, 'Otomatik', 78444, '2018-12-14 00:57:20', 'https://www.nissan.com.tr/'),
('Nissan', 'Juke', '1.5 dCi PLATINUM PREMIUM PACK', 1500, 'Dizel', 5, 'Düz', 100044, '2018-12-05 01:06:04', 'https://www.nissan.com.tr/'),
('Nissan', 'Juke', '1.5 dCi SKY PACK', 1500, 'Dizel', 8, 'Düz', 85729, '2021-01-24 07:45:50', 'https://www.nissan.com.tr/'),
('Nissan', 'Juke', '1.5 dCi SPECIAL EDITION', 1500, 'Dizel', 11, 'Düz',	91449, '2019-04-22 14:24:33', 'https://www.nissan.com.tr/'),
('Nissan', 'Juke', '1.5 dCi TEKNA', 1500, 'Dizel', 1, 'Düz', 81999, '2019-06-30 18:19:01', 'https://www.nissan.com.tr/'),

('Audi', 'A1 Sportback', '1.0 TFSI 95 hp Dynamic S tronic',	1000,	'Benzin',10 , 'Otomatik', 110271, '2020-02-15 01:03:16', 'http://www.audi.com.tr/'),
('Audi', 'A1 Sportback', '1.0 TFSI 95 hp Sport S tronic', 1000,	'Benzin', 6, 'Otomatik', 112661, '2019-09-12 02:50:01', 'http://www.audi.com.tr/'),
('Audi', 'A1 Sportback', '1.4 TFSI 125 hp Dynamic S tronic', 1400, 'Benzin', 1, 'Otomatik',	114973,	'2019-11-15 13:58:35', 'http://www.audi.com.tr/'),
('Audi', 'A1 Sportback', '1.4 TFSI 125 hp Sport S tronic ',	1400, 'Benzin',	10, 'Otomatik', 117406, '2019-11-06 02:00:15', 'http://www.audi.com.tr/'),
('Audi', 'A1 Sportback', '1.6 TDI 116 hp Dynamic S tronic ', 1600, 'Dizel',	5, 'Otomatik', 122755, '2022-04-04 02:37:21', 'http://www.audi.com.tr/'),
('Audi', 'A1 Sportback', '1.6 TDI 116 hp Sport S tronic ',1600,	'Dizel', 10, 'Otomatik', 133425, '2021-12-21 13:05:53', 'http://www.audi.com.tr/'),
('Audi', 'A3 Cabrio', '1.4 TFSI 150 hp (COD) Design Line S tronic PI', 1400, 'Benzin', 12, 'Otomatik', 189127, '2018-12-16 19:42:16', 'http://www.audi.com.tr/'),
('Audi', 'A3 Cabrio', '1.4 TFSI 150 hp (COD) Dynamic S tronic PI', 1400, 'Benzin', 1,'Otomatik', 181567, '2021-08-02 15:03:42', 'http://www.audi.com.tr/'),
('Audi', 'A3 Cabrio', '1.4 TFSI 150 hp (COD) Sport Line S tronic PI', 1400,	'Benzin', 8,'Otomatik',	189216,	'2018-11-17 23:15:34', 'http://www.audi.com.tr/'),
('Audi', 'A3 Sedan', '1.0 TFSI 116 hp Design Line S tronic PI',	1000, 'Benzin',	13, 'Otomatik',	157032,	'2021-11-01 23:29:51', 'http://www.audi.com.tr/'),

('Citroen', 'C Elysee',	'1.2 PURETECH 82HP M/T LIVE', 1200, 'Benzin', 11, 'Düz', 59500, '2021-03-04 02:18:03', 'http://www.citroen.com.tr/'),
('Citroen',	'C Elysee',	'1.6 HDI 92HP M/T ATTRACTION', 1600, 'Dizel', 4, 'Düz',	64600, '2018-01-27 09:16:21', 'http://www.citroen.com.tr/'),
('Citroen',	'C Elysee',	'1.6 HDI 92HP M/T CONFORT', 1600, 'Dizel', 3, 'Düz', 67130,	'2019-02-16 06:00:18', 'http://www.citroen.com.tr/'),
('Citroen',	'C Elysee',	'1.6 HDI 92HP M/T EXCLUSIVE', 1600, 'Dizel', 9, 'Düz', 69350, '2021-04-06 18:17:29', 'http://www.citroen.com.tr/'),
('Citroen',	'C Elysee',	'1.6 HDI 92HP M/T FEEL', 1600, 'Dizel', 11, 'Düz', 72600, '2021-03-28 21:19:34', 'http://www.citroen.com.tr/'),
('Citroen',	'C Elysee',	'1.6 HDI 92HP M/T LIVE', 1600, 'Dizel',	13, 'Düz', 72400, '2018-05-20 10:25:10', 'http://www.citroen.com.tr/'),
('Citroen',	'C Elysee',	'1.6 HDI 92HP M/T SHINE', 1600,	'Dizel', 3, 'Düz', 71650, '2022-02-03 08:53:45', 'http://www.citroen.com.tr/'),
('Citroen',	'C3', '1.2 PURETECH 82HP BVM5 FEEL', 1200, 'Benzin', 1, 'Düz', 64550, '2022-01-27 02:15:30', 'http://www.citroen.com.tr/'),
('Citroen',	'C3', '1.2 PURETECH 82HP BVM5 LIVE', 1200, 'Benzin', 2, 'Düz', 59850, '2019-08-26 07:14:09', 'http://www.citroen.com.tr/'),
('Citroen',	'C3', '1.6 BLUEHDI 100HP S&S BVM5 SHINE', 1600, 'Dizel', 14, 'Düz', 81800, '2018-05-08 04:04:28', 'http://www.citroen.com.tr/'),

('Infiniti', 'Q30',	'1.5 D 109 BG Premium ', 1500, 'Dizel', 4, 'Otomatik', 174896, '2018-01-23 04:59:25', 'http://infiniti.com.tr/'),
('Infiniti', 'Q30',	'1.5 D 109 BG Premium City Black', 1500, 'Dizel', 3, 'Otomatik', 195191, '2022-01-23 03:12:06', 'http://infiniti.com.tr/'),
('Infiniti', 'Q30',	'1.5 D 109 BG Premium City Black - Sport', 1500, 'Dizel', 2, 'Otomatik', 199474, '2020-04-18 04:09:43', 'http://infiniti.com.tr/'),
('Infiniti', 'Q30',	'1.6 P 156 BG Premium ', 1600, 'Benzin', 3, 'Otomatik', 164683, '2020-09-20 14:33:42', 'http://infiniti.com.tr/'),
('Infiniti', 'Q30',	'1.6 P 156 BG Premium Tech', 1600, 'Benzin', 10, 'Otomatik', 193543, '2020-08-01 14:49:06', 'http://infiniti.com.tr/'),
('Infiniti', 'Q30',	'1.6 P 156 BG Premium Tech - Theme ', 1600, 'Benzin', 4, 'Otomatik', 195191, '2021-01-16 01:17:20', 'http://infiniti.com.tr/'),
('Infiniti', 'Q30',	'1.6 P 156 BG Sport ', 1600, 'Benzin', 1, 'Otomatik', 183989, '2019-05-10 12:22:44', 'http://infiniti.com.tr/'),
('Infiniti', 'Q50',	'2.0 T 211 BG Premium ', 2000, 'Benzin', 11, 'Otomatik', 256717, '2021-01-14 18:08:56', 'http://infiniti.com.tr/'),
('Infiniti', 'Q50',	'2.0 T 211 BG Sport Tech', 2000, 'Benzin', 9, 'Otomatik', 299634, '2018-12-07 07:12:57', 'http://infiniti.com.tr/'),

('Ford', 'Focus Station Wagon',	'1.6L TDCi 95PS (230 Nm) Trend X', 1600, 'DizeL', 4,'Düz', 100715, '2020-12-04 17:56:00', 'http://www.ford.com.tr/'),
('Ford', 'Galaxy', '1.5L EcoBoost 160PS (240 Nm) Style', 1500, 'Benzin', 9, 'Düz', 169030, '2018-09-26 15:46:34', 'http://www.ford.com.tr/'),
('Ford', 'Galaxy', '2.0L TDCi 180PS (400Nm) Titanium', 2000, 'Dizel', 5, 'Otomatik', 269415, '2022-04-18 11:50:31', 'http://www.ford.com.tr/'),
('Ford', 'Kuga', '1.5L EcoBoost 182PS (240 Nm) Style', 1500, 'Benzin', 6, 'Otomatik', 117000, '2020-04-08 15:30:10', 'http://www.ford.com.tr/'),
('Ford', 'Kuga', '1.5L TDCi 120PS 120PS (270Nm) Style', 1500, 'Dizel', 11, 'Düz', 117000, '2018-01-10 10:08:44', 'http://www.ford.com.tr/'),
('Ford', 'Kuga', '1.5L TDCi 120PS 120PS (270Nm) Titanium', 1500, 'Dizel', 14, 'Düz', 123350, '2021-03-24 16:14:12', 'http://www.ford.com.tr/'),
('Ford', 'Kuga', '1.5L TDCi 120PS 120PS (300Nm) ST-Line', 1500, 'Dizel', 3, 'Otomatik',	147500,	'2019-03-16 11:59:33', 'http://www.ford.com.tr/'),
('Ford', 'Kuga', '1.5L TDCi 120PS 120PS (300Nm) Style', 1500,	'Dizel', 1, 'Otomatik', 123350, '2020-04-22 05:29:22', 'http://www.ford.com.tr/'),
('Ford', 'Kuga', '1.5L TDCi 120PS 120PS (300Nm) Titanium', 1500, 'Dizel', 13, 'Otomatik', 141000, '2021-12-05 10:01:48', 'http://www.ford.com.tr/'),
('Ford', 'Mondeo 4 Kapı', '1.5L EcoBoost 160PS (240 Nm) Style', 1500, 'Benzin',	7, 'Otomatik', 118445, '2021-12-26 04:05:22', 'http://www.ford.com.tr/'),

('Honda', 'Civic Sedan', '1.6L 125PS Premium ECO', 1600, 'Benzin', 5, 'Düz', 89000, '2020-04-17 09:30:23', 'https://honda.com.tr/'),
('Honda', 'Civic Sedan', '1.6L 125PS Premium ECO', 1600, 'Benzin', 13, 'Otomatik', 91500, '2020-12-06 01:44:43', 'https://honda.com.tr/'),
('Honda', 'CR-V', '1.6L 120PS Elegance', 1600, 'Dizel',	2, 'Düz', 155300, '2021-11-13 05:40:51', 'https://honda.com.tr/'),
('Honda', 'CR-V', '1.6L 120PS Premium', 1600, 'Dizel', 12, 'Düz', 148600, '2020-01-04 21:52:28', 'https://honda.com.tr/'),
('Honda', 'CR-V', '1.6L 160PS Elegance', 1600, 'Dizel',	15, 'Otomatik', 172600, '2020-10-30 18:01:29', 'https://honda.com.tr/'),
('Honda', 'CR-V', '1.6L 160PS Executive', 1600, 'Dizel', 10, 'Otomatik', 181700, '2020-11-05 08:09:16', 'https://honda.com.tr/'),
('Honda', 'CR-V', '1.6L 160PS Executive+', 1600, 'Dizel', 11, 'Otomatik', 190050, '2020-04-11 04:05:00', 'https://honda.com.tr/'),
('Honda', 'CR-V', '1.6L 160PS Premium', 1600, 'Dizel', 8, 'Otomatik', 164800, '2020-02-20 03:26:04', 'https://honda.com.tr/'),
('Honda', 'HR-V', '1.5L 130PS Elegance',	'1500',	'Benzin', 6, 'Düz', 104600, '2021-01-25 11:12:57', 'https://honda.com.tr/'),
('Honda', 'HR-V', '1.5L 130PS Elegance',	'1500',	'Benzin', 2, 'Otomatik', 108800, '2019-11-30 18:37:05', 'https://honda.com.tr/'),

('Hyundai', 'Accent Blue', '1.6 CRDI PRIME (DİZEL)', 1600, 'Dizel',	4, 'Düz', 81900, '2019-04-01 08:45:46',	'http://www.hyundai.com.tr'),
('Hyundai',	'Accent Blue', '1.6 CRDI PRIME DCT (DİZEL)', 1600, 'Dizel',	11, 'Otomatik', 89900, '2021-07-07 06:36:09', 'http://www.hyundai.com.tr'),
('Hyundai',	'Elantra', '1.6 CRDi ELITE (DİZEL)', 1600, 'Dizel', 7, 'Düz', 96900, '2018-06-16 10:11:10', 'http://www.hyundai.com.tr'),
('Hyundai',	'Elantra', '1.6 CRDi ELITE DCT (DİZEL)', 1600, 'Dizel',	10, 'Otomatik', 103900, '2021-02-13 07:53:36', 'http://www.hyundai.com.tr'),
('Hyundai',	'Elantra', '1.6 CRDi ELITE PLUS DCT (DİZEL)', 1600, 'Dizel', 11, 'Otomatik', 107900, '2018-11-23 16:44:40', 'http://www.hyundai.com.tr'),
('Hyundai',	'Elantra', '1.6 CRDi ELITE PLUS DCT (SUNROOF) (DİZEL)', 1600, 'Dizel', 13, 'Otomatik', 110400, '2018-01-30 09:08:39', 'http://www.hyundai.com.tr'),
('Hyundai',	'Elantra', '1.6 D-CVVT STYLE (BENZİNLİ)', 1600, 'Benzin', 11,'Düz', 73000, '2018-05-31 01:54:49', 'http://www.hyundai.com.tr'),
('Hyundai',	'Elantra', '1.6 D-CVVT STYLE OTM. (BENZİNLİ)', 1600, 'Benzin', 5, 'Otomatik', 79000, '2021-10-22 01:52:30', 'http://www.hyundai.com.tr'),
('Hyundai',	'i10', '1.0 D-CVVT JUMP (BENZİNLİ)', 1000,	'Benzin', 8, 'Düz', 46200, '2018-05-04 02:29:42', 'http://www.hyundai.com.tr'),
('Hyundai',	'i10', '1.0 D-CVVT JUMP OTM. (BENZİNLİ)', 1000,	'Benzin', 7,'Otomatik', 51400, '2021-10-02 02:02:33', 'http://www.hyundai.com.tr'),

('Alfa Romeo', '4C Spider', '1.8 TCT', 1800, 'Benzin', 7, 'Otomatik', 620000, '2018-08-14 09:51:24', 'http://www.alfaromeo.com.tr/'),
('Alfa Romeo', 'Giulia', '2.0 200hp SUPER RWD BENZİNLİ AT', 2000, 'Benzin',	11, 'Otomatik', 320000, '2020-09-30 04:05:46', 'http://www.alfaromeo.com.tr/'),
('Alfa Romeo', 'Giulia', '2.0 280hp VELOCE AWD BENZİNLİ AT', 2000, 'Benzin', 2, 'Otomatik',	380000,	'2019-10-12 17:48:25', 'http://www.alfaromeo.com.tr/'),
('Alfa Romeo', 'Giulia', '2.9 510hp QV RWD BENZİNLİ AT', 2900, 'Benzin', 5, 'Otomatik', 780000, '2021-01-24 19:41:00', 'http://www.alfaromeo.com.tr/'),
('Alfa Romeo', 'Giulietta', '1.4 TB MULTIAIR SUPER BENZİNLİ TCT', 1400, 'Benzin', 8, 'Otomatik', 121000, '2018-04-18 20:30:36', 'http://www.alfaromeo.com.tr/'),
('Alfa Romeo', 'Giulietta',	'1.6 JTD 120hp PROGRESSION DİZEL MT', 1600,	'Dizel', 2, 'Düz', 114000, '2021-09-04 19:26:07', 'http://www.alfaromeo.com.tr/'),
('Alfa Romeo', 'Giulietta',	'1.6 JTD 120hp SUPER DİZEL MT',	1600, 'Dizel', 3, 'Düz', 121000, '2020-09-15 22:23:12', 'http://www.alfaromeo.com.tr/'),
('Alfa Romeo', 'Giulietta',	'1.6 JTDM 120hp SUPER DİZEL TCT', 1600,	'Dizel', 7, 'Otomatik',	136000,	'2018-04-06 16:22:26', 'http://www.alfaromeo.com.tr/'),
('Alfa Romeo', 'Giulietta',	'1.6 JTDM PROGRESSION DİZEL TCT', 1600,	'Dizel', 4, 'Otomatik',	121000,	'2018-12-20 00:41:50', 'http://www.alfaromeo.com.tr/'),

('Toyota', 'Auris', '1.33 Life', 1300, 'Benzin', 2, 'Düz', 63950, '2018-11-19 16:04:59', 'https://www.toyota.com.tr/'),
('Toyota', 'Auris Touring Sports', '1.4 D-4D Advance', 1400, 'Dizel', 10, 'Düz', 106850, '2020-11-27 07:51:16', 'https://www.toyota.com.tr/'),
('Toyota', 'Avensis', '1.6 D-4D Advance', 1600,	'Dizel', 8, 'Düz', 119170, '2018-01-14 22:50:18', 'https://www.toyota.com.tr/'),
('Toyota', 'C-HR', '1.2 Turbo Advance 4x2', 1200, 'Benzin',	3, 'Düz', 99500, '2021-03-23 23:36:48', 'https://www.toyota.com.tr/'),
('Toyota', 'Corolla', '1.33 Life', 1300, 'Benzin', 6, 'Düz', 65950, '2020-01-06 16:39:45', 'https://www.toyota.com.tr/'),
('Toyota', 'Hilux', '2.4L 4x2 Active', 2400, 'Dizel', 10, 'Düz', 95650, '2020-03-11 13:08:18', 'https://www.toyota.com.tr/'),
('Toyota', 'Land Cruiser Prado', '2.8 D-4D', 2800, 'Dizel', 2, 'Otomatik', 606359, '2018-08-02 18:13:41', 'https://www.toyota.com.tr/'),
('Toyota', 'Prius','1.8L Hybrid Advance', 1800, 'Hibrit', 14, 'Otomatik', 175974, '2019-09-02 07:36:07', 'https://www.toyota.com.tr/'),
('Toyota', 'Rav4', '2.5 Hybrid Advance 4x4', 2500, 'Hibrit', 8, 'Otomatik', 173700, '2021-01-02 02:54:58', 'https://www.toyota.com.tr/'),
('Toyota', 'Yaris', '1.33 Style X-Trend', 1300,	'Benzin', 2, 'Düz', 66300, '2020-03-12 03:02:05', 'https://www.toyota.com.tr/'),

('Isuzu', 'D-Max', '2.5L 163 PS 4x2 LIMITED 6M/T Çift Kabin', 2500, 'Dizel', 14, 'Düz', 111280, '2020-10-11 08:00:02', 'http://www.isuzu.com.tr/'),
('Isuzu', 'D-Max', '2.5L 163 PS 4x2 TR 6M/T Çift Kabin', 2500, 'Dizel', 15, 'Düz', 86050, '2020-09-25 22:45:11', 'http://www.isuzu.com.tr/'),
('Isuzu', 'D-Max', '2.5L 163 PS 4x4 LIMITED 6M/T Çift Kabin', 2500, 'Dizel', 9, 'Düz', 115509, '2022-04-14 12:24:07', 'http://www.isuzu.com.tr/'),
('Isuzu', 'D-Max', '2.5L 163 PS 4x4 TR 6M/T Çift Kabin', 2500, 'Dizel', 12, 'Düz', 111229, '2019-01-14 16:43:27', 'http://www.isuzu.com.tr/'),
('Isuzu', 'D-Max', '2.5L 163 PS 4x4 V-CROSS 5A/T Çift Kabin', 2500, 'Dizel', 10, 'Otomatik', 141196, '2021-09-28 13:19:10', 'http://www.isuzu.com.tr/'),

('Jeep', 'Grand Cherokee Limited', '3.0 250hp 8ATX 4x4 Dizel Euro 6', 3000, 'Dizel', 2, 'Otomatik', 490000, '2020-03-14 17:03:01', 'http://www.jeep.com.tr/'),
('Jeep', 'Grand Cherokee Overland', '3.0 250hp 8ATX 4x4 Dizel Euro 6', 3000, 'Dizel', 3, 'Otomatik', 530000, '2020-09-20 17:20:42', 'http://www.jeep.com.tr/'),
('Jeep', 'Grand Cherokee Summit', '3.0 250hp 8ATX 4x4 Dizel Euro 6', 3000, 'Dizel',	15, 'Otomatik', 570000, '2019-03-02 05:26:34', 'http://www.jeep.com.tr/'),
('Jeep', 'Renegade', '1.4 MultiAir2 Turbo Benzinli 9ATX AWD Limited', 1400, 'Benzin', 1, 'Otomatik', 160000, '2018-06-06 13:01:36', 'http://www.jeep.com.tr/'),
('Jeep', 'Renegade', '1.4 MultiAir2 Turbo Benzinli DDCT 4x2 Limited', 1400, 'Benzin', 7, 'Otomatik', 136000, '2018-09-01 09:43:30',	'http://www.jeep.com.tr/'),
('Jeep', 'Renegade', '1.4 MultiAir2 Turbo Benzinli DDCT 4x2 Longitude', 1400, 'Benzin', 12, 'Otomatik', 121000, '2019-08-22 04:42:55', 'http://www.jeep.com.tr/'),
('Jeep', 'Renegade', '1.4 MultiAir2 Turbo Benzinli MT 4x2 Limited', 1400, 'Benzin',	10, 'Düz', 121000, '2021-11-08 02:10:10', 'http://www.jeep.com.tr/'),
('Jeep', 'Renegade', '1.4 MultiAir2 Turbo Benzinli MT 4x2 Longitude', 1400, 'Benzin', 7, 'Düz', 114000, '2020-07-18 01:44:24', 'http://www.jeep.com.tr/'),
('Jeep', 'Renegade', '1.6 120hp DDCT Longitude Dizel Std', 1600, 'Dizel', 1, 'Otomatik', 123850, '2020-09-08 17:31:22', 'http://www.jeep.com.tr/'),
('Jeep', 'Renegade', '1.6 120hp DDCT Longitude Dizel Std+Sunroof', 1600, 'Dizel', 13, 'Otomatik', 140000, '2018-08-25 06:30:32', 'http://www.jeep.com.tr/'),
('Jeep', 'Renegade', '1.6 Multijet Dizel MT 4x2 Limited', 1600, 'Dizel', 10, 'Düz', 136000, '2022-02-16 16:21:04', 'http://www.jeep.com.tr/'),
('Jeep', 'Renegade', '1.6 Multijet Dizel MT 4x2 Longitude', 1600, 'Dizel', 13, 'Düz',	121000, '2018-04-16 12:15:03', 'http://www.jeep.com.tr/'),

('Renault', 'Captur', '1.5 dCi 90 bg Stop & Start Touch', 1500, 'Dizel', 6, 'Düz', 81850, '2022-03-08 19:53:11', 'https://www.renault.com.tr/'),
('Renault', 'Clio',	'1.2 120 bg GT Line', 1200, 'Benzin', 10, 'Düz', 75800, '2020-11-21 18:16:22', 'https://www.renault.com.tr/'),
('Renault', 'Clio Sport Tourer', '1.2 75bg Joy', 1200, 'Benzin', 4, 'Düz', 62600, '2021-04-10 18:22:45', 'https://www.renault.com.tr/'),
('Renault', 'Kadjar', '1.2 TCe EDC 130 bg Icon', 1200, 'Benzin', 12, 'Otomatik', 118450, '2019-05-17 17:58:36', 'https://www.renault.com.tr/'),
('Renault', 'Megane HB', '1.2 Tce 130 bg Icon', 1200, 'Benzin', 6, 'Düz', 91200, '2019-10-30 06:44:11', 'https://www.renault.com.tr/'),
('Renault', 'Megane Sedan', '1.2 Tce EDC 130 bg Icon', 1200, 'Benzin', 10, 'Otomatik', 103550, '2019-10-21 14:45:35', 'https://www.renault.com.tr/'),
('Renault', 'Symbol', '1.5 dCi 75 bg Joy', 1500, 'Dizel', 9, 'Düz', 74250, '2022-01-21 18:07:31', 'https://www.renault.com.tr/'),
('Renault', 'Talisman',	'1.6 dCi EDC 130 bg Icon', 1600, 'Dizel', 11, 'Otomatik', 161500, '2021-06-24 15:45:53', 'https://www.renault.com.tr/'),
('Renault', 'Talisman',	'1.5 dCi EDC 110 bg Touch', 1500, 'Dizel', 2, 'Otomatik', 139850, '2019-03-03 16:09:13', 'https://www.renault.com.tr/'),
('Renault', 'Talisman',	'1.6 dCi 130 bg Touch', 1600, 'Dizel', 4, 'Düz', 134900, '2022-01-18 14:24:13', 'https://www.renault.com.tr/'),

('Land Rover', 'Discovery Sport', '2.0 Td4 150 BG SE', 2000, 'Dizel', 11, 'Otomatik', 379551, '2019-10-22 16:12:31', 'http://www.landrover.com.tr/'),
('Land Rover', 'Discovery Sport', '2.0 Td4 180 BG HSE',	 2000,	'Dizel', 8, 'Otomatik', 428564, '2022-04-23 20:09:32', 'http://www.landrover.com.tr/'),
('Land Rover', 'Discovery Sport', '2.0 Td4 180 BG HSE LUXURY', 2000, 'Dizel', 9, 'Otomatik', 467775, '2018-08-21 01:51:57', 'http://www.landrover.com.tr/'),
('Land Rover', 'Range Rover', '3.0 SDV6 354 BG AUTOBIOGRAPHY', 3000, 'Hibrit', 8, 'Otomatik', 1339244, '2021-05-13 12:45:10', 'http://www.landrover.com.tr/'),
('Land Rover', 'Range Rover', '3.0 SDV6 354 BG LWB AUTOBIOGRAPHY', 3000, 'Hibrit', 6, 'Otomatik', 1430269, '2020-06-26 12:00:35', 'http://www.landrover.com.tr/'),
('Land Rover', 'Range Rover', '3.0 SDV6 354 BG VOGUE SE', 3000,	'Hibrit', 3, 'Otomatik', 1284628, '2018-01-01 19:37:01', 'http://www.landrover.com.tr/'),
('Land Rover', 'Range Rover', '3.0 TDV6 258 BG AUTOBIOGRAPHY', 3000, 'Dizel', 6, 'Otomatik', 1211808, '2019-03-22 18:56:11', 'http://www.landrover.com.tr/'),
('Land Rover', 'Range Rover', '3.0 TDV6 258 BG HSE', 3000, 'Dizel', 12, 'Otomatik', 987279, '2020-04-19 01:45:20', 'http://www.landrover.com.tr/'),
('Land Rover', 'Range Rover', '3.0 TDV6 258 BG LWB AUTOBIOGRAPHY', 3000, 'Dizel', 11, 'Otomatik', 1296765, '2021-12-10 16:58:56', 'http://www.landrover.com.tr/'),
('Land Rover', 'Range Rover', '3.0 TDV6 258 BG LWB VOGUE', 3000, 'Dizel', 7, 'Otomatik', 1199672, '2019-12-26 19:34:32', 'http://www.landrover.com.tr/'),

('Ssangyong', 'Korando Sports', '2.0 4x2 MT Full (Uzun Kasa)', 2000, 'Dizel', 11, 'Düz', 81600, '2018-04-22 12:46:39', 'http://www.ssangyong.com.tr/'),
('Ssangyong', 'Korando Sports',	'2.0 4x4 AT Full (Uzun Kasa)', 2000, 'Dizel', 13, 'Otomatik', 94000, '2021-05-12 23:30:41', 'http://www.ssangyong.com.tr/'),
('Ssangyong', 'Korando Sports', '2.0 4x4 MT Full (Uzun Kasa)', 2000, 'Dizel', 9, 'Düz', 88150, '2020-01-09 02:56:0', 'http://www.ssangyong.com.tr/'),
('Ssangyong', 'Rexton W', '2.0 4x2 AT Full', 2000, 'Dizel',	5, 'Otomatik', 171000, '2020-06-30 16:27:58', 'http://www.ssangyong.com.tr/'),
('Ssangyong', 'Rexton W', '2.0 4x2 MT Full', 2000, 'Dizel',	2, 'Düz', 160000, '2019-01-04 23:32:40', 'http://www.ssangyong.com.tr/'),
('Ssangyong', 'Rexton W', '2.0 4x4 AT Full ', 2000, 'Dizel', 9, 'Otomatik', 182000, '2018-06-25 13:42:06', 'http://www.ssangyong.com.tr/'),
('Ssangyong', 'Rodius', '2.0 4x2 AT Full', 2000, 'Dizel', 8, 'Otomatik', 169000, '2022-01-31 05:16:39', 'http://www.ssangyong.com.tr/'),
('Ssangyong', 'Tivoli',	'1.6 4x2 AT Full ', 1600, 'Benzin', 5,'Otomatik', 87075, '2018-03-24 06:04:11', 'http://www.ssangyong.com.tr/'),
('Ssangyong', 'Tivoli', '1.6 4x2 AT Full ', 1600, 'Dizel', 10, 'Otomatik', 98075, '2018-08-20 02:39:03', 'http://www.ssangyong.com.tr/'),
('Ssangyong', 'Tivoli', '1.6 4x2 MT Full ', 1600, 'Benzin', 11, 'Düz', 80675, '2020-08-23 14:54:07', 'http://www.ssangyong.com.tr/'),

('Lexus', 'IS 200t', '2.0 F Sport', 2000, 'Benzin',	8, 'Otomatik', 377702, '2019-03-12 09:19:23', 'http://www.lexus.com.tr/'),
('Lexus', 'LS 600hL', '5.0 LS600hL', 5000, 'Hibrit', 14, 'Otomatik', 1286335, '2018-04-02 07:17:08', 'http://www.lexus.com.tr/'),
('Lexus', 'LS 600hL', '5.0 LS600hL Shimamoku', 5000, 'Hibrit', 3, 'Otomatik', 1290769, '2018-04-08 10:33:34', 'http://www.lexus.com.tr/'),
('Lexus', 'NX 200t', '2.0 Business 4x2', 2000, 'Benzin', 5, 'Otomatik', 351405, '2020-06-26 20:48:15', 'http://www.lexus.com.tr/'),
('Lexus', 'NX 200t', '2.0 Business 4x4', 2000, 'Benzin', 2, 'Otomatik',357202, '2020-05-07 10:26:18', 'http://www.lexus.com.tr/'),
('Lexus', 'NX 200t', '2.0 Comfort 4x2', 2000, 'Benzin',	3, 'Otomatik',	315306,	'2020-12-02 13:59:39', 'http://www.lexus.com.tr/'),
('Lexus', 'NX 200t', '2.0 Comfort Plus 4x2', 2000, 'Benzin', 4, 'Otomatik',	344831, '2021-05-09 00:09:35', 'http://www.lexus.com.tr/'),
('Lexus', 'RC 200t', '2.0 Exclusive', 2000,	'Benzin', 12, 'Otomatik', 425315, '2020-04-09 20:18:05', 'http://www.lexus.com.tr/'),
('Lexus', 'RC 200t', '2.0 F Sport',	 2000, 'Benzin', 8, 'Otomatik', 431345, '2019-12-07 19:25:43', 'http://www.lexus.com.tr/'),
('Lexus', 'RCF', '5.0 RCF Carbon', 5000, 'Benzin', 7, 'Otomatik', 835873, '2021-02-09 18:05:32', 'http://www.lexus.com.tr/'),

('Opel', 'Adam', '1.4 lt. NEH TURBO 150 HP - MT6 Adam S', 1400, 'Benzin', 4, 'Düz', 79200, '2018-01-28 04:13:30', 'http://www.opel.com.tr/'),
('Opel', 'Astra HB', '1.6 Benzinli 200 HP AT6 S&S OPC Line Sport', 1600, 'Benzin', 8, 'Otomatik', 107300, '2020-07-25 17:23:31', 'http://www.opel.com.tr/'),
('Opel', 'Astra Sedan', '1.4 Benzinli 140 HP AT Design', 1400, 'Benzin', 4, 'Otomatik', 87050, '2020-01-02 00:34:08', 'http://www.opel.com.tr/'),
('Opel', 'Astra Sports Tourer', '1.4 Benzinli 150 HP AT6 S&S Dynamic', 1400, 'Benzin', 7, 'Otomatik', 99100, '2020-05-06 17:05:28', 'http://www.opel.com.tr/'),
('Opel', 'Cascada', '1.6 XHT 170 HP AT6 Cosmo', 1600, 'Benzin',	8, 'Otomatik', 169600, '2018-12-29 05:28:27', 'http://www.opel.com.tr/'),
('Opel', 'Corsa 5 Kapı', '1.3 CDTI 75HP Design', 1300, 'Dizel',	14, 'Düz', 75300, '2019-09-11 10:26:48', 'http://www.opel.com.tr/'),
('Opel', 'Insignia Country Tourer', '1.6 Dizel 136HP AT6 Cosmo', 1600, 'Dizel',	13, 'Otomatik', 154900, '2019-04-07 12:30:23', 'http://www.opel.com.tr/'),
('Opel', 'Insignia Sedan', '1.6 Dizel 136HP AT6 Sport', 1600, 'Dizel', 8, 'Otomatik', 143100, '2019-10-18 15:46:36', 'http://www.opel.com.tr/'),
('Opel', 'Mokka X', '1.4 140 AT FWD Design - Benzinli Design', 1400, 'Benzin', 7, 'Otomatik', 97200, '2018-01-11 09:49:36', 'http://www.opel.com.tr/'),
('Opel', 'Insignia Sports Tourer', '1.6 Dizel 136HP AT6 Cosmo', 1600, 'Dizel', 2, 'Otomatik', 145400, '2020-06-10 12:20:24', 'http://www.opel.com.tr/'),

('Fiat', 'Doblo Panorama', '1.6 M.Jet 105 HP Easy', 1600, 'Dizel', 8, 'Düz', 81900, '2021-09-02 16:38:15', 'http://www.fiat.com.tr/'),
('Fiat', 'Doblo Panorama', '1.6 M.Jet 105 HP Easy Maxi', 1600, 'Dizel',	10, 'Düz', 84400, '2021-10-31 19:56:54', 'http://www.fiat.com.tr/'),
('Fiat', 'Doblo Panorama', '1.6 M.Jet 105 HP Premio Plus (Gri / Black)', 1600, 'Dizel',	7, 'Düz', 90400, '2021-05-23 06:36:10', 'http://www.fiat.com.tr/'),
('Fiat', 'Doblo Panorama', '1.6 M.Jet 105 HP Safeline', 1600, 'Dizel', 10, 'Düz', 84400, '2021-12-19 17:51:48', 'http://www.fiat.com.tr/'),
('Fiat', 'Doblo Panorama', '1.6 M.Jet 90 HP Conformatic Premio Plus (Gri / Black)', 1600, 'Dizel',14, 'Otomatik', 94400, '2018-09-09 16:55:47', 'http://www.fiat.com.tr/'),
('Fiat', 'Egea Hatchback', '1.3 M.Jet 95 HP Easy Plus', 1300, 'Dizel', 7,'Düz', 76900, '2020-05-08 22:55:28', 'http://www.fiat.com.tr/'),
('Fiat', 'Egea Hatchback', '1.3 M.Jet 95 HP Urban Plus', 1300, 'Dizel', 3, 'Düz', 82900, '2018-11-18 22:35:20', 'http://www.fiat.com.tr/'),
('Fiat', 'Egea Hatchback', '1.4 Fire 95 HP Easy Plus', 1400, 'Benzin', 13,'Düz', 60900, '2021-05-07 21:18:53', 'http://www.fiat.com.tr/'),
('Fiat', 'Egea Hatchback', '1.4 Fire 95 HP Lounge Plus', 1400, 'Benzin', 8, 'Düz', 74400, '2019-03-20 06:20:10', 'http://www.fiat.com.tr/'),
('Fiat', 'Egea Hatchback', '1.4 Fire 95 HP Urban Plus', 1400, 'Benzin',11, 'Düz', 66900, '2021-07-26 02:53:28', 'http://www.fiat.com.tr/'),

('Mercedes', 'C 180', '1.6 156BG Style', 1600, 'Benzin', 15, 'Otomatik', 172600, '2020-05-17 12:37:36', 'http://www.mercedes-benz.com.tr/'),
('Mercedes', 'C 180 Coupe', '1.6 156BG AMG', 1600, 'Benzin', 11, 'Otomatik', 240100, '2020-12-16 10:52:00', 'http://www.mercedes-benz.com.tr/'),
('Mercedes', 'C 180 Estate', '1.6 156BG Style', 1600, 'Benzin', 9, 'Otomatik', 176800, '2021-04-17 23:51:36', 'http://www.mercedes-benz.com.tr/'),
('Mercedes', 'C 200', '1.6 136BG Avantgarde', 1600,	'Dizel', 15, 'Otomatik', 218500, '2020-12-09 23:06:37', 'http://www.mercedes-benz.com.tr/'),
('Mercedes', 'C 63 S AMG', '4.0 510BG Performance',	4000, 'Benzin',	1, 'Otomatik', 704300, '2020-01-16 02:43:52', 'http://www.mercedes-benz.com.tr/'),
('Mercedes', 'E 220', '2.0 194BG Exclusive 4MATIC',	2000, 'Dizel', 11, 'Otomatik', 420000, '2021-05-12 03:15:30', 'http://www.mercedes-benz.com.tr/'),
('Mercedes', 'GLE 350', '3.0 258BG AMG 4MATIC',	3000, 'Dizel', 12, 'Otomatik', 643800, '2020-11-04 12:37:41', 'http://www.mercedes-benz.com.tr/'),
('Mercedes', 'S 300 Long', '2.2 231BG Vizyon',	2200, 'Dizel', 10, 'Otomatik', 930200, '2021-10-27 02:57:42', 'http://www.mercedes-benz.com.tr/'),
('Mercedes', 'S 63 AMG Cabriolet', '5.5 585BG Performance 4MATIC', 5500, 'Benzin', 1, 'Otomatik', 1833700, '2022-04-10 21:31:13', 'http://www.mercedes-benz.com.tr/'),
('Mercedes', 'SLC 43 AMG', '3.0 367BG Performance',	3000, 'Benzin',	6, 'Otomatik', 556800, '2018-02-04 12:16:03', 'http://www.mercedes-benz.com.tr/'),

('Mini', 'Mini Cooper 3 Kapı', '1.5 136 BG Chili', 1500, 'Benzin', 1, 'Otomatik', 140158, '2022-04-10 21:31:13', 'https://www.mini.com.tr/'),
('Mini', 'Mini Cooper 3 Kapı', '1.5 136 BG Pepper', 1500, 'Benzin', 8, 'Otomatik', 115130, '2021-05-07 15:10:15', 'https://www.mini.com.tr/'),
('Mini', 'Mini Cooper 3 Kapı', '1.5 136 BG Türkiye Paketi', 1500, 'Benzin', 15, 'Otomatik', 102563, '2022-02-17 14:00:04', 'https://www.mini.com.tr/'),
('Mini', 'Mini Cooper 3 Kapı D', '1.5 116 BG Chili', 1500,	'Dizel', 14, 'Otomatik', 147531, '2020-10-07 10:22:21', 'https://www.mini.com.tr/'),
('Mini', 'Mini Cooper 3 Kapı D', '1.5 116 BG Pepper', 1500,	'Dizel', 1, 'Otomatik',	122042, '2021-09-18 01:03:45', 'https://www.mini.com.tr/'),
('Mini', 'Mini Cooper 3 Kapı D', '1.5 116 BG Türkiye Paketi', 1500,	'Dizel', 5, 'Otomatik', 109475, '2018-04-11 20:13:09', 'https://www.mini.com.tr/'),
('Mini', 'Mini Cooper 5 Kapı', '1.5 136 BG Chili', 1500, 'Benzin', 6, 'Otomatik', 145184, '2022-02-19 17:16:34', 'https://www.mini.com.tr/'),
('Mini', 'Mini Cooper 5 Kapı', '1.5 136 BG Pepper', 1500, 'Benzin',	8, 'Otomatik', 119841, '2021-11-18 04:04:36', 'https://www.mini.com.tr/'),
('Mini', 'Mini Cooper 5 Kapı', '1.5 136 BG Türkiye Paketi', 1500, 'Benzin',	2, 'Otomatik', 107274, '2018-09-28 01:08:35', 'https://www.mini.com.tr/'),
('Mini', 'Mini Cooper 5 Kapı D', '1.5 116 BG Chili', 1500, 'Dizel',	14, 'Otomatik', 152558, '2018-03-23 18:37:53', 'https://www.mini.com.tr/'),

('Mitsubishi', 'ASX', '1.6 MT INTENSE', 1600, 'Benzin',	10, 'Düz', 106596, '2022-01-10 18:45:04', 'https://www.mitsubishi-motors.com.tr/'),
('Mitsubishi', 'ASX', '1.6 MT INTENSE(Dizel)', 1600, 'Dizel', 2, 'Düz', 124808, '2020-01-30 21:02:25', 'https://www.mitsubishi-motors.com.tr/'),
('Mitsubishi', 'ASX', '1.6 MT INVITE', 1600, 'Benzin', 1, 'Düz', 96314, '2020-06-24 04:25:07', 'https://www.mitsubishi-motors.com.tr/'),
('Mitsubishi', 'Attrage', '1.2 CVT INTENSE(NAVİGASYONLU)', 1200, 'Benzin', 15, 'Otomatik', 61283, '2019-07-02 11:04:27', 'https://www.mitsubishi-motors.com.tr/'),
('Mitsubishi', 'Attrage', '1.2 MT INTENSE(NAVİGASYONLU)', 1200, 'Benzin', 5, 'Düz', 57367, '2021-04-09 17:53:41', 'https://www.mitsubishi-motors.com.tr/'),
('Mitsubishi', 'L200', '2.4L 4X2 AT STORM', 2400, 'Dizel', 11, 'Otomatik', 100968, '2021-07-01 14:13:44', 'https://www.mitsubishi-motors.com.tr/'),
('Mitsubishi', 'L200', '2.4L 4x2 MT STORM', 2400, 'Dizel', 14, 'Düz', 95178, '2019-12-26 20:10:26', 'https://www.mitsubishi-motors.com.tr/'),
('Mitsubishi', 'L200', '2.4L 4X4 AT BLIZZARD', 2400, 'Dizel', 4, 'Otomatik', 132377, '2019-03-18 18:21:38', 'https://www.mitsubishi-motors.com.tr/'),
('Mitsubishi', 'L200', '2.4L 4X4 AT TORNADO', 2400, 'Dizel', 3, 'Otomatik', 117271, '2021-11-02 20:34:03', 'https://www.mitsubishi-motors.com.tr/'),
('Mitsubishi', 'L200', '2.4L 4X4 MT STORM',	2400, 'Dizel', 8, 'Düz', 106817, '2018-08-18 14:36:30', 'https://www.mitsubishi-motors.com.tr/'),

('Bmw', '116d', '1.5 116BG Joy', 1500, 'Dizel', 4, 'Otomatik', 166100, '2020-02-18 19:57:42', 'http://www.bmw.com.tr/'),
('Bmw', '116d',	'1.5 116BG Joy Plus', 1500,	'Dizel', 8, 'Otomatik',	169700,	'2022-09-24 15:59:01', 'http://www.bmw.com.tr/'),
('Bmw',	'116d',	'1.5 116BG M Plus',	1500, 'Dizel', 2, 'Otomatik', 180400, '2020-01-01 01:14:30', 'http://www.bmw.com.tr/'),
('Bmw',	'116d',	'1.5 116BG Pure', 1500, 'Dizel', 8, 'Otomatik',	155300,	'2021-11-08 01:39:43', 'http://www.bmw.com.tr/'),
('Bmw',	'118i',	'1.5 136BG Joy', 1500, 'Benzin', 12, 'Otomatik', 155300, '2021-12-07 22:49:34', 'http://www.bmw.com.tr/'),
('Bmw', '118i', '1.5 136BG Joy Plus', 1500, 'Benzin', 6, 'Otomatik', 158900, '2020-08-01 12:12:33', 'http://www.bmw.com.tr/'),
('Bmw',	'118i',	'1.5 136BG M Plus',	1500, 'Benzin',	13, 'Otomatik',	169700,	'2022-05-12 12:23:05','http://www.bmw.com.tr/'),
('Bmw',	'118i',	'1.5 136BG Pure', 1500,	'Benzin', 10, 'Otomatik', 144600, '2021-06-18 15:51:30', 'http://www.bmw.com.tr/'),
('Bmw',	'216d Active Tourer', '1.5 116BG Joy', 1500, 'Dizel', 1, 'Otomatik', 175100, '2021-12-05 13:12:34', 'http://www.bmw.com.tr/'),
('Bmw',	'216d Active Tourer', '1.5 116BG Luxury Line', 1500, 'Dizel', 4, 'Otomatik', 190800, '2020-12-20 22:25:15', 'http://www.bmw.com.tr/'),

('Subaru', 'BRZ', '2.0R Premium 6 AT', 2000, 'Benzin', 2, 'Otomatik', 196990, '2020-10-07 22:38:19', 'http://www.subaru.com.tr/'),
('Subaru', 'BRZ', '2.0R Premium 6 MT', 2000, 'Benzin', 5, 'Düz',  188990, '2018-09-28 23:51:25', 'http://www.subaru.com.tr/'),
('Subaru', 'Forester', '2.0D Elegance Dizel', 2000,	'Dizel', 3, 'Otomatik', 188990, '2018-12-31 18:07:50', 'http://www.subaru.com.tr/'),
('Subaru', 'Forester', '2.0D Premium Dizel', 2000,'Dizel', 9, 'Otomatik', 198990, '2018-05-04 04:30:34', 'http://www.subaru.com.tr/'),
('Subaru', 'Forester', '2.0D Sport Dizel', 2000, 'Dizel', 4, 'Otomatik', 208990, '2020-03-31 06:47:04', 'http://www.subaru.com.tr/'),
('Subaru', 'Forester', '2.0i Elegance Benzinli', 2000, 'Benzin', 8, 'Otomatik', 159900, '2021-01-07 17:18:48', 'http://www.subaru.com.tr/'),
('Subaru', 'Forester', '2.0i Premium Benzinli', 2000, 'Benzin', 13, 'Otomatik', 173990, '2020-09-21 19:57:44', 'http://www.subaru.com.tr/'),
('Subaru', 'Forester', '2.0XT Adventure Turbo Benzinli', 2000, 'Benzin', 2, 'Otomatik', 201990, '2018-06-16 16:23:56', 'http://www.subaru.com.tr/'),
('Subaru', 'Levorg', '1.6i GT-S Sport Plus Eyesight', 1600, 'Benzin', 15, 'Otomatik', 159990, '2020-09-05 03:46:25', 'http://www.subaru.com.tr/'),
('Subaru', 'Outback', '2.0D Limited Dizel EyeSight', 2000, 'Dizel',	7, 'Otomatik', 259490, '2019-10-20 22:18:15', 'http://www.subaru.com.tr/'),

('Peugeot', '301', '1.2 PureTech 82hp Euro6 ACCESS', 1200, 'Benzin', 6, 'Düz', 58900, '2019-03-23 08:40:33', 'http://www.peugeot.com.tr/'),
('Peugeot', '301', '1.2 PureTech 82hp Euro6 ACTIVE', 1200, 'Benzin', 1, 'Düz', 61900, '2019-12-04 18:55:37', 'http://www.peugeot.com.tr/'),
('Peugeot', '301', '1.6 HDi 92hp ACCESS', 1600, 'Dizel', 10, 'Düz', 68900, '2021-04-07 05:34:03', 'http://www.peugeot.com.tr/'),
('Peugeot', '301', '1.6 HDi 92hp ACTIVE', 1600, 'Dizel', 6, 'Düz', 71900, '2021-12-22 06:51:50', 'http://www.peugeot.com.tr/'),
('Peugeot', '301', '1.6 HDi 92hp ALLURE', 1600, 'Dizel', 9, 'Düz', 74900, '2021-05-10 23:52:36', 'http://www.peugeot.com.tr/'),
('Peugeot', '308', '1.2 PureTech 130hp ACTIVE', 1200, 'Benzin', 12, 'Düz', 94900, '2021-06-26 01:09:31', 'http://www.peugeot.com.tr/'),
('Peugeot', '308', '1.2 PureTech 130hp ALLURE', 1200, 'Benzin', 10, 'Düz', 102900, '2020-08-30 12:07:20', 'http://www.peugeot.com.tr/'),
('Peugeot', '308', '1.2 PureTech 130hp EAT6 Tam Otomatik S&S ACTIVE', 1200, 'Benzin', 9, 'Otomatik', 100900, '2021-09-07 12:41:16', 'http://www.peugeot.com.tr/'),
('Peugeot', '308', '1.2 PureTech 130hp EAT6 Tam Otomatik S&S ALLURE', 1200, 'Benzin', 1, 'Otomatik', 108900, '2021-01-28 15:13:29', 'http://www.peugeot.com.tr/'),
('Peugeot', '308', '1.2 PureTech 82hp ACCESS', 1200, 'Benzin', 5, 'Düz', 85900, '2020-05-06 06:37:51', 'http://www.peugeot.com.tr/'),

('Seat', 'Alhambra', '1.4 TSI 150 HP DSG S&S Style', 1400, 'Benzin', 2, 'Otomatik', 159000, '2019-07-24 05:59:02', 'http://seat.com.tr/'),
('Seat', 'Ateca', '1.4 EcoTSI ACT 150 hp 4Drive DSG S&S Xcellence', 1400, 'Benzin',	8, 'Otomatik', 152300, '2021-07-17 20:21:02', 'http://seat.com.tr/'),
('Seat', 'Ibiza', '1.2 TSI 90 HP Reference','1200', 'Benzin', 3, 'Düz', 50400, '2018-11-05 23:11:52', 'http://seat.com.tr/'),
('Seat', 'Leon', '1.0 EcoTSI 115 HP DSG S&S Ecomotive Style', 1000, 'Benzin', 9, 'Otomatik', 80400, '2018-04-08 01:47:29', 'http://seat.com.tr/'),
('Seat', 'Leon', '1.6 TDI 115 HP S&S Style', 1600, 'Dizel',	8, 'Düz', 89900, '2019-10-23 09:11:23', 'http://seat.com.tr/'),
('Seat', 'Leon', '2.0 TSI 300 HP DSG S&S CUPRA', 2000, 'Benzin', 13,'Otomatik', 197000, '2021-07-03 21:08:19', 'http://seat.com.tr/'),
('Seat', 'Toledo', '1.2 TSI 110 HP S&S Style',	1200, 'Benzin', 6, 'Düz', 75900, '2020-01-31 14:14:36', 'http://seat.com.tr/'),
('Seat', 'Toledo', '1.4 TDI 90 HP DSG S&S Style', 1400 , 'Dizel', 3, 'Otomatik', 98500, '2020-08-21 18:17:34', 'http://seat.com.tr/'),
('Seat', 'Toledo', '1.4 TDI 90 HP S&S Style', 1400, 'Dizel', 15, 'Düz', 90300, '2019-09-21 14:26:26', 'http://seat.com.tr/'),
('Seat', 'Toledo', '1.4 TSI 125 HP DSG S&S Style', 1400, 'Benzin', 12, 'Otomatik', 84800, '2019-05-20 16:49:10', 'http://seat.com.tr/'),

('Kia', 'Cerato', '1.6L 136 PS CONCEPT TECHNO PAKET', 1600, 'Dizel', 13, 'Otomatik', 99900, '2020-01-23 21:39:57', 'http://kia.com.tr/'),
('Kia', 'Picanto', '1.25 84 PS COMFORT', 1200, 'Benzin', 9, 'Otomatik', 63500, '2019-10-01 01:28:29', 'http://kia.com.tr/'),
('Kia', 'Rio Hatchback', '1.25 85 PS COMFORT', 1200, 'Benzin', 15, 'Düz', 57900, '2021-12-19 13:02:23', 'http://kia.com.tr/'),
('Kia', 'Rio Hatchback', '1.25 85 PS CONCEPT', 1200, 'Benzin', 7, 'Düz', 61200, '2019-02-17 10:15:29', 'http://kia.com.tr/'),
('Kia', 'Rio Hatchback', '1.4 100 PS COMFORT', 1400, 'Benzin', 15, 'Otomatik', 65600, '2020-02-28 12:59:18', 'http://kia.com.tr/'),
('Kia', 'Rio Hatchback', '1.4 100 PS CONCEPT', 1400, 'Benzin', 14, 'Otomatik', 69200, '2020-03-30 19:09:28', 'http://kia.com.tr/'),
('Kia', 'Rio Hatchback', '1.4 90 PS COMFORT', 1400, 'Dizel', 12, 'Düz', 69200, '2018-11-28 06:37:54', 'http://kia.com.tr/'),
('Kia', 'Rio Hatchback', '1.4 90 PS CONCEPT', 1400, 'Dizel', 10, 'Düz', 76700, '2020-09-15 02:30:56', 'http://kia.com.tr/'),
('Kia', 'Rio Hatchback', '1.4 90 PS CONCEPT PLUS', 1400, 'Dizel', 12, 'Düz', 81900, '2021-07-09 01:44:52', 'http://kia.com.tr/'),
('Kia', 'Rio Sedan',	'1.4 109 PS COMFORT', 1400,	'Benzin', 4, 'Düz', 63500, '2019-02-16 07:16:30', 'http://kia.com.tr/'),

('Skoda', 'Fabia', '1.0 75 PS Green Tec Ambition', 1000, 'Benzin', 2, 'Düz', 47900, '2020-07-30 09:28:28', 'http://www.skoda.com.tr/'),
('Skoda', 'Octavia', '1.0 TSI 115 PS Green Tec Ambition', 1000, 'Benzin', 4, 'Düz', 69300, '2020-10-31 01:29:09', 'http://www.skoda.com.tr/'),
('Skoda', 'Octavia Combi', '1.6 TDI CR 110 PS DSG Green Tec Style', 1600, 'Dizel',	3,'Otomatik', 111400, '2021-11-27 11:48:16', 'http://www.skoda.com.tr/'),
('Skoda', 'Rapid', '1.2 TSI 90 PS Green Tec  Ambition',	1200, 'Benzin', 12, 'Düz', 63900, '2019-04-27 03:28:49', 'http://www.skoda.com.tr/'),
('Skoda', 'Rapid Spaceback', '1.2 TSI 110 PS Green Tec  Style', 1200, 'Benzin',	13, 'Düz', 68400, '2019-02-28 18:21:26', 'http://www.skoda.com.tr/'),
('Skoda', 'Superb',	'1.4 TSI 125 PS Green Tec Active',	1400, 'Benzin', 1, 'Düz', 87900, '2021-06-30 16:27:26', 'http://www.skoda.com.tr/'),
('Skoda', 'Superb',	'1.6 TDI CR 120 PS Green Tec Style', 1600, 'Dizel',	10, 'Düz', 116400, '2018-03-30 10:25:16', 'http://www.skoda.com.tr/'),
('Skoda', 'Superb',	'2.0 TDI CR SCR 190 PS 4x4 DSG Green Tec L&K',	2000, 'Dizel', 12, 'Otomatik', 214900, '2020-06-07 21:30:15', 'http://www.skoda.com.tr/'),
('Skoda', 'Superb',	'2.0 TDI CR SCR 190 PS 4X4 DSG Green Tec Prestige', 2000, 'Dizel', 6, 'Otomatik', 208900, '2020-05-15 00:16:26', 'http://www.skoda.com.tr/'),
('Skoda', 'Yeti', '1.2 TSI 110 PS Green Tec Active', 1200, 'Benzin', 2, 'Düz', 68600, '2021-07-09 01:37:23', 'http://www.skoda.com.tr/'),

('Volvo', 'S60', '2.0L 190HP D4 Advance', 2000, 'Dizel', 2, 'Otomatik', 221420, '2020-07-16 11:50:46', 'http://www.volvocars.com.tr'),
('Volvo', 'S90', '2.0L 235HP D5 AWD Momentum', 2000, 'Dizel', 15, 'Otomatik', 384530, '2020-12-06 17:51:38', 'http://www.volvocars.com.tr'),
('Volvo', 'V40', '1.5L 152HP T3 Momentum', 1500, 'Benzin', 3, 'Otomatik', 133660, '2018-10-15 23:54:02', 'http://www.volvocars.com.tr'),
('Volvo', 'V40', '1.5L 152HP T3 Momentum', 1500, 'Benzin', 14, 'Otomatik', 133660, '2020-12-28 11:50:35', 'http://www.volvocars.com.tr'),
('Volvo', 'XC60','2.0L 190HP D4 Advance', 2000, 'Dizel', 10, 'Otomatik', 285840, '2018-03-17 22:29:10', 'http://www.volvocars.com.tr'),
('Volvo', 'V60 Cross Country', '2.0L 190HP D4 Advance', 2000, 'Dizel', 13, 'Otomatik', 261840, '2021-11-29 02:37:24', 'http://www.volvocars.com.tr'),
('Volvo', 'XC90', '2.0L 235HP D5 AWD 7-koltuk Inscription', 2000, 'Dizel', 3, 'Otomatik', 508080, '2019-07-03 06:14:17', 'http://www.volvocars.com.tr'),
('Volvo', 'XC90', '2.0L 320+87HP T8 Twin Engine AWD 7-koltuk Inscription', 2000, 'Hibrit', 9, 'Otomatik', 643030, '2018-08-14 12:20:09', 'http://www.volvocars.com.tr'),
('Volvo', 'XC90', '2.0L 320+87HP T8 Twin Engine AWD 7-koltuk Momentum', 2000, 'Hibrit', 13, 'Otomatik', 614890, '2018-11-30 21:35:51', 'http://www.volvocars.com.tr'),
('Volvo', 'XC90', '2.0L 320+87HP T8 Twin Engine AWD 7-koltuk R-Design', 2000, 'Hibrit', 7, 'Otomatik', 648400, '2018-06-14 15:11:16', 'http://www.volvocars.com.tr'),

('Suzuki', 'Baleno', '1.2 GL MT 90 HP',  1200, 'Benzin', 3, 'Düz', 55950, '2021-04-07 22:06:58', 'http://www.suzuki.com.tr/'),
('Suzuki', 'Jimny', '1.3 JLX Benzinli 4x4 AT 85 HP', 1300, 'Benzin', 8, 'Otomatik', 66500, '2021-01-09 12:34:06', 'http://www.suzuki.com.tr/'),
('Suzuki', 'Jimny', '1.3 Style Benzinli 4x4 AT 85 HP', 1300, 'Benzin', 4, 'Otomatik', 68900, '2020-06-02 23:12:10', 'http://www.suzuki.com.tr/'),
('Suzuki', 'Swift', '1.2 GL AT 94 HP', 1200, 'Benzin', 6, 'Otomatik', 54950, '2020-05-08 13:01:01', 'http://www.suzuki.com.tr/'),
('Suzuki', 'Swift', '1.2 GL MT 94 HP', 1200, 'Benzin', 13, 'Düz', 51950, '2022-02-09 18:31:12', 'http://www.suzuki.com.tr/'),
('Suzuki', 'Vitara', '1.4 S Benzinli 4X2 AT (Çift Renk) 140 HP', 1400, 'Benzin', 1, 'Otomatik', 103400, '2021-07-03 14:16:07', 'http://www.suzuki.com.tr/'),
('Suzuki', 'Vitara', '1.4 S Benzinli 4X2 AT (Tek Renk) 140 HP', 1400, 'Benzin', 12, 'Otomatik',	101900, '2018-07-02 12:24:46', 'http://www.suzuki.com.tr/'),
('Suzuki', 'Vitara', '1.4 S Benzinli 4X4 AT (Çift Renk) 140 HP', 1400, 'Benzin', 10, 'Otomatik', 110650, '2021-11-28 01:48:22', 'http://www.suzuki.com.tr/'),
('Suzuki', 'Vitara', '1.4 S Benzinli 4X4 AT (Tek Renk) 140 HP',	 1400, 'Benzin', 13, 'Otomatik', 109150, '2018-02-08 20:59:38', 'http://www.suzuki.com.tr/'),
('Suzuki', 'Vitara', '1.6 GL+ Benzinli 4x2 AT (Çift Renk) 120 HP', 1600, 'Benzin', 5, 'Otomatik', 89000, '2020-08-21 11:04:51', 'http://www.suzuki.com.tr/'),

('Mazda', 'CX-3', '1.5 SKY-D Motion', 1500,	'Dizel', 10, 'Düz',	99478, '2021-07-05 21:42:12', 'http://www.mazda.com.tr/'),
('Mazda', 'CX-3', '1.5 SKY-D Reflex', 1500,	'Dizel', 11, 'Düz', 105694, '2020-05-07 20:20:24', 'http://www.mazda.com.tr/'),
('Mazda', 'CX-5', '2.0 SKY-G 4x4 AT Power',	2000, 'Benzin', 4, 'Otomatik', 179101, '2019-07-27 08:05:54', 'http://www.mazda.com.tr/'),
('Mazda', 'CX-5', '2.0 SKY-G 4x4 AT Power Beyaz Deri', 2000, 'Benzin', 15, 'Otomatik', 179686, '2022-03-03 08:27:10', 'http://www.mazda.com.tr/'),
('Mazda', 'Mazda3 Hatchback', '1.5 SKY-D AT Motion' , 1500, 'Dizel', 5, 'Otomatik', 112716, '2018-08-07 09:58:18', 'http://www.mazda.com.tr/'),
('Mazda', 'Mazda3 Hatchback', '1.5 SKY-D AT Power', 1500, 'Dizel', 14, 'Otomatik', 133309, '2021-08-21 22:07:19', 'http://www.mazda.com.tr/'),
('Mazda', 'Mazda3 Hatchback', '1.5 SKY-D AT Power Beyaz Deri', 1500, 'Dizel', 4, 'Otomatik', 138835, '2019-01-24 02:12:35', 'http://www.mazda.com.tr/'),
('Mazda', 'Mazda3 Sedan', '1.5 SKY-D AT Motion', 1500, 'Dizel', 14, 'Otomatik', 112716, '2020-04-01 03:35:35', 'http://www.mazda.com.tr/'),
('Mazda', 'Mazda3 Sedan', '1.5 SKY-D AT Power',	1500, 'Dizel', 12, 'Otomatik', 133309, '2018-11-20 03:18:46', 'http://www.mazda.com.tr/'),
('Mazda', 'Mazda3 Sedan', '1.5 SKY-D AT Power Beyaz Deri', 1500, 'Dizel', 2, 'Otomatik', 138835, '2019-02-17 19:05:18', 'http://www.mazda.com.tr/'),

('Volkswagen', 'Beetle', '1.2 TSI BMT 105 PS DSG Style', 1200, 'Benzin', 10, 'Otomatik', 103881, '2021-10-15 11:57:45', 'http://binekarac.vw.com.tr/'),
('Volkswagen', 'CC', '1.4 TSI BMT 150 PS DSG Sportline', 1400, 'Benzin', 7, 'Otomatik', 147488, '2018-12-24 05:39:26', 'http://binekarac.vw.com.tr/'),
('Volkswagen', 'Golf', '1.2 TSI BMT 110 PS DSG Midline Plus', 1200, 'Benzin', 10, 'Otomatik', 95300, '2019-04-01 09:57:08', 'http://binekarac.vw.com.tr/'),
('Volkswagen', 'Jetta', '1.2 TSI BMT 105 PS DSG Comfortline', 1200, 'Benzin', 2, 'Otomatik', 96800, '2022-05-01 02:11:46', 'http://binekarac.vw.com.tr/'),
('Volkswagen', 'Passat', '2.0 TDI BMT 150 PS DSG Comfortline', 2000, 'Dizel', 1, 'Otomatik', 188000, '2020-02-16 04:49:57', 'http://binekarac.vw.com.tr/'),
('Volkswagen', 'Passat Variant', '1.4 TSI BMT 125 PS DSG Highline', 1400, 'Benzin', 6, 'Otomatik', 158900, '2021-09-22 08:44:40', 'http://binekarac.vw.com.tr/'),
('Volkswagen', 'Polo', '1.0 75 PS Manuel Trendline', 1000,	'Benzin', 3, 'Düz', 53200, '2021-06-25 02:37:01', 'http://binekarac.vw.com.tr/'),
('Volkswagen', 'Scirocco', '1.4 TSI BMT 125 PS Manuel Sportline', 1400, 'Benzin', 1, 'Düz', 111035, '2021-03-04 11:27:52', 'http://binekarac.vw.com.tr/'),
('Volkswagen', 'Tiguan', '1.4 TSI BMT 125 PS Manuel Trendline', 1400, 'Benzin', 7, 'Düz', 108084, '2018-06-11 00:43:42', 'http://binekarac.vw.com.tr/'),
('Volkswagen', 'Touareg', '3.0 V6 BMT TDI SCR 262 PS Premium', 3000, 'Dizel', 5, 'Otomatik', 505159, '2021-03-03 19:06:05', 'http://binekarac.vw.com.tr/'),

('Dacia', 'Duster',	'1.5 dCi 110 bg Ambiance 4x4', 1500, 'Dizel', 7, 'Düz', 76550, '2018-10-03 23:17:18', 'https://www.dacia.com.tr/'),
('Dacia', 'Duster',	'1.5 dCi 110 bg EDC Blackshadow', 1500, 'Dizel', 5, 'Otomatik',	85400, '2019-04-20 04:37:51', 'https://www.dacia.com.tr/'),
('Dacia', 'Duster',	'1.5 dCi 110 bg EDC Laureate 4x2', 1500, 'Dizel', 6, 'Otomatik', 82900, '2020-10-01 15:09:25', 'https://www.dacia.com.tr/'),
('Dacia', 'Duster',	'1.5 dCi 110 bg Laureate 4x2', 1500, 'Dizel', 14, 'Düz', 75900, '2020-01-25 05:28:01', 'https://www.dacia.com.tr/'),
('Dacia', 'Duster',	'1.5 dCi 110 bg Laureate 4x4', 1500, 'Dizel', 2, 'Düz', 79750, '2020-07-27 21:57:27', 'https://www.dacia.com.tr/'),
('Dacia', 'Duster',	'1.5 dCi 90 bg Ambiance 4x2', 1500,	'Dizel', 10, 'Düz',	69450, '2021-07-24 07:17:34', 'https://www.dacia.com.tr/'),
('Dacia', 'Duster',	'1.5 dCi 90 bg Laureate 4x2', 1500,	'Dizel', 8, 'Düz', 75200, '2022-01-11 17:34:41', 'https://www.dacia.com.tr/'),
('Dacia', 'Duster',	'1.6 16V 115 bg Ambiance 4x2', 1600, 'Benzin', 15, 'Düz', 60800, '2021-04-29 17:09:16', 'https://www.dacia.com.tr/'),
('Dacia', 'Lodgy', '1.5 dCi 110 bg Stepway - 5 koltuklu', 1500, 'Dizel', 14, 'Düz',	73250, '2021-07-02 00:44:23', 'https://www.dacia.com.tr/'),
('Dacia', 'Lodgy', '1.5 dCi 110 bg Stepway - 7 koltuklu', 1500,	'Dizel', 9, 'Düz',	75950, '2022-03-14 13:53:46', 'https://www.dacia.com.tr/')

select * from CAR_PRICES

--COUNT FONKSİYONU-------------------------------------------------------------------
--count(*) bu fonksiyon null degerleride goz onune alarak tum kayıtların sayısını getirir yani bizim 309 kayıtlı arabamiz varmıs
select count(*) from CAR_PRICES

--count(sutun_adi) bu tarzda kullanılırsa belirtilen sutunda null degerleri icermeyen tum kayıtların sayısını bulur
--sutun adı vererekte kac kayıt oldugunu bulabiliriz
select count(brand) from CAR_PRICES

--MIN FONKSİYONU---------------------------------------------------------------------
--herhangi bir sutun icerigi degerinin en kucuk olanını bulmak icin kullanilir.sayısal sutunlarda kullanılır

--motor en dusuk olan yani en gucsuz olanı bulur
select min(engine) from CAR_PRICES

--MAX FONKSİYONU-----------------------------------------------------------------------	
--herhangi bir sutun icerigi degerinin en buyuk olanını bulmak icin kullanilir.sayısal sutunlarda kullanılır

--motor en buyuk olan yani en guclu olanı bulur
select max(engine) from CAR_PRICES

--mercedes turunde ki en pahalı aracı bulmaya yarar
select max(price), brand from CAR_PRICES where brand = 'mercedes' group by brand

--AVG FONKSİYONU----------------------------------------------------------------------
--herhangi bir sutunun sayısal degerlerinin aritmetik ortalamasını bulmak icin kullanılır

--arabalarin satıs fıyatlarının ortalaması
select avg(price) from CAR_PRICES

--fiat araclarının ortalama satıs fiyatini veren sorgu
select avg(price) from CAR_PRICES where brand = 'fiat'


--SUM FONKSİYONU------------------------------------------------------------------
--herhangi bir sutunun sayısal degerlerinin toplamını verir

--tum aracların toplam fıyatını verir
select sum(price) from CAR_PRICES 

--mazda araclarının toplam fiyati
select sum(price) from CAR_PRICES where brand = 'mazda'


--RAND() FONKSİYONU-----------------------------------------------------------
--random sayı uretmek icin kullanılır
select RAND()
--0 ile 1 arasında sayıları uretir

select rand()*10
-- 0 ile 10 arasındaki sayıları uretir

select rand()*(10-5)+5
-- 5 ile 10 arasında ki sayıları uretir. number>= 5 ile number <10

select floor(rand()*10)
-- 0 ile 10 arasında tam sayılar uretir
--floor alta yuvarlar yani sonuc 10.6 ise 10'a yuvarlar
-- birde uste yuvarlama var o da ceiling fonksiyonlar bolumunde bulabilirsin

select cast(rand()*10 as int)
-- 0 ile 10 arasında tam sayılar uretir

select convert(int, rand()*10)
-- 0 ile 10 arasında tam sayılar uretir

--GROUP BY-----------------------------------------------------------------------
--elimizde birden fazla veri var ve karmasık ise bu verileri gruplamada group by kullanilir
--ayrıca group by daha cok fonksiyonlar ile kullanilir
--as ile kolonlara takma ad verilebilir 

-- arabalarin max fiyatı ile min fiyati ve bu arabaların fiyatlarının toplamını gruplandıran sorgu
select brand,
min(price) as min_price, 
max(price) as max_price, 
sum(price) as total 
from CAR_PRICES group by brand order by brand

--en pahalı arabadan en ucuz arabaya dogru sıralar
select brand,
max(price) as max_price
from CAR_PRICES
group by brand order by max(price) desc

-- en ucuz on araba markasını getirir
select top 10
brand,
min(price) as max_price 
from CAR_PRICES
group by brand order by min(price)

--------------------------------------------------------------------------------------------------------------
/*burada year_of_production sutununa deger verecegiz normalde insert isleminde 
year_of_production sutnuna deger vermedik ve o sutun null olarak olustu burada ise production_date'ten 
year_of_production uretecegiz yada cevirecegiz desek daha dogru olur*/

update CAR_PRICES set year_of_production = convert(date,production_date)
-- bu kod production_date sutununda ki tarih kısımlarını year_of_production sutununda gunceller
-- convert tip donusumu yapar production_date sutunu datetime(tarih ve saat) tipinde
-- year_of_production sutunu ise date(tarih) tipinde

-- bu sorgu tarihe gore, o tarihte o arabadan kac tane uertildigini veren sorgu
select brand, model,year_of_production, count(year_of_production) as uretim_adedi 
from CAR_PRICES group by brand,model,year_of_production
order by year_of_production

-- iki adet vites tipi var otomatik ve düz
-- distinct koymazsak 309 tane getirir yani tum arabalari getirir
select count(distinct gear_type) from CAR_PRICES

-- araba markalarinin satis fiyatlarini en fazladan en dusuge dogru getirir
select brand, sum(price) as price from CAR_PRICES group by brand order by sum(price) desc

select * from CAR_PRICES

---------------------------------------------------------------------------------------