USE master
GO
DROP DATABASE dbExaminator
GO
CREATE DATABASE dbExaminator
GO
USE dbExaminator
GO


------------------------------
--CREATING TABLES
------------------------------

--drop table tbUsers
create table tbUsers
(UserID int identity (1000,1) primary key,
UserName varchar (30),
UserPass varchar (30),
UserEmail varchar (30),
UserLvl int,
UserBit bit)
go

--drop table tbPreferences
create table tbPreferences
(PrefID int identity (10,1) primary key,
PrefUserID int foreign key references tbUsers (UserID),
PrefBkgCol varchar (20), 	-- page background
PrefBannerCol varchar (20), -- menu bar colour
PrefBoldCol varchar (20), 	-- headings, questions and anything boldface
PrefTxtCol varchar (20),	-- descriptions, answers, explanations
PrefFont varchar (20),		-- page font
PrefBit bit)
go


--drop table tbCategory
create table tbCategory
(CategoryID int identity (100,1) primary key,
CatName varchar (25),
CatDesc varchar (65),
CatBit bit)
go

--drop table tbQuestions
create table tbQuestions
(QuestionID int identity (10000,1) primary key,
QuestionCatID int foreign key references tbCategory (CategoryID),
QuestionUploader int foreign key references tbUsers (UserID),
QuestionTxt varchar (256),
QuestionImgPath varchar (50),
QuestionRecTime int,
QuestionUploadDateTime datetime,
QuestionBit bit)
go

--drop table tbAnswers
create table tbAnswers
(AnswerID int identity (10000,1) primary key,
AnswerQuestionID int foreign key references tbQuestions (QuestionID),
AnswerCorrect varchar (256),
Answer1 varchar (256),
Answer2 varchar (256),
Answer3 varchar (256),
Answer4 varchar (256),
Answer5 varchar (256),
AnswerCorrectImg varchar (50),
Answer1Img varchar (50),
Answer2Img varchar (50),
Answer3Img varchar (50),
Answer4Img varchar (50),
Answer5Img varchar (50),
AnswerBit bit)
go

--drop table tbExplanations
create table tbExplanations
(ExplnID int identity (1,1) primary key,
ExplnQuestionID int foreign key references tbQuestions (QuestionID),
ExplnText varchar (500),
ExplnBit bit)
go

--drop table tbScores
create table tbScores
(ScoreID int identity (1,1) primary key,
ScoreUserID int foreign key references tbUsers (UserID),
ScoreCategoryID int foreign key references tbCategory (CategoryID),
ScoreTotalScore int,
ScoreAverageTime decimal (5,2),
ScoreTotalTime decimal (5,2),
ScoreDateTaken date)
go

------------------------------
--POPULATING TABLES
------------------------------

--User Table
insert into tbUsers
(UserName,UserPass,UserEmail,UserLvl,UserBit)
values	('admin','admin','admin@examinator.com',2,1),	--1000
		('homer','homer','homer@simpson.com',1,1),		--1001
		('robin','robin','r.iwamoto@shaw.ca',1,1),		--1002
		('buttons','beaw','sqvishee@gmail.com',1,1),	--1003
		('betty','tear','betty@tear.com',1,1)			--1004
go

--Preference Table (Populate after values are known)
--this is a place holder

--Category Table
insert into tbCategory
(CatName,CatDesc,Catbit)
values	('Animals','General Knowledge: Amimals',1),				--100
		('Colours','General Knowledge: Colours',1),				--101
		('World Geography','Geography: World',1),				--102
		('Astronomy','Astronomy: The Solar System',1),			--103
		('Star Trek: TOS','Star Trek: The Original Series',1)	--104
go

