-- Создание базы данных
USE master 

-- Если есть БД с заданным именем,
-- то удаляем и создаем новую
IF DB_ID('AutorepairShop') IS NOT NULL
	alter database AutorepairShop set single_user with rollback immediate
	DROP DATABASE AutorepairShop;

CREATE DATABASE AutorepairShop;

GO

USE AutorepairShop;

-- Создание таблиц
-- Таблица названия должностей(квалификация) для механиков
CREATE TABLE dbo.Qualifications(
	QualificationId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Name nvarchar(50) NOT NULL,
	Salary int NOT NULL
	)
-- Таблица механики
CREATE TABLE dbo.Mechanics(
	MechanicId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName nvarchar(20) NOT NULL,
	MiddleName nvarchar(30) NOT NULL,
	LastName nvarchar(30) NOT NULL,
	QualificationId int NOT NULL,
	Experience int NOT NULL,

	FOREIGN KEY (QualificationId)
	REFERENCES Qualifications(QualificationId)
	ON DELETE CASCADE
	ON UPDATE CASCADE 
	)
-- Таблица владельцы авто
CREATE TABLE dbo.Owners(
	OwnerId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName nvarchar(20) NOT NULL,
	MiddleName nvarchar(30) NOT NULL,
	LastName nvarchar(30) NOT NULL,
	DriverLicenseNumber int NOT NULL,
	Address nvarchar(60) NOT NULL,
	Phone bigint NOT NULL
	)
-- Таблица автомобилей
CREATE TABLE dbo.Cars(
	CarId int IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	Brand nvarchar(50) NOT NULL,
	Power int NOT NULL,
	Color nvarchar(20) NOT NULL,
	StateNumber nvarchar(10) NOT NULL,
	OwnerId int NOT NULL,
	Year int NOT NULL, 
	VIN nvarchar(20) NOT NULL,
	EngineNumber nvarchar(20) NOT NULL,
	AdmissionDate date NOT NULL,

	FOREIGN KEY (OwnerId)
	REFERENCES Owners(OwnerId)
	ON DELETE CASCADE
	ON UPDATE CASCADE 
	)
-- Таблица платежей
CREATE TABLE dbo.Payments(
	PaymentId int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	CarId int NOT NULL,
	Date date NOT NULL,
	Cost int NOT NULL,
	MechanicId int NOT NULL,
	ProgressReport nvarchar(50),
	
	FOREIGN KEY (CarId)
	REFERENCES Cars(CarId)
	ON DELETE CASCADE
	ON UPDATE CASCADE,

	FOREIGN KEY (MechanicId)
	REFERENCES Mechanics(MechanicId)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	)


-- Заполнение данными таблицу квалификации для механиков
INSERT Qualifications(Name, Salary) VALUES ('1 разряд', 700),('2 разряд', 800),('3 разряд', 900),('4 разряд', 950),('5 разряд', 1100);

-- декларируем переменные для автозаполнения таблиц
declare @ArrayFirstName table(id int IDENTITY(1,1), value nvarchar(20))
declare @ArrayMiddleName table(id int IDENTITY(1,1), value nvarchar(30))
declare @ArrayLastName table(id int IDENTITY(1,1), value nvarchar(30))
declare @ArrayAddress table(id int IDENTITY(1,1), value nvarchar(50))
declare @ArrayColor table(id int IDENTITY(1,1), value nvarchar(30))
declare @ArrayBrand table(id int IDENTITY(1,1), value nvarchar(30))
declare @ArrayProgress table(id INT IDENTITY(1,1), value nvarchar(50))


insert into @ArrayFirstName (value) values
		('Adel'),('Odolf'),('Zia'),('Parveen'),('Amadi'),('Blanda'),('Wilfred'),('Oriole'),('Trudie'),('Aloysia'),('Roderick'),('Desta'),('Carsten'),('Carsten'),('Cathal'),('Mariam'),('Francesca');
