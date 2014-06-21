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
		(100,1002,'What type of Bear lives at the North Pole?',NULL,60,'2014-01-01',1),		--10001
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
		(100,1001,'What animal is known as The King of Beasts?',NULL,60,'2014-05-05',1),		--10012
		(100,1002,'What food do Panda Bears eat?',NULL,60,'2014-06-01',1),	--10013
		(100,1002,'What type of horse appears on Budweiser commercials?',NULL,60,'2014-06-01',1),	--10014
		(100,1002,'What kind of animal do Shepherds tend to?',NULL,60,'2014-06-01',1),		--10015
		(100,1002,'What noise to Pigs make?',NULL,60,'2014-06-01',1),		--10016
		(100,1002,'What animal has long ears and hops?',NULL,60,'2014-06-01',1),		--10017
		(100,1002,'What type of animal is the cartoon character, Garfield?',NULL,60,'2014-06-01',1),		--10018
		(100,1002,'What animal has a long trunk?',NULL,60,'2014-06-01',1),		--10019
		(100,1002,'What animal has a long neck?',NULL,60,'2014-06-01',1),		--10020
		(100,1002,'What are animals that eat only plants called?',NULL,60,'2014-06-01',1),		--10021
		(100,1002,'What reptile can live to be more than 150 years old?',NULL,60,'2014-06-01',1),		--10022
		(100,1002,'What continent are Kangaroos native to?',NULL,60,'2014-06-01',1),		--10023
		(100,1002,'What reptile is the largest in the world?',NULL,60,'2014-06-01',1),		--10024
		(100,1002,'What are Dolphins classified as?',NULL,60,'2014-06-01',1),		--10025
		(100,1002,'What is the largest mammal in the world?',NULL,60,'2014-06-01',1),		--10026
		(100,1002,'What do Tadpoles grow up to become?',NULL,60,'2014-06-01',1),		--10027
		(104,1001,'What is Doctor McCoy''s first name?',NULL,60,'2014-06-01',1),		--10028
		(104,1001,'What crystals power the Enterprise''s warp drive?',NULL,60,'2014-06-01',1),		--10029
		(104,1001,'What does the word "Kaplah!" mean in Klingon?',NULL,60,'2014-06-01',1),		--10030
		(104,1001,'What small, furry creatures like Humans but not Klingons?',NULL,60,'2014-06-01',1),		--10031
		(104,1001,'What colour is Ensign Sulu''s shirt?',NULL,60,'2014-06-01',1),		--10032
		(104,1001,'In what city is Starfleet Headquarters located?',NULL,60,'2014-06-01',1),		--10033
		(104,1001,'What is Spock''s father''s name?',NULL,60,'2014-06-01',1),		--10034
		(104,1001,'What colour is a Vulcan''s blood?',NULL,60,'2014-06-01',1),		--10035
		(104,1001,'Who was the captain of the Enterprise before James Kirk?',NULL,60,'2014-06-01',1),		--10036
		(104,1000,'Who is the Communications Officer on the Enterprise?',NULL,60,'2014-06-01',1),		--10037
		(104,1000,'What starship is manned completely by only Vulcans?',NULL,60,'2014-06-01',1),		--10038
		(104,1000,'What is Doctor McCoy''s nickname?',NULL,60,'2014-06-01',1),		--10039
		(104,1000,'What ship did Captain Kirk serve on prior to the Enterprise?',NULL,60,'2014-06-01',1),		--10040
		(104,1000,'What Star Trek technology was invented by Zefram Cochrane?',NULL,60,'2014-06-01',1),		--10041
		(100,1002,'What animal can run the fastest, at speeds over 113 kilometers per hour?',NULL,60,'2014-06-01',1),		--10042
		(100,1002,'What animals occasionally commit suicide by jumping into the sea?',NULL,60,'2014-06-01',1),		--10043
		(100,1002,'What bird is the largest in the world?',NULL,60,'2014-06-01',1),		--10044
		(100,1002,'Which bird is the only one that can fly backwards?',NULL,60,'2014-06-01',1),		--10045
		(100,1002,'Who was the actor that played Lieutenant Sulu?',NULL,60,'2014-06-01',1),		--10046
		(104,1001,'How many years was the original Star Trek series'' mission?',NULL,60,'2014-06-01',1),		--10047
		(104,1001,'What was the total officer and crew complement of the USS Enterprise?',NULL,60,'2014-06-01',1),		--10048
		(104,1001,'Who was the inventor of the duotronic computer system used on the Enterprise?',NULL,60,'2014-06-01',1),		--10049
		(104,1001,'What was tne name of the ship that Ensign James T. Kirk was first assigned to?',NULL,60,'2014-06-01',1)		--10050
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
		(10012,'Lion','Rhinocerous','Grizzly Bear','Elephant','Bengal Tiger','Killer Whale',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10012
		(10013,'Bamboo Shoots','Eucalyptus Leaves','Bananas','Pineapples','Passion Fruit','Kiwi Fruit',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10013
		(10014,'Clydesdale','Shetland','Appaloosa','Arabian','Mustang','Quarterhorse',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10014
		(10015,'Sheep','Horses','Cows','Pigs','Chinchillas','Wookies',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10015
		(10016,'Oink Oink','Moooo','Brriiing','Hee Haw','Meow','Arf Arf',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10016
		(10017,'A Rabbit','A Donkey','A Kangaroo','A Giraffe','A Wolverine','A Skunk',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10017
		(10018,'A Cat','A Parrot','A Dog','A Hippopotamus','A Lion','A Hamster',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10018
		(10019,'An Elephant','A Giraffe','An Ostrich','An Emu','A Chimpanzee','A Tiger',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10019
		(10020,'A Giraffe','An Elephant','A Camel','A Kangaroo','A Penguin','A Mule',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10020
		(10021,'Herbivores','Carnivores','Omnivores','Vegetarians','Carnivals','Predators',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10021
		(10022,'Turtles','Snakes','Chameleons','Geckos','Crocodiles','Alligators',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10022
		(10023,'Australia','Africa','South America','Asia','Europe','North America',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10023
		(10024,'Saltwater Crocodile','King Cobra','Giant Anaconda','Komodo Dragon','Galapagos Turtle','Great White Shark',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10024
		(10025,'Mammals','Fish','Sharks','Alligators','Whales','Reptiles',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10025
		(10026,'Blue Whale','African Elephant','Wooly Rhinocerous','Tyrannosaurus Rex','Humpback Whale','Giant Squid',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10026
		(10027,'Frogs','Salamanders','Snakes','Lizards','Geckos','Goldfish',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10027
		(10028,'Leonard','Montgomery','Hatfield','Randolph','Bones','Pavel',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10028
		(10029,'Dilithium','Anti-Matter','Trilithium','Diamond','Electro-Plasma','Polylithium',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10029
		(10030,'Success!','Die Hooman!','Ouch!','Salutations!','Don''t Shoot!','I Surrender!',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10030
		(10031,'Tribbles','Chinchillas','Andorian Hamsters','Womprats','Ewoks','Jar Jar Binks',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10031
		(10032,'Command Gold','Sciences Blue','Operations Red','Security Maroon','Bioservices Green','Ninja Black',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10032
		(10033,'San Francisco, CA','New York City, NY','Washington, DC','Quantico, VA','Winnipeg, MB','London, GB',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10033
		(10034,'Sarek','Sonak','Vader','Spock Sr.','Tuvok','Saavik',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10034
		(10035,'Green','Blue','Red','Black','Transparent','Brown',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10035
		(10036,'Christopher Pike','Jean-Luc Picard','Mister Spock','Ben Cartwright','Kathryn Janeway','Gene Roddenberry',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10036
		(10037,'Lieutenant Uhura','Ensign Chekhov','Ensign Sulu','Nurse Chapel','Ensign Kim','Yeoman Rand',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10037
		(10038,'USS Intrepid','USS Farragut','USS Defiant','USS Excelsior','USS Enterprise','HMS Bounty',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10038
		(10039,'Bones','Scotty','Number One','Ole Stinky','Buttons','Shiny Man',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10039
		(10040,'USS Farragut','USS Intrepid','USS Constellation','USS Defiant','USS Excalibur','USS Yorktown',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10040
		(10041,'Warp Drive','Transporter','Replicator','Photon Torpedo','Holodeck','Emergency Medical Hologram',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10041
		(10042,'Cheetah','Gazelle','Zebra','Roadrunner','Kangaroo','Buffalo',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10042
		(10043,'Lemmings','Chinchillas','Muskrats','Minks','Raccoons','Squirrels',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10043
		(10044,'Ostrich','Pelican','Kiwi','Eagle','Emu','Penguin',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10044
		(10045,'Hummingbird','Sparrow','Starling','Seagull','Falcon','Toucan',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10045
		(10046,'George Takei','Garrett Wang','John Cho','Bruce Lee','Jackie Chan','Pat Morita',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10046
		(10047,'5','10','20','1','2','15',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10047
		(10048,'430','525','155','1140','370','290',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10048
		(10049,'Richard Daystrom','Miles Dyson','Zefram Cochrane','Emory Erickson','Leah Brahms','Isaac Asimov',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10049
		(10050,'USS Republic','USS Farragut','USS Defiant','USS Yorktown','USS Excelsior','USS Arizona',NULL,NULL,NULL,NULL,NULL,NULL,1)		--10050
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
		(10012,'The Lion is known as The King of Beasts, in the Panthera genus; may weigh up to 550 pounds and the males are recognizable by their highly distinctive manes.',1),		--12
		(10013,'Panda Bears'' diet is almost exclusively bamboo (leaves, stems and shoots), they can eat up to 40 kg per day of bamboo.',1),		--13
		(10014,'The horses from the Budweiser commercials are Clydesdales, known for white markings and feathering on the legs.',1),		--14
		(10015,'Shepherds, or sheep herders, look after and tend to Sheep.  They are often depicted carrying crooks to help guide sheep that go astray.',1),		--15
		(10016,'Pigs grunt and squeal but generally make a noise which sounds like "Oink Oink".',1),		--16
		(10017,'A Rabbit has long ears and hops.  Rabbits are found in many varieties and colours all around the world.',1),		--17
		(10018,'Garfield is a cat.  A big cat.  A big lasagna eating cat.',1),		--18
		(10019,'An Elephant has a long trunk.  The two main species are the African Elephant and the Asian Elephant.',1),		--19
		(10020,'The Giraffe has a long neck so that it can reach the leaves up high in a tree.',1),		--20
		(10021,'Animals that feed on only plants are called Herbivores.  They generally have flat teeth, suitable for chewing on grass and leaves.',1),		--21
		(10022,'The Galapagos Tortoise can live to be over 150 years old in the wild, the oldest recorded in captivity is 175 years.',1),		--22
		(10023,'Kangaroos are native to Australia.  Known for powerful hind legs and famous for carrying joeys in their pouch.',1),		--23
		(10024,'The largest reptile in the world is not the Komodo Dragon, but is the Saltwater Crocodile, reaching over 6 meters and 1360 kilograms.',1),		--24
		(10025,'Dolphins are classified as Mammals and not fish, because they need to breathe air and bear their young live.',1),		--25
		(10026,'The largest mammal in the world today is the Blue Whale, reaching lengths of over 30 metres and 136 tonnes.',1),		--26
		(10027,'Young Tadpoles (also called pollywogs) grow up to become Frogs.  In this larval stage, they breathe through gills and live in the water.',1),		--27
		(10028,'',1),		--28
		(10029,'',1),		--29
		(10030,'',1),		--30
		(10031,'',1),		--31
		(10032,'',1),		--32
		(10033,'',1),		--33
		(10034,'',1),		--34
		(10035,'',1),		--35
		(10036,'',1),		--36
		(10037,'',1),		--37
		(10038,'',1),		--38
		(10039,'',1),		--39
		(10040,'',1),		--40
		(10041,'',1),		--41
		(10042,'',1),		--42
		(10043,'',1),		--43
		(10044,'',1),		--44
		(10045,'',1),		--45
		(10046,'',1),		--46
		(10047,'',1),		--47
		(10048,'',1),		--48
		(10049,'',1),		--49
		(10050,'',1)		--50
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
--drop procedure spGetQuiz
create procedure spGetQuiz
(
	@CategoryID int = null,
	@Difficulty int = null
)
as
	begin
		select * from tbQuestions q
		join tbCategory c on c.CategoryID = @CategoryID
		join tbAnswers a on a.AnswerID = q.QuestionID
		where QuestionCatID = @CategoryID
	end
go

spGetQuiz
@CategoryID = 104