--Questions Table
insert into tbQuestions
(QuestionCatID,QuestionUploader,QuestionTxt,QuestionImgPath,QuestionRecTime,QuestionUploadDateTime,QuestionBit)
values	(100,1002,'What animal Moos and makes Milk?',NULL,60,'2014-01-01',1),			--10000
		(100,1002,'What type of bear lives at the North Pole?',NULL,60,'2014-01-01',1),		--10001
		(100,1000,'What family of animals do Lions belong to?',NULL,60,'2014-01-01',1),		--10002
		(100,1000,'Snoopy from the cartoon Peanuts is what kind of dog?',NULL,60,'2014-01-01',1),	--10003
		(100,1001,'What feline animal has spots?',NULL,60,'2014-02-02',1),				--10004
		(104,1003,'Who is the Chief Engineer on the USS Enterprise?',NULL,60,'2014-03-01',1),	--10005
		(104,1003,'What is the middle name of Captain Kirk?',NULL,60,'2014-03-01',1),		--10006
		(104,1003,'What does it mean when we see a new ensign with a red shirt on an away mission?',NULL,60,'2014-03-01',1),	--10007
		(104,1003,'What instrument do Starfleet personnel use to analyze things?',NULL,60,'2014-03-01',1),		--10008
		(104,1003,'What is the designation number for the USS Enterprise?',NULL,60,'2014-05-05',1),			--10009
		(104,1004,'What vehicle do Starfleet personnel use when they cannot use the transporter?',NULL,60,'2014-03-06',1),		--10010
		(104,1004,'What race is Mister Spock?',NULL,60,'2014-05-05',1),		--10011
		(100,1001,'What animal is known as The King of Beasts?',NULL,60,'2014-05-05',1)		--10012
go