insert into @ArrayMiddleName (value) values
		('Carney'),('Martine'),('Leeson'),('Russ'),('Burke'),('Russ'),('Gullett'),('Marquardt'),('Kauffman'),('Kauffman'),('Victor'),('Oaks'),('Huebner'),('Strohm'),('Rushton'),('Fritsche'),('Berumen');
insert into @ArrayLastName (value) values
('Smelser'),('Capasso'),('Bodnar'),('Stacy'),('Steen'),('Calder'),('Wolford'),('Cristobal'),('Browne'),('Cowan'),('Luongo'),('Bodnar'),('Kessinger'),('Soden'),('Marrero');
insert into @ArrayAddress (value) values		
		('Quaking Mountain'),('Dusty Orchard'),('Quiet Diversion'),('Tawny Island'),('Sleepy Extension'),('Bright Boulevard'),('Burning Hollow'),('Emerald Avenue'),
		('Iron Forest'),('Merry Plaza'),('Lazy Abbey'),('Honey Terrace'),('Rocky Farm'),('Wishing Cider'),('Red Berry'),('Amber Barn'),('Silver Quail'),('Old Ridge'),('Grand Private');
insert into @ArrayColor (value) values ('Черный'), ('Белый'),('Синий'),
						('Зеленый'),('Красный'),('Желтый'),('Фиолетовый');
insert into @ArrayBrand (value) values ('Acura'), ('AlfaRomeo'), ('AstonMartin'), ('Audi'), ('Bentley'), ('BMW'), ('Cadillac'),
						('Chery'), ('Chevrolet'), ('Chrysler'), ('Citroen'), ('Dacia'), ('Daewoo'), ('Datsun'), ('Dodge'), ('FAW'), ('Ferrarri'),
						('Fiat'), ('Ford'), ('GAC'), ('Geely'), ('Genesis'), ('GMC'), ('Haval'), ('Honda'), ('Hummer'), ('Hyundai'), ('Infiniti'),
						('Jaguar'), ('Jeep'), ('Kia'), ('Lada'), ('LandRover'), ('Lexus'), ('Lifan'), ('Lincoln'), ('Maserati'), ('Mazda'), ('MercedsBenz'),
						('Mitsubishi'), ('Nissan'), ('Opel'), ('Peugeot'), ('Porsche'), ('Renault'), ('Rover'), ('SEAT'), ('Skoda'), ('Smart'), ('Subaru'),
						('Suzuki'), ('Tesla'), ('Toyota'), ('Volkswagen'), ('Volvo');
insert into @ArrayProgress (value) values ('Ремонтподвески'),('АвтоЭлектрика'),('Кузовной ремонт'),('Ремонт двигателя'),('Развал схождение'),('Ремонт КПП'),('Ремонт топливной'),
('Рулевое управление'),('Замена ГРМ'),('Тормозная система'),('Диагностика автомобилей'),('Замена автостекла'),('Замена масла'),('Компьютерная диагностика'),('Шиномонтаж'),('Автомойка'),
('Полировка'),('Тюнинг'),('ремонт АКПП'),('ремонт турбин'),('ремонт рулевой рейки'),('ремонт глушителей'),('ремонт суппортов'),('замена сцепления'),('ремонт задней балки'),
('антикоррозийная обработка'),('ремонт карданных валов'),('регулировка света фар'),('беспокрасочное удаление вмятин'),('ремонт радиаторов'),('ремонт гидроусилителей'),('аудио, сигнализации'),
('газовое оборудование'),('Шины продажа'),('Масло продажа'),('ремонт печек'),('замена глушителя'),('ремонт дворников'),('ремонт полуприцепов'),('установка ксенона, парктроника'),('ремонт фар'),
('установка фаркопа'),('замена сажевого фильтра');

