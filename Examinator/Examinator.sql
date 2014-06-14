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
QuestionUploadDateTime, datetime,
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
--placeholder

--Catetory Table
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
(QuestionIDCat,QuestionUploader,QuestionTxt,QuestionImgPath,QuestionRecTime,QuestionUploadDateTime,QuestionBit)
values	(100,1002,'What animal Moos and makes Milk?',NULL,60,'2014-01-01',1),			--10000
		(100,1002,'What type of bear lives at the North Pole?',NULL,60,'2014-01-01',1),		--10001
		(100,1000,'What family of animals do Lions belong to?',NULL,60,'2014-01-01',1),		--10002
		(100,1000,'Snoopy from the cartoon Peanuts is what kind of dog?',NULL,'2014-01-01',1),	--10003
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
		(10006,


----------------------------
--STORED PROCEDURES
----------------------------


--------------------------------------------------------------
--Display, Verify, Add, Update and Delete from Table tbUser
--------------------------------------------------------------



------------------------
--TEST QUERIES
------------------------