--Answers Table
insert into tbAnswers
(AnswerQuestionID,AnswerCorrect,Answer1,Answer2,Answer3,Answer4,Answer5,AnswerCorrectImg,Answer1Img,Answer2Img,Answer3Img,Answer4Img,Answer5Img,AnswerBit)
values	(10000,'A Cow','A Horse','A Chicken','A Hippopotamus','An Elephant','A Giraffe',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10000
		(10001,'A Polar Bear','A Panda Bear','A Black Bear','A Brown Bear','A Koala Bear','A Grizzly Bear',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10001
		(10002,'Felines','Carnivores','Canines','Amphibians','Vulcans','Humans',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10002
		(10003,'Beagle','Irish Setter','Daschund','Collie','Foxhound','Badger',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10003
		(10004,'Leopard','Tiger','Lion','OhMy','Siamese','Cheetah',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10004
		(10005,'Lt. Commander Scott','Ensign Chekhov','Captain Kirk','Commander Spock','Doctor McCoy','Lt. Commander Uhura',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10005
		(10006,'Tiberius','Bartholomew','Flavius','William','Abraham','Socrates',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10006
		(10007,'He/She will be killed','There will be a new co-star in the series','Captain Kirk will get married','He/She will replace one of the bridge crew','Nothing will happen','He/She will turn out to be a Romulan spy',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10007
		(10008,'A Tricorder','A Flux Capacitor','A Phaser','A Plasma Conduit','A Transporter','A Photon Torpedo',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10008
		(10009,'NCC-1701','NCC-5405','UFP-1701','USS-5000','HPD-50','SOS-2001',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10009
		(10010,'A Shuttlecraft','A Phase Array','A Dilithium Matrix','A Tricorder','A Homing Beacon','A Matter-AntiMatter Pod',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10010
		(10011,'Vulcan','Klingon','Romulan','Ferrengi','Human','Shapeshifter',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10011
		(10012,'Lion','Rhinocerous','Grizzly Bear','Elephant','Bengal Tiger','Killer Whale',NULL,NULL,NULL,NULL,NULL,NULL,1)		--10012
go

--Explanations Table (for non-Exam Modes)
insert into tbExplanations
(ExplnQuestionID,ExplnText,ExplnBit)
values	(10000,'A Cow is raised on dairy farms to produce milk and often makes Mooing sounds.',1),		--1
		(10001,'Polar Bears live in the Artic Circle and have white fur to blend in with the snow.',1),	--2
		(10002,'Lions belong to the Feline family of animals, typically any animal that is cat-like.',1),	--3
		(10003,'Snoopy is a Beagle, and was born on the Daisy Hill Puppy Farm.',1),		--4
		(10005,'The Chief Engineer on the USS Enterprise is Lt. Cmdr Montgomery Scott, also known as "Scotty".',1),	--5
		(10006,'Captain Kirk''s middle name is Tiberius, he was born in Riverside Iowa on March 22, 2233.',1),		--6
		(10007,'He/she usually gets killed.  Affectionately nicknamed ''Ensign Nobody'' or ''Ensign Redshirt'', they are typically the first ones killed on an away mission.',1),		--7
		(10008,'The Tricorder is the general purpose hand-held device used for sensor scanning, data analysis and recording data in the ST universe.',1),		--8
		(10009,'The designation of the USS Enterprise is NCC-1701, a Constitution class heavy cruiser starship that was launched in 2245.',1),		--9
		(10010,'A Shuttlecraft is typically used when the Transporter is unable to be used for "beaming down".  It typically carries 2 to 6 persons.',1),		--10
		(10011,'Mister Spock is a Vulcan, from the planet Vulcan.  The Vulcans are known for their logic, intelligence and ability to suppress emotion.',1),		--11
		(10012,'The Lion is known as The King of Beasts, in the Panthera genus; may weigh up to 550 pounds and the males are recognizable by their highly distinctive manes.',1)		--12
go

--Scores Table
insert into tbScores
(ScoreUserID,ScoreCategoryID,ScoreTotalScore,ScoreAverageTime,ScoreTotalTime,ScoreDateTaken)
values	(1001,104,75,1.0,1,'2014-05-01'),
		(1002,100,80,.8,1,'2014-05-02'),
		(1003,104,95,.5,1,'2014-05-02'),
		(1001,104,42,.65,1,'2014-05-04')
go

	
----------------------------
--STORED PROCEDURES
----------------------------

--------------------------------------------------------------
--Display, Verify, Add, Update and Delete from Table tbUsers
--------------------------------------------------------------

--drop procedure spGetUsers 
--gets one (by UserID) or all clients
create procedure spGetUsers
(
	@UserID int = null
)
as
	begin
		select
		*
		from tbUsers
		where UserID = isnull(@UserID,UserID)
		and UserBit = 1
	end
go

--drop procedure spVerifyUsers 
--used in Login procedure 
create procedure spVerifyUsers
(
	@UserName varchar (30) = null,
	@UserPass varchar (30) = null
)
as
	begin
		if exists (select * from tbUsers where UserName = @UserName and UserPass = @UserPass and UserBit = 1)
			begin
				select * from tbUsers where UserName = @UserName
				and UserBit = 1
			end
		else
			begin	
				select ClientLvl = -1 from tbUsers
			end
	end
go

--drop procedure spAddUsers 
--procedure to add new users 
create procedure spAddUsers
(
	@UserID int = null,
	@UserName varchar (30) = null,
	@UserPass varchar (30) = null,
	@UserEmail varchar (30) = null,
	@UserLvl int = null,
	@UserBit bit = 1
)
as
	begin
		if exists (select * from tbUsers where UserName = @UserName)
			begin
				select 'UserID Exists' = 'UserID Exists' from tbUsers where UserName = @UserName
			end
	else
		begin
			insert into tbUsers
			(UserName,UserPass,UserEmail,UserLvl,UserBit)
			values	(@UserName,@UserPass,@UserEmail,1,1)
			select * from tbUsers where UserName = @UserName
			and UserBit = 1
		end
	end
go

--drop procedure spChangeUserPW
--procedure for users to change password
create procedure spChangeUserPW
(
	@UserID int = null,
	@UserName varchar (30) = null,
	@UserPass varchar (30) = null,
	@UserEmail varchar (30) = null,
	@UserLvl int = null,
	@UserBit bit = 1
)
as
	begin
		if exists (select * from tbUsers where UserID = @UserID)
			begin
				update tbUsers
				set UserPass = @UserPass
				where UserID = @UserID
				select * from tbUsers where UserID = @UserID
				and UserBit = 1
			end
	end
go

--drop procedure spDeleteUsers
--procedure to delete users (set UserBit to 0)
create procedure spDeleteUsers
(
	@UserID int = null,
	@UserName varchar (30) = null,
	@UserPass varchar (30) = null,
	@UserEmail varchar (30) = null,
	@UserLvl int = null,
	@UserBit bit = 1
)
as
	begin
		if exists (select * from tbUsers where UserID = @UserID)
			begin
				update tbUsers
				set UserBit = 0
				where UserID = @UserID
				select * from tbUsers where UserID = @UserID
				and UserBit = 1
			end
	end
go

--------------------------------------------------------------
--Score Related Stored Procedures
--------------------------------------------------------------

--drop procedure spGetTop10
create procedure spGetTop10
as
	begin
		select top 10 u.UserName,c.CatName,ScoreTotalScore,ScoreDateTaken from tbScores
		join tbUsers u on ScoreUserID = UserID
		join tbCategory c on ScoreCategoryID = CategoryID
		order by ScoreTotalScore desc,CatName asc
	end
go



------------------------
--TEST QUERIES
------------------------

select * from tbScores