declare @Symbol CHAR(36)= 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
		@minName int, @maxFirstName int,  @maxMiddleName int,  @maxLastName int,
		@FirstName nvarchar(20), @MiddleName nvarchar(30), @LastName nvarchar(30),
		@Qualification int, @Experience int, @countMechanic int;

SET @minName = 1;
SET @countMechanic = 50;

SET @maxFirstName = (SELECT COUNT(value) FROM @ArrayFirstName)
SET @maxMiddleName = (SELECT COUNT(value) FROM @ArrayMiddleName)
SET @maxLastName = (SELECT COUNT(value) FROM @ArrayLastName)

WHILE @countMechanic > 0
	BEGIN
		SET @FirstName = (select value from @ArrayFirstName WHERE id = FLOOR(RAND()*(@maxFirstName-@minName+1)+@minName))
		SET @MiddleName = (select value from @ArrayMiddleName WHERE id = FLOOR(RAND()*(@maxMiddleName-@minName+1)+@minName))
		SET @LastName = (select value from @ArrayLastName WHERE id = FLOOR(RAND()*(@maxLastName-@minName+1)+@minName))
		SET @Qualification = (SELECT FLOOR(RAND()*(5-1+1)+1))
		SET @Experience = (SELECT FLOOR(RAND()*(20-1+1)+1))

		INSERT INTO Mechanics(FirstName,MiddleName,LastName,QualificationId, Experience) VALUES
		((@FirstName),(@MiddleName),(@LastName),(@Qualification),(@Experience));
		SET @countMechanic = @countMechanic - 1;
	END;

-- Заполнение владельцев автомобилей
declare @DriveLic smallInt, @Phone bigint,
		@maxAddress int, @Address nvarchar(60),
		@countOwner int

SET @countOwner = 50;
SET @minName = 1;

SET @maxFirstName = (SELECT COUNT(value) FROM @ArrayFirstName)
SET @maxMiddleName = (SELECT COUNT(value) FROM @ArrayMiddleName)
SET @maxLastName = (SELECT COUNT(value) FROM @ArrayLastName)
SET @maxAddress = (SELECT COUNT(value) FROM @ArrayAddress)

WHILE @countOwner > 0
	BEGIN
		SET @FirstName = (select value from @ArrayFirstName WHERE id = FLOOR(RAND()*(@maxFirstName-@minName+1)+@minName))
		SET @MiddleName = (select value from @ArrayMiddleName WHERE id = FLOOR(RAND()*(@maxMiddleName-@minName+1)+@minName))
		SET @LastName = (select value from @ArrayLastName WHERE id = FLOOR(RAND()*(@maxLastName-@minName+1)+@minName))
		SET @DriveLic = (SELECT FLOOR(RAND()*(9999-1000+1)+1000))
		SET @Address = (select value from @ArrayAddress WHERE id = FLOOR(RAND()*(@maxAddress-@minName+1)+@minName)) + ', St.' + STR((SELECT FLOOR(RAND()*(999-100+1)+100)),3)
		SET @Phone = (SELECT FLOOR(RAND()*(80271111111-80279991111+1)+80279991111))

		INSERT INTO Owners (FirstName,MiddleName,LastName,DriverLicenseNumber, Address, Phone) VALUES
		((@FirstName),(@MiddleName),(@LastName),(STR(@DriveLic,4)),(@Address),(STR(@Phone, 12)));
		SET @countOwner = @countOwner - 1;
	END;


-- Заполнение таблицы машин

declare @VIN nvarchar(20), @EngineNumber nvarchar(10),
		@j int, @Limit int, @PosRand int,
		@minPower int, @maxPower int,
		@minStateNumber int, @maxStateNumber int,
		@minYear int, @maxYear int,		
		@colorCount int, @Color nvarchar(20),
		@Power int, @OwnerId int, @StateNumber nvarchar(11),
		@Year int, @AdmissionDate nvarchar(12),
		@brandCount int, @Brand nvarchar(40),
		@countCar int, @countOwners int

