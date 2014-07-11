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
QuestionApprovalBit bit,
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
		('Star Trek: TOS','Star Trek: The Original Series',1),	--104
		('Software & Database','Robertson College: Software & Database Developer',1)	--105
go

--Questions Table
insert into tbQuestions
(QuestionCatID,QuestionUploader,QuestionTxt,QuestionImgPath,QuestionRecTime,QuestionUploadDateTime,QuestionApprovalBit,QuestionBit)
values	(100,1002,'What animal Moos and makes Milk?',NULL,30,'2014-01-01',1,1),			--10000
		(100,1002,'What type of Bear lives at the North Pole?',NULL,30,'2014-01-01',1,1),		--10001
		(100,1000,'What family of animals do Lions belong to?',NULL,45,'2014-01-01',1,1),		--10002
		(100,1000,'Snoopy from the cartoon Peanuts is what kind of dog?',NULL,40,'2014-01-01',1,1),	--10003
		(100,1001,'What feline animal has spots?',NULL,30,'2014-02-02',1,1),				--10004
		(104,1003,'Who is the Chief Engineer on the USS Enterprise?',NULL,40,'2014-03-01',1,1),	--10005
		(104,1003,'What is the middle name of Captain Kirk?',NULL,60,'2014-03-01',1,1),		--10006
		(104,1003,'What does it mean when we see a new ensign with a red shirt on an away mission?',NULL,60,'2014-03-01',1,1),	--10007
		(104,1003,'What instrument do Starfleet personnel use to analyze things?',NULL,50,'2014-03-01',1,1),		--10008
		(104,1003,'What is the designation number for the USS Enterprise?',NULL,60,'2014-05-05',1,1),			--10009
		(104,1004,'What vehicle do Starfleet personnel use when they cannot use the transporter?',NULL,55,'2014-03-06',1,1),		--10010
		(104,1004,'What race is Mister Spock?',NULL,40,'2014-05-05',1,1),		--10011
		(100,1001,'What animal is known as The King of Beasts?',NULL,30,'2014-05-05',1,1),		--10012
		(100,1002,'What food do Panda Bears eat?',NULL,50,'2014-06-01',1,1),	--10013
		(100,1002,'What type of horse appears on Budweiser commercials?',NULL,60,'2014-06-01',1,1),	--10014
		(100,1002,'What kind of animal do Shepherds tend to?',NULL,50,'2014-06-01',1,1),		--10015
		(100,1002,'What noise to Pigs make?',NULL,30,'2014-06-01',1,1),		--10016
		(100,1002,'What animal has long ears and hops?',NULL,30,'2014-06-01',1,1),		--10017
		(100,1002,'What type of animal is the cartoon character, Garfield?',NULL,30,'2014-06-01',1,1),		--10018
		(100,1002,'What animal has a long trunk?',NULL,30,'2014-06-01',1,1),		--10019
		(100,1002,'What animal has a long neck?',NULL,30,'2014-06-01',1,1),		--10020
		(100,1002,'What are animals that eat only plants called?',NULL,60,'2014-06-01',1,1),		--10021
		(100,1002,'What reptile can live to be more than 150 years old?',NULL,60,'2014-06-01',1,1),		--10022
		(100,1002,'What continent are Kangaroos native to?',NULL,30,'2014-06-01',1,1),		--10023
		(100,1002,'What reptile is the largest in the world?',NULL,60,'2014-06-01',1,1),		--10024
		(100,1002,'What are Dolphins classified as?',NULL,50,'2014-06-01',1,1),		--10025
		(100,1002,'What is the largest mammal in the world?',NULL,55,'2014-06-01',1,1),		--10026
		(100,1002,'What do Tadpoles grow up to become?',NULL,40,'2014-06-01',1,1),		--10027
		(104,1001,'What is Doctor McCoy''s first name?',NULL,45,'2014-06-01',1,1),		--10028
		(104,1001,'What crystals power the Enterprise''s warp drive?',NULL,50,'2014-06-01',1,1),		--10029
		(104,1001,'What does the word "Ka''Plah!" mean in Klingon?',NULL,50,'2014-06-01',1,1),		--10030
		(104,1001,'What small, furry creatures like Humans but not Klingons?',NULL,55,'2014-06-01',1,1),		--10031
		(104,1001,'What colour is Lieutenant Sulu''s shirt?',NULL,40,'2014-06-01',1,1),		--10032
		(104,1001,'In what city is Starfleet Headquarters located?',NULL,50,'2014-06-01',1,1),		--10033
		(104,1001,'What is Spock''s father''s name?',NULL,50,'2014-06-01',1,1),		--10034
		(104,1001,'What colour is a Vulcan''s blood?',NULL,50,'2014-06-01',1,1),		--10035
		(104,1001,'Who was the captain of the Enterprise before James Kirk?',NULL,60,'2014-06-01',1,1),		--10036
		(104,1000,'Who is the Communications Officer on the Enterprise?',NULL,40,'2014-06-01',1,1),		--10037
		(104,1000,'What starship is manned completely by only Vulcans?',NULL,70,'2014-06-01',1,1),		--10038
		(104,1000,'What is Doctor McCoy''s nickname?',NULL,50,'2014-06-01',1,1),		--10039
		(104,1000,'What ship did Captain Kirk serve on prior to the Enterprise?',NULL,90,'2014-06-01',1,1),		--10040
		(104,1000,'What Star Trek technology was invented by Zefram Cochrane?',NULL,60,'2014-06-01',1,1),		--10041
		(100,1002,'What land animal can run the fastest, at speeds over 115 kilometers per hour?',NULL,50,'2014-06-01',1,1),		--10042
		(100,1002,'What animals occasionally commit suicide by jumping into the sea?',NULL,45,'2014-06-01',1,1),		--10043
		(100,1002,'What bird is the largest in the world?',NULL,50,'2014-06-01',1,1),		--10044
		(100,1002,'Which bird is the only one that can fly backwards?',NULL,40,'2014-06-01',1,1),		--10045
		(104,1002,'Who was the actor that played Lieutenant Sulu?',NULL,40,'2014-06-01',1,1),		--10046
		(104,1001,'How many years was the original Star Trek series'' mission?',NULL,25,'2014-06-01',1,1),		--10047
		(104,1001,'What was the total officer and crew complement of the USS Enterprise?',NULL,60,'2014-06-01',1,1),		--10048
		(104,1001,'Who was the inventor of the duotronic computer system used on the Enterprise?',NULL,60,'2014-06-01',1,1),		--10049
		(104,1001,'What was tne name of the ship that Ensign James T. Kirk was first assigned to?',NULL,60,'2014-06-01',1,1),		--10050
		(101,1001,'What two colours are known to make you hungry?',NULL,50,'2014-06-03',1,1),		--10051
		(101,1001,'What colour results when combining Red and Blue?',NULL,40,'2014-06-03',1,1),		--10052
		(101,1001,'Which colour has the highest (longest) wavelength?',NULL,40,'2014-06-03',1,1),		--10053
		(101,1001,'What colour results when mixing Red, Yellow and Blue?',NULL,50,'2014-06-03',1,1),		--10054
		(101,1001,'Primary Colours are Red, Yellow and Blue.  What are the Secondary Colours?',NULL,40,'2014-06-03',1,1),		--10055
		(102,1003,'What is the name of the southernmost continent?',NULL,40,'2014-06-05',1,1),		--10056
		(102,1003,'Which continent is the largest continent?',NULL,40,'2014-06-05',1,1),		--10057
		(102,1003,'Which ocean is the largest ocean in the world?',NULL,45,'2014-06-05',1,1),		--10058
		(102,1003,'Which country has the highest population in the world?',NULL,45,'2014-06-05',1,1),		--10059
		(102,1003,'What is the predominant language in Mexico?',NULL,50,'2014-06-05',1,1),		--10060
		(102,1003,'What country has the highest temperatures in the world?',NULL,55,'2014-06-05',1,1),		--10061
		(102,1003,'What country do Panda Bears come from?',NULL,45,'2014-06-05',1,1),		--10062
		(102,1003,'Which city is the capital of Brazil?',NULL,55,'2014-06-05',1,1),		--10063
		(102,1003,'What was Ho Chi Minh City once called?',NULL,50,'2014-06-05',1,1),		--10064
		(102,1003,'Which ocean does the Zambezi River in Africa flow into?',NULL,90,'2014-06-05',1,1),		--10065
		(102,1004,'What river is the longest river in the world?',NULL,70,'2014-06-05',1,1),		--10066
		(103,1000,'Which planet in our Solar System is the closest to the Sun?',NULL,45,'2014-06-05',1,1),		--10067
		(103,1000,'Between what two planets does the Asteroid Belt lie?',NULL,60,'2014-06-05',1,1),		--10068
		(103,1000,'What dwarf planet lies within the Asteroid Belt?',NULL,65,'2014-06-05',1,1),		--10069
		(103,1000,'What is the largest object in our Solar System?',NULL,50,'2014-06-05',1,1),		--10070
		(103,1000,'Which planet is known for having a "ring" around it?',NULL,30,'2014-06-05',1,1),		--10071
		(103,1000,'Which planet is know for having "The Great Red Spot"?',NULL,30,'2014-06-05',1,1),		--10072
		(103,1000,'What is it called when the Moon is between the Sun and the Earth?',NULL,45,'2014-06-05',1,1),		--10073
		(103,1000,'Which planet in the Solar System is closest in size to that of the Earth?',NULL,60,'2014-06-05',1,1),		--10074
		(103,1000,'What is the distance from the Earth to the Sun, in kilometers?',NULL,80,'2014-06-05',1,1),		--10075
		(103,1000,'What planet in our Solar System is the farthest away from the Sun?',NULL,60,'2014-06-05',1,1),		--10076
		(103,1000,'If Pluto ceased to be classified as a planet in 2006, what is it classified as now?',NULL,60,'2014-06-05',1,1),		--10077
		(105,1001,'What type of error is it called when you write an incorrect programming statement that the compiler does not like?',NULL,45,'2014-06-10',1,1),		--10078
		(105,1001,'What best describes what a database contains?',NULL,40,'2014-06-10',1,1),		--10079
		(105,1001,'What is the term for English-like representation of program code?',NULL,40,'2014-06-10',1,1),		--10080
		(105,1001,'What do you call memory locations, whose contents can vary or differ over time?',NULL,30,'2014-06-10',1,1),		--10081
		(105,1001,'What does SQL stand for?',NULL,40,'2014-06-10',1,1),		--10082
		(105,1001,'How best describes a Boolean?',NULL,30,'2014-06-10',1,1),		--10083
		(105,1001,'for (int i = 0; i < 10; i++)',NULL,50,'2014-06-10',1,1),		--10084
		(105,1001,'What does ERD mean in a database design context?',NULL,55,'2014-06-10',1,1),		--10085
		(105,1001,'What is the most common symbol used in an sql select statment that represents a wildcard?',NULL,25,'2014-06-10',1,1),		--10086
		(105,1001,'What name is given to a field in a database table that uniquely identifies a row of another table?',NULL,45,'2014-06-10',1,1),		--10087
		(105,1001,'What does CSS stand for?',NULL,40,'2014-06-10',1,1),		--10088
		(105,1001,'Javascript is best described as...?',NULL,40,'2014-06-10',1,1),		--10089
		(105,1001,'Which of the following SQL clauses is used to DELETE rows from a database table?',NULL,45,'2014-06-10',1,1),		--10090
		(105,1001,'What SQL keyword is used to only return different values?',NULL,40,'2014-06-10',1,1),		--10091
		(105,1001,'What SQL keyword is used to change values in an existing database table?',NULL,40,'2014-06-10',1,1),		--10092
		(105,1001,'What HTML tag will define text to be displayed as Bold?',NULL,30,'2014-06-10',1,1),		--10093
		(105,1001,'What ASP.NET component allows for consistent layout, look and feel, and standard behaviour for a group of pages in an application?',NULL,50,'2014-06-10',1,1),		--10094
		(105,1001,'What HTML tag is used to navigate to other content when clicked on?',NULL,35,'2014-06-10',1,1),		--10095
		(105,1001,'What HTML attribute does <UL> represent?',NULL,50,'2014-06-10',1,1),		--10096
		(105,1001,'Which HTML tag is used to create Dropdown Menus?',NULL,45,'2014-06-10',1,1),		--10097
		(105,1001,'Everything between an opening and closing tag in HTML is known as...?',NULL,45,'2014-06-10',1,1),		--10098
		(105,1001,'Who is credited with inventing HTML?',NULL,75,'2014-06-10',1,1),		--10099
		(105,1001,'Which HTML Heading Tag will produce the largest text?',NULL,45,'2014-06-10',1,1),		--10100
		(105,1001,'Which HTML attribute would you use to open a new window or link to an outside page?',NULL,40,'2014-06-10',1,1),		--10101
		(105,1001,'HTML tags use brackets to contain the information.  What notation do Cascading Style Sheets use?',NULL,45,'2014-06-10',1,1),		--10102
		(101,1002,'Colours that sit opposite each other on the Colour Wheel are called...?',NULL,90,'2014-07-01',1,1),		--10103
		(101,1002,'What is the Hex Value for the colour Black?',NULL,80,'2014-07-01',1,1),		--10104
		(101,1002,'What colour is missing in the visible light bands of "R O Y G B I V": Red, Orange, ??????, Green, Blue, Indigo and Violet?',NULL,35,'2014-07-01',1,1),		--10105
		(101,1002,'What colour automobile has been proven to be most visible and therefore less likely to be hit by another car?',NULL,55,'2014-07-01',1,1),		--10106
		(101,1002,'Which colour is favoured by the most people in the world?',NULL,40,'2014-07-01',1,1),		--10107
		(101,1002,'What colour, when used in fashion clothing, makes people appear thinner?',NULL,50,'2014-07-01',1,1),		--10108
		(101,1002,'What colour flag is waved and used as the universal symbol for a "Truce" or "Surrender"?',NULL,30,'2014-07-01',1,1),		--10109
		(102,1002,'What country''s national flag is known as the Union Jack or Union Flag?',NULL,55,'2014-07-01',1,1),		--10110
		(102,1002,'What is the capital of the United States of America?',NULL,55,'2014-07-01',1,1),		--10111
		(100,1004,'What mammal is the only mammal that can fly?',NULL,40,'2014-07-01',1,1),		--10112
		(100,1004,'How many stomachs does a cow have?',NULL,50,'2014-07-01',1,1)		--10113
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
		(10050,'USS Republic','USS Farragut','USS Defiant','USS Yorktown','USS Excelsior','USS Arizona',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10050
		(10051,'Yellow and Orange','Red and Green','Green and Blue','White and Black','Purple and Pink','Pink and Blue',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10051
		(10052,'Purple','Pink','Azure','Black','No Colour','White',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10052
		(10053,'Red','Blue','White','Orange','Green','Yellow',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10053
		(10054,'White','Black','Rainbow','No Colour','Neopolitain','Skittles',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10054
		(10055,'Orange, Green and Purple','Brown, Tan and Khaki','Green, Brown and Black','Yellow, Orange and Pink','Snap, Crackle and Pop','Red, Orange and Yellow',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10055
		(10056,'Antarctica','South America','Australia','South Africa','Arctica','Atlantis',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10056
		(10057,'Asia','Africa','South America','North America','Australia','Antarctica',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10057
		(10058,'Pacific Ocean','Indian Ocean','Arctic Ocean','Atlantic Ocean','Southern Ocean','Antarctic Ocean',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10058
		(10059,'China','United States','India','Australia','Canada','Transylvania',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10059
		(10060,'Spanish','Chinese','English','Hindu','French','Swahili',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10060
		(10061,'Indonesia','China','Brazil','Canada','India','Ethiopia',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10061
		(10062,'China','India','Canada','Australia','Spain','Japan',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10062
		(10063,'Brasilia','Rio de Janeiro','Salvador','Sao Sebastiao','Maranhao City','All of the above',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10063
		(10064,'Saigon','Manilla','Laos','Bangkok','Hong Kong','Gangnam',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10064
		(10065,'Indian Ocean','African Ocean','Pacific Ocean','Atlantic Ocean','Gulf of Mexico','Baltic Sea',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10065
		(10066,'Nile River','Amazon River','Mississippi River','Yang Tze River','St. Lawrence River','Yellow River',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10066
		(10067,'Mercury','Pluto','Saturn','Jupiter','Mars','Earth',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10067
		(10068,'Mars and Jupiter','Mercury and Venus','Jupiter and Saturn','Uranus and Neptune','Earth and Mars','Saturn and Uranus',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10068
		(10069,'Ceres','Andromeda','Pluto','Eris','Jupiter','Goofy',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10069
		(10070,'The Sun','The Moon','Jupiter','Saturn','Titan','Halley''s Comet',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10070
		(10071,'Saturn','Jupiter','Mercury','Earth','Mars','Venus',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10071
		(10072,'Jupiter','Saturn','Mercury','The Sun','Venus','The Earth',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10072
		(10073,'Solar Eclipse','Lunar Eclipse','Umbral Eclipse','Sunspot Activity','Solar Flare','Lunar Flare',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10073
		(10074,'Venus','Jupiter','Mars','Saturn','Mercury','Uranus',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10074
		(10075,'149,600,000 km','1,000,000 km','307,400,000 km','10,000,000 km','100,000,000 km','127,208,500 km',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10075
		(10076,'Neptune','Pluto','Uranus','Jupiter','Saturn','Mars',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10076
		(10077,'A Dwarf Planet','An Asteroid','A Tyrion Planet','A Class M Planetoid','LV-426','An Azure Nebula',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10077
		(10078,'Syntax Error','GUI Error','File Error','Invalid Input','Does Not Compute Error','Invalid Output',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10078
		(10079,'A group of tables','Names and addresses','Prices of merchandise','Terrorist information','Passenger seating information','Names of TV shows',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10079
		(10080,'Pseudocode','Binary Code','Machine Language','Secret Code','Da Vinci Code','Code Wheel',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10080
		(10081,'Variables','Constants','Javascript','Browser Cache','Credentials','Encryption',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10081
		(10082,'Structured Query Language','Sort, Query, List','Simple Question Language','Schema Quantitative Lexicon','Sortable Quantum Language','Semi Quarterly Listing',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10082
		(10083,'True or False','Truth or Consquences','Alien from another Galaxy','Vulcan Kolinahr','If, Else If and Else','For While Loop',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10083
		(10084,'10','11','9','0','20','42',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10084
		(10085,'Entity Relationship Diagram','Emergency Room Doors','Edemic Protein Dialysis','Entropic Relational Database','Emergency Rescue Disk','External Requirements Document',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10085
		(10086,'* (asterisk)','% (percent sign)','# (pound key)','&& (double ampersand)','$ (dollar sign)','@ (at sign)',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10086
		(10087,'Foreign Key','Primary Key','Tertiary Key','Left Inner Join','Referencing Key','Relational Key',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10087
		(10088,'Cascading Style Sheet','Corporate System Style','Central Style Sheet','Combination Style Sheet','Classic Software System','Coordinated Style Sheet',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10088
		(10089,'All of the answers listed','A Scripting Language','Client Side Scripts that may interact with the user','A script that can alter document content','Multi-paradigm language supporting object oriented, imperative and functional styles','Not a software platform or Java programming language',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10089
		(10090,'DELETE','DROP DATA','CLEAR','REMOVE','WIPE','ERASE',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10090
		(10091,'DISTINCT','UNIQUE','ALIAS','JOIN','INJECTION','UNION',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10091
		(10092,'UPDATE','CHANGE','ALTER','SUBSTITUTE','REPLACE','CLONE',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10092
		(10093,'<b></b>','<u></u>','<b><b>','<br></br>','<bo><ld>','<a bold></a>',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10093
		(10094,'A Master Page','A King Page','Am Emperor Form','A HTML Superpage','A Content Template','A Universal Site Page',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10094
		(10095,'Hyperlink','JumpToLink','SiteRedirect','Jumplink','Sooparlink','Batlink',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10095
		(10096,'Unordered List','Under Line','Ultra Link','Undefined Language','Universal Link','Under Score',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10096
		(10097,'<SELECT>','<DROPDOWN>','<MENU>','<OPTION>','<DD>','<PULLDOWN>',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10097
		(10098,'An Element','An Attribute','A Paragraph','A Heading','A Division','A Structure',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10098
		(10099,'Tim Berners-Lee','Albert Einstein','Steve Wozniak','Michael Mozilla','Charles Babbage','Bill Gates',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10099
		(10100,'<h1>','<h6>','<h5>','<h2>','<biggest>','<36pt>',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10100
		(10101,'target','src','start','redirect','metalink','hypertext',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10101
		(10102,'Curly Brackets','Square Brackets','Angle Brackets','Double Quotes','Round Brackets','Back Slashes',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10102
		(10103,'Complementary Colours','Opposite Colours','Bizarro Colours','Anti-Associate Colours','Refractory Colours','Social Colours',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10103
		(10104,'#000000','#FFFFFF','#000001','#999999','#666666','#H0H0H0',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10104
		(10105,'Yellow','Navy','Azure','Gold','White','Black',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10105
		(10106,'Silver','Red','Yellow','Orange','Green','Purple',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10106
		(10107,'Blue','Violet','Red','Yellow','Green','Brown',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10107
		(10108,'Black','Red','Blue','Green','White','Silver',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10108
		(10109,'A White Flag','A Checkered Flag','A Canadian Flag','A Green Flag','A Union Jack','A Jolly Roger',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10109
		(10110,'The United Kingdom','The United States','Canada','Australia','United Arab Emirates','Brazil',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10110
		(10111,'Washington, DC','New York, NY','Los Angeles, CA','Seattle, WA','Boston, MA','Philadelphia, PA',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10111
		(10112,'Bat','Ostrich','Squirrel','Kiwi','Penguin','Kangaroo',NULL,NULL,NULL,NULL,NULL,NULL,1),		--10112
		(10113,'One','Four','None','Three','Two','Five',NULL,NULL,NULL,NULL,NULL,NULL,1)		--10113
go

--Explanations Table (for non-Exam Modes)
insert into tbExplanations
(ExplnQuestionID,ExplnText,ExplnBit)
values	(10000,'A Cow is raised on dairy farms to produce milk and often makes Mooing sounds.',1),		--0
		(10001,'Polar Bears live in the Artic Circle and have white fur to blend in with the snow.',1),	--1
		(10002,'Lions belong to the Feline family of animals, typically any animal that is cat-like.',1),	--2
		(10003,'Snoopy is a Beagle, and was born on the Daisy Hill Puppy Farm.',1),		--3
		(10004,'A leopard is the feline animal that has spots.',1),		--4
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
		(10028,'Doctor McCoy''s first name is Leonard, and is played by DeForest Kelley.',1),		--28
		(10029,'Dilithium crystals,which when combined with matter and anti-matter, power the warp drives.',1),		--29
		(10030,'Ka''Plah means Success! but is often used as a salutation.  The correct spelling is Qapla.',1),		--30
		(10031,'Those small, furry creatures were called Tribbles, they come from Iota Geminorum IV.',1),		--31
		(10032,'Lieutenant Sulu''s shirt is Command Gold in the original Star Trek series.',1),		--32
		(10033,'Starfleet Headquarters is located in San Francisco, California, USA, Earth.',1),		--33
		(10034,'Spock''s father''s name is Sarek, his mother''s name is Amanda, both are from the planet Vulcan.',1),		--34
		(10035,'A Vulcan''s blood is tinted Green as it is copper based instead of iron based, like it is for humans.',1),		--35
		(10036,'The Captain of the USS Enterprise prior to James Kirk, was Christopher Pike, who was played by Jeffrey Hunter.',1),		--36
		(10037,'The Communications Officer on the Enterprise was Lieutenant Uhura, who was played by Nichelle Nichols.',1),		--37
		(10038,'The USS Intrepid was manned totally by Vulcans, it''s designation number was NCC-1631.',1),		--38
		(10039,'Doctor McCoy is affectionately called "Bones" by Captain Kirk.  McCoy replaced Mark Piper as CMO on the Enterprise.',1),		--39
		(10040,'A young Lieutenant James Kirk served aboard the USS Farragut under Captain Stephen Garrovick.',1),		--40
		(10041,'Zefram Cochrane is known for inventing the Warp Drive, which allowed for faster-than-light speed travel.',1),		--41
		(10042,'The fastest land animal on earth is the Cheetah, who has been clocked as fast as 120 kph.',1),		--42
		(10043,'These suicidal animals are known as Lemmings.  Driven by strong biological urges when the population becomes too great, every four years or so.',1),		--43
		(10044,'The largest bird in the world is the Ostrich, weighing up to 160 kilograms and can run up to 70 kph.',1),		--44
		(10045,'The only bird that is capable of flying backwards is the Hummingbird. Their wings can flap up to 200 times per second, making a humming noise.',1),		--45
		(10046,'The actor that portrayed Lieutenant Sulu was George Takei. He also appeared in six Star Trek movies playing Sulu.',1),		--46
		(10047,'Space, the Final Frontier.  These are the voyages of the Starship Enterprise, it''s FIVE year mission...',1),		--47
		(10048,'The total officer and crew complement of the USS Enterprise was 430, which was standard for a Constitution Class Starship.',1),		--48
		(10049,'The inventor of the Duotronic Computer System was Doctor Richard Daystrom, who also invented the less successful M-5 Multitronic System.',1),		--49
		(10050,'James Kirk''s first starship assignment was a field promoted Ensign aboard the USS Republic, NCC-1371',1),		--50
		(10051,'Yellow and Orange are known to make you hungry.  Many restaurants use these colours in menus and signs.',1),		--51
		(10052,'Combining Red with Blue makes Purple.  Purple symbolizes magic, mystery, spirituality, creativity, dignity, royalty!',1),		--52
		(10053,'The colour Red has the highest or longest wavelength, followed by Orange, Yellow, Green, Blue, Indigo, and Violet.',1),		--53
		(10054,'Combining the three Primary Colours; Red, Blue and Yellow, results in White.',1),		--54
		(10055,'Red & Blue = Purple, Blue & Yellow = Green, and Yellow & Red = Orange, so the answer is Purple, Green and Orange.',1),		--55
		(10056,'The Antarctica is the continent that is the furthest south, containing the geographic South Pole, which is the home of the Anti-Santa!',1),		--56
		(10057,'The largest of the continents is Asia, and comprises 30% of the land area on the earth.',1),		--57
		(10058,'The largest ocean is the Pacific Ocean, covering 46% of the world''s water surface, making it larger than all the land masses combined.',1),		--58
		(10059,'China has the largest population in the world, with over 1.3 billion people.',1),		--59
		(10060,'Spanish is the most predominant language spoken in Mexico.  While there are several other native indigenous languages in Mexico, most also speak Spanish.',1),		--60
		(10061,'Indonesia, with it''s average temperature of over 30 degrees celsius, is known as the hottest country in the world.',1),		--61
		(10062,'Panda Bears are native to south central China.  The Giant Panda hails mainly from the Sichuan Province.',1),		--62
		(10063,'To some extent or at some point in time, all of the above were capitals of Brazil, however the current capital is Brasilia.',1),		--63
		(10064,'Siagon was renamed Ho Chi Minh City in 1976, a year after it fell from a Communist victory.',1),		--64
		(10065,'The Zambezi River in Africa flows into the Indian Ocean. It is the fourth largest river in Africa after the Nile, Congo and Niger rivers.',1),		--65
		(10066,'The Nile River in Africa is the world''s longest river with a length of 6,650 kilometers and passes through 10 countries.',1),		--66
		(10067,'Mercury is the closest planet to our Sun, named after the swift-footed messenger god Mercury, due to it''s fast orbit.',1),		--67
		(10068,'The asteroid belt lies between Mars (the fourth of the terrestrial worlds), and Jupiter (the first of the gas giants).',1),		--68
		(10069,'Ceres is the largest object in the Asteroid Belt, 950 km in diameter but too dim to be seen without a telescope.',1),		--69
		(10070,'The Sun is by far the largest object in our Solar System, comprising of 99.8% of the total mass of all objects combined.',1),		--70
		(10071,'Saturn''s rings are made up of mostly ice and rock, ranging in size from a grain of salt to house-sized. ',1),		--71
		(10072,'The Great Red Spot, one of the most extraordinary features of Jupiter is three times the diameter of Earth.  It is a hurricane-like storm moving at speeds of 225 mph.',1),		--72
		(10073,'When the Moon is between the Earth and the Sun, this is called a Solar Eclipse.  The Earth between the Sun and the Moon is known as a Lunar Eclipse',1),		--73
		(10074,'Venus, although smaller than Earth by 600 km''s in diameter, is the closest in size to the Earth.',1),		--74
		(10075,'The distance from the Earth to The Sun is 149,600,000 kilometers, and has a surface temperature of 5,778 degrees Kelvin.',1),		--75
		(10076,'Neptune is the farthest planet from the Sun. If you answered Pluto, it ceased to meet the definitions of a planet on Aug 24, 2006, sorry!',1),		--76
		(10077,'Pluto was demoted from a Planet to Dwarf Planet, the official reason being that it was not the dominant gravitational body in it''s orbit.',1),			--77
		(10078,'A Syntax Error is the error given by the compiler when commands or words are not recognized.',1),			--78
		(10079,'A database contains groups of tables.  The tables may contain customer information, prices or almost any kind of data.',1),			--79
		(10080,'Pseudocode is an informal, high-level description of the operating principle of a computer program.',1),			--80
		(10081,'These are called Variables, or Identifiers.  Variables should contain no spaces, have meaningful names, should not start with numbers, and contain special characters.',1),			--81
		(10082,'Structured Query Language was originally developed at IBM in the early 1970''s for their IBM System R (relational db).',1),			--82
		(10083,'A Boolean has only two values, True or False.  Boolean expressions may use operators of AND, OR, XOR and NOT to determine either value.',1),			--83
		(10084,'"for (int i = 0; i < 10; i++)" will loop ten times, the first being zero and the last being nine.',1),			--84
		(10085,'Entity Relationship Diagram (ERD) is a data modeling technique that graphically illustrates a system''s entities and relationships between those entities.',1),			--85
		(10086,'The asterisk (*) represents a wildcard for any number of characters or values in an sql statement.  While there are other wildcard symbols, the asterisk is the most common.',1),			--86
		(10087,'A Foreign Key is a column or combination of columns that is used to establish and enforce a link between two tables.',1),			--87
		(10088,'Cascading Style Sheets (CSS) is a style sheet language used for describing the look and formatting of a document written in a markup language.',1),			--88
		(10089,'Javascript is a dynamic computer programming language, most commonly used as part of web browsers, to control the browser, communicate asynchronously and alter the document content that is displayed.',1),			--89
		(10090,'The DELETE clause is used to delete rows in a table.',1),			--90
		(10091,'In a table, a column may contain many duplicate values, using the DISTINCT keyword will cause only different values to display.',1),			--91
		(10092,'The UPDATE statement is used to update (change) existing records in a database table.',1),			--92
		(10093,'The <b> and </b> tags define the area between them as bold text.',1),			--93
		(10094,'A Master Page allows you to create a consistent layout that defines the look, feel, and behaviour that you want for a group of pages of individual content.',1),			--94
		(10095,'HTML Hyperlinks are found in nearly all web pages, and allow users to click their way from page to page.  It can be a word, group of words or an image.',1),			--95
		(10096,'An Unordered List starts with the <UL> tag, and each list item starts with the <LI> tag; and list items are marked with bullets and are un-numbered.',1),			--96
		(10097,'The <SELECT> element is used to create a drop-down list.  The <OPTION> tags inside the <SELECT> element define the available options.',1),			--97
		(10098,'Tags mark the beginning and end of Elements on an HTML document.  Most Elements can have attributes, and some elements can have empty content.',1),			--98
		(10099,'Ouch, a toughie!  Tim Berners-Lee is credited as being the inventor of HTML, the WWW, and the Web Browser.',1),			--99
		(10100,'By default, the <h1> tag will produce the largest text, and <h6> will produce the smallest.',1),			--100
		(10101,'The target attribute of the <a> tag specifies where to open a linked document.',1),			--101
		(10102,'Cascading Style Sheets (CSS) use Curly Brackets { and } to hold properties, colours, styles, font, etc. information.',1),			--102
		(10103,'Colours that are opposite each other on the Colour Wheel, such as Blue and Orange, are called Complementary Colours.',1),			--103
		(10104,'#000000 is the Hex Value for the colour Black.  Black is also often represented in RGB as 0,0,0 or CYMK as 0.00, 0.00, 0.00, 1.00.',1),			--104
		(10105,'Yellow is the colour that is missing in the sequence Red, Orange, YELLOW, Green, Blue, Indigo and Violet.',1),			--105
		(10106,'Silver is colour that is most visible on the road and in low-light conditions and is therefore least likely to be involved in an auto accident.',1),			--106
		(10107,'Blue is by far the most favorite colour of people world-wide, with 40% of the vote; with Purple a distant second at 14%.',1),			--107
		(10108,'Black clothing is popular in fashion because it appears to make people look thinner.  Black is also timeless and stylish.',1),			--108
		(10109,'A White Flag is the universal symbol of Truce or Surrender, in order to signal a desire to Parlay or Negotiate.',1),			--109
		(10110,'The Union Jack is the offical flag of The United Kingdom, but is also semi-official in some Commonwealth countries such as Canada, Jamaica and Singapore.',1),			--110
		(10111,'Washington, DC is the capital of The United States.  Congress, the Smithsonian, and Kennedy Center are also located in Washington, DC.',1),			--111
		(10112,'The Bat is the only mammal that can truly fly.  Other animals that are purported to fly can actually only glide for short distances.',1),			--112
		(10113,'A cow has only ONE stomach but that stomach has four distinct compartments.',1)			--113
go

--Scores Table
insert into tbScores
(ScoreUserID,ScoreCategoryID,ScoreTotalScore,ScoreAverageTime,ScoreTotalTime,ScoreDateTaken)
values	(1001,104,75,1.0,10,'2014-05-01'),
		(1002,100,80,.8,10,'2014-05-02'),
		(1003,104,95,.5,10,'2014-05-02'),
		(1001,104,42,.65,10,'2014-05-04')
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
				select UserLvl = -1 from tbUsers
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

--drop procedure spForgotPW
--procedure for users to reset password if forgotten
create procedure spForgotPW
(
    @UserEmail varchar (30),
    @UserPass varchar (30)
)
as
	begin
		if exists (select * from tbUsers where UserEmail = @UserEmail)
			begin
				update tbUsers set UserPass = @UserPass where UserEmail = @UserEmail
					if (@@error = 0)
					begin
						select 'Message' = 'Success' from tbUsers
					end        
			end
		else
			begin
				select 'Message' = 'Invalid Email' from tbUsers
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
--Upload Related Stored Procedures
--------------------------------------------------------------

--drop procedure spUploadCat
create procedure spUploadCat
(
	@CatName varchar (25),
	@CatDesc varchar (65)
)
as
	begin
		if exists (select * from tbCategory where CatName = @CatName)
			begin
				select CategoryID from tbCategory where CatName = @CatName 
			end
		else
			begin
				insert into tbCategory
				values	(@CatName,@CatDesc,1)
				select @@identity
			end
	end
go


--drop procedure spUploadQuestions
create procedure spUploadQuestions
(
	@QuestionCatID int,
	@QuestionUploader int = null,
	@QuestionText varchar (256)
)
as
	begin
		insert into tbQuestions
		values	(@QuestionCatID,1002,@QuestionText,NULL,60,getdate(),0,1)
		select @@identity
	end
go

--drop procedure spUploadAnswers
create procedure spUploadAnswers
(
	@AnswerQuestionID int,
	@AnswerCorrect varchar (256),
	@Answer1 varchar (256),
	@Answer2 varchar (256),
	@Answer3 varchar (256),
	@Answer4 varchar (256),
	@Answer5 varchar (256)
)
as
	begin
		insert into tbAnswers
		values	(@AnswerQuestionID,@AnswerCorrect,@Answer1,@Answer2,@Answer3,@Answer4,@Answer5,NULL,NULL,NULL,NULL,NULL,NULL,1)	
	end
go

--drop procedure spUploadExplanations
create procedure spUploadExplanations
(
	@ExplanationQuestionID int,
	@ExplanationText varchar (500)
)
as
	begin
		insert into tbExplanations
		values	(@ExplanationQuestionID,@ExplanationText,1)
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

--------------------------------------------------------------
--Quiz Related Stored Procedures
--------------------------------------------------------------

--drop procedure spGetCategory
--retrieves a list of categories where the questions have been approved by the administrator
create procedure spGetCategory
(
	@ApprovedOnly varchar (5)
)
as
	begin
	if @ApprovedOnly = 'yes'
		begin
			select c.CategoryID,c.CatName,c.CatDesc
			,COUNT(q.QuestionCatID) as QuestionsAvailable
			from tbCategory c
			left join tbQuestions q on q.QuestionCatID = c.CategoryID
			where q.QuestionApprovalBit = 1
			and q.QuestionBit = 1
			group by c.CategoryID,c.CatName,c.CatDesc
		end
	else if @ApprovedOnly = 'no'
		begin
			select c.CategoryID,c.CatName,c.CatDesc
			,COUNT(q.QuestionCatID) as QuestionsAvailable
			from tbCategory c
			left join tbQuestions q on q.QuestionCatID = c.CategoryID
			where q.QuestionBit = 1
			group by c.CategoryID,c.CatName,c.CatDesc
		end
	end
go

--drop view categoriesAll
create view categoriesAll
as
	select c.CategoryID,c.CatName,c.CatDesc
	,COUNT(q.QuestionCatID) as QuestionsAvailable
	from tbCategory c
	left join tbQuestions q on q.QuestionCatID = c.CategoryID
	where q.QuestionBit = 1
	group by c.CategoryID,c.CatName,c.CatDesc
go		

--drop view categoriesApproved
create view categoriesApproved
as
	select c.CategoryID as ApprovedCatID,COUNT(q.QuestionCatID) as QuestionsApproved
	from tbCategory c
	left join tbQuestions q on q.QuestionCatID = c.CategoryID
	where q.QuestionBit = 1
	and q.QuestionApprovalBit = 1
	group by c.CategoryID
go		

--drop view categoriesUnapproved
create view categoriesUnapproved
as
	select c.CategoryID as UnapprovedCatID,COUNT(q.QuestionCatID) as QuestionsUnapproved
	from tbCategory c
	left join tbQuestions q on q.QuestionCatID = c.CategoryID
	where q.QuestionBit = 1
	and q.QuestionApprovalBit = 0
	group by c.CategoryID
go	


--drop procedure spGetCategory2
create procedure spGetCategory2
as
	begin
		select * from categoriesAll ca
		full outer join categoriesApproved ap on ca.categoryID = ap.ApprovedCatID
		full outer join categoriesUnapproved un on ca.CategoryID = un.UnapprovedCatID
	end
go

--drop procedure spGetQuiz
--retrieves all questions in a specified category, along with answers and explanations
create procedure spGetQuiz
(
	@CatName varchar(25),
	@Difficulty varchar (10),
	@ApprovedOnly varchar (5)
)
as
	begin
		declare @CategoryID int
		set @CategoryID = (select CategoryID FROM tbCategory WHERE CatName = @CatName)
		if @ApprovedOnly = 'no'
		begin
			if @Difficulty = 'hard'
			begin
				select top 10 *,ROW_NUMBER() OVER (Order BY QuestionRecTime Asc) as DifficultyHard
				from tbQuestions q 
				join tbCategory c on c.CategoryID = @CategoryID
				join tbAnswers a on a.AnswerID = q.QuestionID
				join tbExplanations e on e.ExplnQuestionID = q.QuestionID
				where QuestionCatID = @CategoryID
			end
			else if @Difficulty = 'easy'
			begin
				select top 10 *,ROW_NUMBER() OVER (Order BY QuestionRecTime Desc) as DifficultyEasy
				from tbQuestions q 
				join tbCategory c on c.CategoryID = @CategoryID
				join tbAnswers a on a.AnswerID = q.QuestionID
				join tbExplanations e on e.ExplnQuestionID = q.QuestionID
				where QuestionCatID = @CategoryID
			end
			else if @Difficulty = 'medium'
			begin
				declare @middle int
				set @middle = (select (COUNT (*) / 2) from tbQuestions where QuestionCatID = @CategoryID)
				select top 10 * from (
				select *,ROW_NUMBER() OVER (Order BY QuestionRecTime Asc) as DifficultyMedium 
				from tbQuestions q 
				join tbCategory c on c.CategoryID = @CategoryID
				join tbAnswers a on a.AnswerID = q.QuestionID
				join tbExplanations e on e.ExplnQuestionID = q.QuestionID
				where QuestionCatID = @CategoryID) as newTable
				where newTable.DifficultyMedium between @middle -5 and @middle + 5
			end
		end
		else if @ApprovedOnly = 'yes'
		begin
			if @Difficulty = 'hard'
			begin
				select top 10 *,ROW_NUMBER() OVER (Order BY QuestionRecTime Asc) as DifficultyHard
				from tbQuestions q 
				join tbCategory c on c.CategoryID = @CategoryID
				join tbAnswers a on a.AnswerID = q.QuestionID
				join tbExplanations e on e.ExplnQuestionID = q.QuestionID
				where QuestionCatID = @CategoryID
				and QuestionApprovalBit = 1
			end
			else if @Difficulty = 'easy'
			begin
				select top 10 *,ROW_NUMBER() OVER (Order BY QuestionRecTime Desc) as DifficultyEasy
				from tbQuestions q 
				join tbCategory c on c.CategoryID = @CategoryID
				join tbAnswers a on a.AnswerID = q.QuestionID
				join tbExplanations e on e.ExplnQuestionID = q.QuestionID
				where QuestionCatID = @CategoryID
				and QuestionApprovalBit = 1
			end
			else if @Difficulty = 'medium'
			begin
				--declare @middle int
				set @middle = (select (COUNT (*) / 2) from tbQuestions where QuestionCatID = @CategoryID)
				select top 10 * from (
				select *,ROW_NUMBER() OVER (Order BY QuestionRecTime Asc) as DifficultyMedium 
				from tbQuestions q 
				join tbCategory c on c.CategoryID = @CategoryID
				join tbAnswers a on a.AnswerID = q.QuestionID
				join tbExplanations e on e.ExplnQuestionID = q.QuestionID
				where QuestionCatID = @CategoryID and QuestionApprovalBit = 1) as newTable
				where newTable.DifficultyMedium between @middle -5 and @middle + 5
			end
		end
	end
go

--drop procedure spUpdateDefaultTimes
create procedure spUpdateDefaultTimes
(
	@QuestionID int = null,
	@QuestionNewTime int = null
)
as
	begin
		update tbQuestions
		set QuestionRecTime = @QuestionNewTime
		where QuestionID = @QuestionID
	end
go




------------------------
--TEST QUERIES
------------------------

--spUploadQuestions
--@QuestionCatID = 105,
--@QuestionUploader = 1002,
--@QuestionText = 'what is the meaning of life?'
--go

--spUploadAnswers
--@AnswerQuestionID = 10103,
--@AnswerCorrect = 'yes',
--@Answer1 = 'no',
--@Answer2 = 'maybe',
--@Answer3 = 'not sure',
--@Answer4 = 'dunnos',
--@Answer5 = 'perhaps'
--go

--spUploadExplanations
--@QuestionID = 10103,
--@ExplanationText = 'None of the above, the answer is 42'

--select * from tbCategory
--select * from tbQuestions
--select * from tbAnswers
--select * from tbExplanations

--spUpdateDefaultTimes
--@QuestionID = 10000,
--@QuestionNewTime = 35

--spGetQuiz
--@CatName = 'colours',
--@Difficulty = 'easy',
--@ApprovedOnly = 'no'