SET @countOwners = 50;


SET @countCar = 50
SET @colorCount = (SELECT COUNT(value) FROM @ArrayColor)
SET @brandCount = (SELECT COUNT(value) FROM @ArrayBrand)


SET @minPower = 120;
SET @maxPower = 650;
SET @minYear = 2000;
SET @maxYear = 2022;

WHILE @countCar > 0
	BEGIN
		SET @Power = (SELECT FLOOR(RAND()*(@maxPower-@minPower+1)+@minPower))
		SET @Color = (select value from @ArrayColor WHERE id = FLOOR(RAND()*(@colorCount-1+1)+1))
		SET @StateNumber = STR((SELECT FLOOR(RAND()*(9999-1000+1)+1000)),4) + ' BB-' + STR((SELECT FLOOR(RAND()*(7-1+1)+1)),1)
		SET @OwnerId = (SELECT FLOOR(RAND()*(@countOwners-1+1)+1))
		SET @Year = (SELECT FLOOR(RAND()*(@maxYear-@minYear+1)+@minYear))
		SET @Brand = (select value from @ArrayBrand WHERE id = FLOOR(RAND()*(@brandCount-1+1)+1))
		SET @AdmissionDate = STR((SELECT FLOOR(RAND()*(2022-2021+1)+2021)),4) + '-' + TRIM(STR((SELECT FLOOR(RAND()*(12-1+1)+1)),2)) + '-' + TRIM(STR((SELECT FLOOR(RAND()*(28-1+1)+1)),2))
		SET @Limit = 36
		SET @j = 1
		SET @VIN = ''
		SET @EngineNumber = ''		
		WHILE @j<=@Limit
			BEGIN
				SET @PosRand=RAND()*36
				SET @VIN = @VIN + SUBSTRING(@Symbol, @PosRand, 1)
				SET @PosRand=RAND()*36
				SET @EngineNumber = @EngineNumber + SUBSTRING(@Symbol, @PosRand, 1)
				SET @j=@j+1
			END
		INSERT INTO Cars(Brand, Power, Color, StateNumber, OwnerId, Year, VIN, EngineNumber, AdmissionDate)
		VALUES (@Brand, @Power, @Color, @StateNumber, @OwnerId, @Year, @VIN, @EngineNumber, @AdmissionDate);
		SET @countCar = @countCar - 1;
		END;


-- Заполнение таблицы платежи

declare @CarId int,
		@Date nvarchar(12),
		@Cost int, @minCost int, @maxCost int,
		@MechanicId int, @ProgressReport nvarchar(50),
		@countProgress int, @countPayments int

SET @countMechanic = 50
SET @countCar = 50

SET @countPayments = 50

-- for cost payments
SET @minCost = 75
SET @maxCost = 300

SET @countProgress = (SELECT COUNT(value) FROM @ArrayProgress)


WHILE @countPayments > 0
	BEGIN
		SET @CarId = (SELECT FLOOR(RAND()*(@countCar-1+1)+1))
		SET @Date = STR((SELECT FLOOR(RAND()*(2022-2021+1)+2021)),4) + '-'
							+ TRIM(STR((SELECT FLOOR(RAND()*(12-1+1)+1)),2)) + '-'
							+ TRIM(STR((SELECT FLOOR(RAND()*(28-1+1)+1)),2))
		SET @Cost = (SELECT FLOOR(RAND()*(@maxCost-@minCost+1)+@minCost))
		SET @MechanicId = (SELECT FLOOR(RAND()*(@CountMechanic-1+1)+1))
		SET @ProgressReport = (select value from @ArrayProgress where id = FLOOR(RAND()*(@countProgress-1+1)+1))
		INSERT INTO Payments (CarId, Date, Cost, MechanicId, ProgressReport) 
		VALUES (@CarId, @Date, @Cost, @MechanicId, @ProgressReport)
		SET @countPayments = @countPayments - 1
	END;