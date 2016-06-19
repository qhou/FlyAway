--


drop database if exists Airport;
create database Airport;

use Airport;

--
-- Now, add each table.
--

CREATE TABLE Customer (
CusID  integer,
CusName  varchar(45),
PhoneNum varchar(45),
Mileage integer,
primary key (CusID)
);

CREATE TABLE Airlines(
Abbreviation  varchar(45),
AirlineName  varchar(45),
Primary key  (abbreviation)
);

CREATE TABLE CrewMemberFor(
CrewID Integer,
CrewPosition varchar(45),
CrewName varchar(45),
Abbreviation varchar(45) NOT NULL,
Primary Key(CrewID, Abbreviation),
Foreign Key(Abbreviation) references Airlines(Abbreviation)
);

CREATE TABLE BelongsPlane(
PlaneID Integer,
Abbreviation varchar(45) NOT NULL,
PlaneStatus varchar(45),
Capacity Integer,
Primary Key(PlaneID, Abbreviation),
Foreign Key(Abbreviation) references Airlines(Abbreviation)
);

CREATE TABLE Flight(
FlightNum  integer,
Distance integer,
ToDateTime  datetime,
FromDateTime  datetime,
ToWhere  varchar(45),
FromWhere  varchar(45),
PlaneID  integer,
Abbreviation varchar(45),
Primary key  (FlightNum, FromDateTime, Abbreviation),
Foreign key  (PlaneID, Abbreviation)  references BelongsPlane(PlaneID, Abbreviation),
Foreign Key (Abbreviation) references Airlines(Abbreviation),
Check (FlightNum>0)
);

CREATE TABLE Reservation (
ConfirmationNum  integer,
CusID  integer,
FlightNum  integer,
Abbreviation  varchar(45),
primary key  (ConfirmationNum),
Foreign key  (CusID)  references Customer(CusID) on delete cascade,
Foreign key  (FlightNum)  references Flight(FlightNum) on delete cascade,
Foreign key(Abbreviation) references Airlines(Abbreviation) on delete cascade,
unique (ConfirmationNum,CusID,FlightNum,Abbreviation)
);


CREATE TABLE Luggage(
LuggageID  integer,
Weight  integer,
LuggageStatus  varchar(45),
LuggageType  varchar(45),
CusID  integer,
FlightNum Integer,
Abbreviation varchar(45),
Primary key  (luggageID),
Foreign key  (CusID) references Customer(CusID) on delete cascade,
Foreign key (FlightNum) references Flight(FlightNum),
Foreign key (Abbreviation) references Flight(Abbreviation)
);

CREATE TABLE HasCrewMember(
FlightNum Integer,
Abbreviation varchar(45),
CrewID Integer,
Primary Key(FlightNum, Abbreviation, CrewID),
Foreign Key(CrewID) references CrewMemberFor(CrewID) on delete set NULL,
Foreign Key(FlightNum) references Flight(FlightNum),
Foreign Key(Abbreviation) references Airlines(Abbreviation)
);

CREATE TABLE CheckIn(
CusID Integer,
FlightNum Integer,
CusStatus varchar(45),
Abbreviation varchar(45),
Primary Key(CusID, FlightNum, Abbreviation),
Foreign Key(FlightNum) references Flight(FlightNum),
Foreign Key(Abbreviation) references Flight(Abbreviation),
Foreign Key(CusID) references Customer(CusID) on Delete Cascade
);

Create View MyAccount(CusID,Abbreviation, FlightNum, ConfirmationNum, CusStatus) as
Select R.CusID, R. Abbreviation, R.FlightNum, R.ConfirmationNum, CI.CusStatus
From Reservation R Natural left outer join CheckIn CI;


insert into Customer values(13456893,'Boitumelo Porcher','9385628491',453);
insert into Customer values(84749384,'Ayo Ward','8493209472',234);
insert into Customer values(74390475,'Alex McBride','8473928472',78);
insert into Customer values(83750283,'Laurie Porter','8372947592',456);
insert into Customer values(73829754,'Tibby Prebensen','4726299338',345);
insert into Customer values(96851345,'Tomas Vasquez','1534567895',453);
insert into Customer values(45681278,'Kuroko Tetsuya','8465123578',20000);
insert into Customer values(13092473,'Bernard Hare','8034344195',718);
insert into Customer values(78954238,'Laurie Green','1237874122',46);
insert into Customer values(51684312,'Soren Bjerg','8465132157',34500);
insert into Customer values(48513355,'Lee Sang Hyeok','9534567895',59267);
insert into Customer values(78941453,'Peter Peng','4856512053',48615);
insert into Customer values(84561325,'Enrique Martinez','9456153258',71864);
insert into Customer values(84513877,'Im Yoona','8465137652',89845);
insert into Customer values(84651685,'Byun Baekhyun','8465187562',8465);
insert into Customer values(46841358,'Kim Namjoon','8465785201',6598);
insert into Customer values(91875873,'Suzy Bae','7658246852',68531);
insert into Customer values(91587527,'Wang Sicong','9542368752',7186);
insert into Customer values(34829784,'Jason Tran','8524687595',9845);
insert into Customer values(12547538,'Im Nayeon','5213584258',500);
insert into Customer values(21654032,'Irene Bae','1325468525',3158);
insert into Customer values(21354687,'Yoshitsugu  Matsuoka','2421358681',685);
insert into Customer values(21354852,'Song JoongKi','2013547895',20501);
insert into Customer values(01503468,'Chae Gwang Jin','2010548369',98450);
insert into Customer values(32135759,'Kurtis Lau Wai-kin',45826587,2156);


insert into Airlines values('ATT','Attawasol Airlines');
insert into Airlines values('JAL','Japan Airlines');
insert into Airlines values('ANA','All Nippon Airlines');
insert into Airlines values('AF','Air France');
insert into Airlines values('BA','British Airlines');
insert into Airlines values('AEY','Air Italy');
insert into Airlines values('EVA','EVA');
insert into Airlines values('CTL','Central Airlines');
insert into Airlines values('CSX','Choice Airways');
insert into Airlines values('LH','Lufthansa');
insert into Airlines values('KAL','Korean Air');
insert into Airlines values('EIN','Aer Lingus');
insert into Airlines values('JMG','JetMagic');



insert into CrewMemberFor values(21211628,'Captain','Hyun Shih', 'JMG');
insert into CrewMemberFor values(00099228,'Flight Attendant','Tina Bently', 'JMG');
insert into CrewMemberFor values(17384628,'Captain','Mike Hawk', 'AF');
insert into CrewMemberFor values(12919919,'Flight Attendant','Steve Hobbes', 'AF');
insert into CrewMemberFor values(20340555,'First Officer','Tetsuya Nomura', 'JAL');
insert into CrewMemberFor values(20921001, 'Pilot','Hassan Gooper', 'JAL');
insert into CrewMemberFor values(20340556,'Flight Attendant','John F Kennedy', 'JAL');
insert into CrewMemberFor values(83782472,'Captain','Puck Sternad', 'BA');
insert into CrewMemberFor values(21991972,'Flight Attendant','Nick Piglet', 'BA');
insert into CrewMemberFor values(7000234,'Flight Attendant','Lehua Vervloet', 'ATT');
insert into CrewMemberFor values(3299994,'Flight Attendant','Violet Singhs', 'ATT');
insert into CrewMemberFor values(12842824,'Captain','Charley Castellano', 'AF');
insert into CrewMemberFor values(90183891,'Captain','Barack Obama', 'AF');
insert into CrewMemberFor values(32048930,'Flight Attendant','Hollis Udo', 'AEY');
insert into CrewMemberFor values(43029849,'Flight Medic','Gomer Egemena', 'AEY');
insert into CrewMemberFor values(54383544,'Navigator','Jamie Alex', 'EVA');
insert into CrewMemberFor values(81927318,'Pilot','Yu Chifundo', 'EVA');
insert into CrewMemberFor values(02939249,'Flight Attendant','Courtney Sigi', 'CSX');
insert into CrewMemberFor values(22980333,'Flight Attendant','Puck Taylor', 'CSX');
insert into CrewMemberFor values(43294032,'Flight Medic','Shyama Gili', 'CTL');
insert into CrewMemberFor values(09808918,'Flight Attendant','Tom Jaylin', 'CTL');
insert into CrewMemberFor values(09439399,'Flight Attendant','Cho Eun Jung', 'KAL');
insert into CrewMemberFor values(77773727,'First Officer','Yoo Jae Suk', 'KAL');
insert into CrewMemberFor values(73299329,'Pilot','Kay Florence', 'EIN');
insert into CrewMemberFor values(212111117,'Flight Attendant','Donald Trump', 'EIN');
insert into CrewMemberFor values(281828117,'Pilo','Dony Goorer', 'ANA');
insert into CrewMemberFor values(000311117,'Flight Attendant','Donald Trump', 'ANA');



Insert into BelongsPlane values(43087, 'ATT', 'ready', '300');
Insert into BelongsPlane values(53218, 'JAL', 'Not Ready', '330');
Insert into BelongsPlane values(23812, 'ANA', 'Not Ready', '660');
Insert into BelongsPlane values(38274, 'AF', 'ready', '310');
Insert into BelongsPlane values(92874, 'BA', 'ready', '320');
Insert into BelongsPlane values(73948, 'AEY', 'ready', '300');
Insert into BelongsPlane values(24659, 'EVA', 'Not Ready', '330');
Insert into BelongsPlane values(92748, 'CTL', 'Not Ready', '660');
Insert into BelongsPlane values(51325, 'CSX', 'ready', '310');
Insert into BelongsPlane values(76582, 'LH', 'ready', '320');
Insert into BelongsPlane values(21532, 'KAL', 'ready', '300');
Insert into BelongsPlane values(23685, 'EIN', 'Not Ready', '330');
Insert into BelongsPlane values(85214, 'JMG', 'Not Ready', '660');
Insert into BelongsPlane values(21354, 'ATT', 'ready', '310');
Insert into BelongsPlane values(36521, 'JAL', 'ready', '320');
Insert into BelongsPlane values(74125, 'ANA', 'ready', '300');
Insert into BelongsPlane values(95236, 'AF', 'Not Ready', '330');
Insert into BelongsPlane values(14751, 'BA', 'Not Ready', '660');
Insert into BelongsPlane values(36215, 'AEY', 'ready', '310');
Insert into BelongsPlane values(32415, 'EVA', 'ready', '320');
Insert into BelongsPlane values(23654, 'CTL', 'ready', '300');
Insert into BelongsPlane values(87892, 'CSX', 'Not Ready', '330');
Insert into BelongsPlane values(74125, 'LH', 'Not Ready', '660');
Insert into BelongsPlane values(99821, 'KAL', 'ready', '310');
Insert into BelongsPlane values(74578, 'EIN', 'ready', '320');
Insert into BelongsPlane values(66325, 'JMG', 'ready', '300');
Insert into BelongsPlane values(85235, 'JAL', 'Not Ready', '330');
Insert into BelongsPlane values(63254, 'ANA', 'Not Ready', '660');
Insert into BelongsPlane values(32584, 'AF', 'ready', '310');
Insert into BelongsPlane values(76852, 'BA', 'ready', '320');
Insert into BelongsPlane values(25378, 'ATT', 'Not Ready', '330');
Insert into BelongsPlane values(65328, 'AEY', 'Not Ready', '660');
Insert into BelongsPlane values(78945, 'EVA', 'ready', '310');
Insert into BelongsPlane values(65421, 'CTL', 'ready', '320');
Insert into BelongsPlane values(74152, 'LH', 'Not Ready', '330');
Insert into BelongsPlane values(96354, 'KAL', 'Not Ready', '660');
Insert into BelongsPlane values(04566, 'EIN', 'ready', '310');
Insert into BelongsPlane values(05887, 'JMG', 'ready', '320');
Insert into BelongsPlane values(00257, 'CSX', 'ready', '320');


Insert into Flight Values(122, 7580, '2015-12-31 23:59:59', '2016-01-01 08:59:59', 'London', 'Vancouver', 43087, 'ATT');
Insert into Flight Values(868, 7580, '2015-01-31 23:59:59', '2016-02-01 08:59:59', 'France', 'Vancouver', 21354, 'ATT');
Insert into Flight Values(145, 7597, '2015-07-31 23:59:59','2016-07-01 09:59:59', 'Tokyo', 'Vancouver', 23812, 'ANA');
Insert into Flight Values(155, 7999, '2016-6-30 23:59:59', '2016-7-01 09:59:59', 'Tokyo', 'Vancouver', 74125, 'ANA');
Insert into Flight Values(234, 7597, '2014-6-30 23:59:59', '2014-7-01 09:59:59', 'Tokyo', 'Vancouver',53218, 'JAL');
Insert into Flight Values (123,1379,'2014-8-30 23:59:59', '2014-7-01 09:59:59', 'Vancouver','Tokyo',36521, 'JAL');
Insert into Flight Values (518,10649,'2014-1-01 23:59:59', '2014-1-02 09:59:59', 'Taipei', 'Los Angeles',24659, 'EVA');
Insert into Flight Values (629,9846,'2014-1-03 23:59:59', '2014-1-04 09:59:59', 'Taipei', 'Vancouver',32415, 'EVA');
Insert into Flight Values (003,8474,'2014-6-30 23:59:59', '2014-7-01 09:59:59', 'France', 'Vancouver',95236, 'AF');
Insert into Flight Values (398,1069,'2014-1-30 23:59:59', '2014-2-01 09:59:59', 'France', 'Berlin',32584, 'AF');
Insert into Flight Values (499,612,'2014-3-31 23:59:59', '2014-4-01 09:59:59', 'Florence', 'London', 14751, 'BA');
Insert into Flight Values (518,9669,'2014-4-30 23:59:59', '2014-5-01 09:59:59', 'Tokyo', 'London', 76852, 'BA');
Insert into Flight Values (128,1510,'2014-4-30 03:59:59', '2014-5-01 09:59:59', 'Dublin', 'Munich', 36215, 'AEY');
Insert into Flight Values (008,590,'2014-4-30 13:59:59', '2014-5-01 13:59:59', 'London', 'Dublin', 36215, 'AEY');
Insert into Flight Values (508,1510,'2014-01-30 23:59:59', '2014-02-01 09:59:59', 'Munich', 'Dublin', 65328, 'AEY');
Insert into Flight Values (510,9771,'2014-1-04 23:59:59', '2014-1-05 09:59:59', 'Florence', 'Los Angeles',23654, 'CTL');
Insert into Flight Values (118,8318,'2014-2-10 00:00:00', '2014-2-10 09:59:59', 'Halifax', 'Los Angeles',65421, 'CTL');
Insert into Flight Values (001,8318,'2014-1-04 18:10:00', '2014-1-05 000:00:00', 'Halifax', 'Los Angeles',51325, 'CSX');
Insert into Flight Values (129,1022,'2014-4-30 00:59:59', '2014-2-11 04:59:59', 'Vancouver', 'Los Angeles',87892, 'CSX');
Insert into Flight Values (123,1022,'2014-2-10 23:59:59', '2014-2-11 09:59:59', 'Los Angeles', 'Vancouver',00257, 'CSX');
Insert into Flight Values (902,9470,'2014-2-10 23:59:59', '2014-2-11 09:59:59', 'Munich', 'Los Angeles', 74125, 'LH');
Insert into Flight Values (299,8334,'2014-4-30 23:59:59', '2014-5-01 09:59:59', 'Vancouver', 'Berlin',74152, 'LH');
Insert into Flight Values (308,8334,'2014-4-30 23:59:59', '2014-5-01 09:59:59', 'Vancouver', 'Berlin',76582, 'LH');
Insert into Flight Values (998,4564,'2014-1-03 23:59:59', '2014-1-03 09:59:59', 'Seoul', 'Vancouver', 96354, 'KAL');
Insert into Flight Values (590,9310,'2014-1-03 23:59:59', '2014-1-04 09:59:59', 'Seoul', 'Los Angeles', 96354, 'KAL');
Insert into Flight Values (777,8128,'2014-2-10 23:59:59', '2014-2-11 09:59:59', 'Dublin', 'Los Angeles', 04566, 'EIN');
Insert into Flight Values (181,7499,'2014-2-12 23:59:59', '2014-2-13 09:59:59', 'Vancouver', 'Dublin', 74578, 'EIN');
Insert into Flight Values (773,8318,'2014-2-12 23:59:59', '2014-2-12 09:59:59', 'Halifax', 'Los Angeles', 05887, 'JMG');
Insert into Flight Values (778,1022,'2014-4-30 23:59:59', '2014-5-01 09:59:59', 'Vancouver', 'Los Angeles', 66325, 'JMG');


Insert into Luggage values(268273,14,'check-in','check-in',84749384, 145, 'JAL');
Insert into Luggage values(875829,23,'check-in','check-in',13456893, 155, 'ANA');
Insert into Luggage values(928485,5,'on-plane','carry-on',84749384, 145, 'JAL');
Insert into Luggage values(984759,3,'on-plane','check-in',74390475, 122, 'BA');
Insert into Luggage values(985739,18,'check-in','check-in',73829754, 868, 'AF');
Insert into Luggage values(985735,18,'check-in','check-in',1503468, 868, 'KAL');
Insert into Luggage values(990999,8,'on-plane','carry-on',1503468, 998, 'KAL');
Insert into Luggage values(999938,9,'check-in','check-in',1503468, 145, 'ANA');
Insert into Luggage values(999937,11,'check-in','check-in',1503468, 145, 'ANA');
Insert into Luggage values(000118,10,'check-in','check-in',1503468, 145, 'KAL');
Insert into Luggage values(088818,11,'check-in','check-in',13092473, 868, 'ATT');
Insert into Luggage values(999118,14,'removed','check-in',74390475, 122, 'ATT');
Insert into Luggage values(777118,12,'check-in','check-in',84749384, 003, 'AF');
Insert into Luggage values(777119,11,'check-in','check-in',13092473, 499, 'BA');
Insert into Luggage values(717171,14,'check-in','check-in',84749384, 998, 'KAL');
Insert into Luggage values(199191,13,'check-in','check-in',84651685, 123, 'JAL');
Insert into Luggage values(611112,12,'check-in','check-in',84651685, 155, 'ANA');
Insert into Luggage values(699999,1,'check-in','check-in',84651685, 629, 'EVA');
Insert into Luggage values(129192, 8, 'check-in','check-in',84651685, 629, 'EVA');
Insert into Luggage values(121111,14,'check-in','check-in',13456893, 518, 'BA');
Insert into Luggage values(699998,13,'check-in','check-in',13456893, 518, 'BA');
Insert into Luggage values(699997,35,'check-in','check-in',12547538, 629, 'AEY');
Insert into Luggage values(699969,30,'check-in','check-in',12547538, 155, 'ANA');
Insert into Luggage values(699995,1,'check-in','check-in',84651685, 998, 'KAL');
Insert into Luggage values(694499,24,'check-in','check-in',84651685, 590, 'KAL');
Insert into Luggage values(693399,20,'check-in','check-in',21654032, 998, 'KAL');
Insert into Luggage values(692299,28,'check-in','check-in',21654032, 590, 'KAL');
Insert into Luggage values(691199,29,'check-in','check-in',21654032, 155, 'ANA');
Insert into Luggage values(699009,24,'check-in','check-in',34829784, 008, 'AEY');
Insert into Luggage values(6990199,37,'check-in','check-in',34829784, 128, 'AEY');
Insert into Luggage values(602999,24,'check-in','check-in',46841358, 001, 'CSX');
Insert into Luggage values(039999,21,'check-in','check-in',46841358, 129, 'CSX');
Insert into Luggage values(049999,7,'check-in','check-in',46841358, 123, 'CSX');
Insert into Luggage values(059999,6,'check-in','check-in',32135759, 510, 'CTL');
Insert into Luggage values(069999,5,'check-in','check-in',78954238, 118, 'CTL');
Insert into Luggage values(709999,4,'check-in','check-in',83750283, 001, 'CSX');
Insert into Luggage values(809999,3,'check-in','check-in',48513355, 145, 'JAL');
Insert into Luggage values(909999,2,'check-in','check-in',48513355, 155, 'ANA');
Insert into Luggage values(100999,1,'check-in','check-in',78941453, 129, 'CSX');
Insert into Luggage values(101010,10,'check-in','check-in', 21354852, 145, 'ANA');
Insert into Luggage values(199119,11,'check-in','check-in', 21354852, 234, 'JAL');
Insert into Luggage values(171711,3,'check-in','check-in',21354852, 123, 'JAL');
Insert into Luggage values(000100,11,'check-in','check-in', 21354852, 998, 'KAL');
Insert into Luggage values(188181,23,'check-in','check-in', 21354852, 590, 'KAL');
Insert into Luggage values(010999,22,'check-in','check-in', 51684312, 902, 'LH');
Insert into Luggage values(191919,21,'check-in','check-in', 51684312, 299, 'LH');
Insert into Luggage values(611099,20,'check-in','check-in', 51684312, 308, 'LH');
Insert into Luggage values(009999,13,'check-in','check-in', 51684312, 123, 'CSX');
Insert into Luggage values(111199,10,'check-in','check-in',91875873, 518, 'EVA');
Insert into Luggage values(291819,12,'check-in','check-in', 91875873, 398, 'EVA');
Insert into Luggage values(291011,8,'check-in','check-in', 91875873, 998, 'KAL');
Insert into Luggage values(199199,9,'check-in','check-in', 91875873, 590, 'KAL');
Insert into Luggage values(828282,11,'check-in','check-in', 96851345, 123, 'CSX');
Insert into Luggage values(399393,20,'check-in','check-in', 91587527, 902, 'LH');
Insert into Luggage values(382828,30,'check-in','check-in', 91587527, 299, 'LH');
Insert into Luggage values(829999,8,'check-in','check-in', 73829754, 181, 'EIN');
Insert into Luggage values(010110,9,'check-in','check-in', 21354687, 778, 'JMG');



Insert into Reservation Values (1234, 1503468, 998, 'KAL');
Insert into Reservation Values (1222, 1503468, 590, 'ANA');
Insert into Reservation Values (4524, 12547538, 145, 'ANA');
Insert into Reservation Values (1444, 13092473, 868, 'ATT');
Insert into Reservation Values (2315, 74390475, 122, 'ATT');
Insert into Reservation Values (8456, 84749384, 003, 'AF');
Insert into Reservation Values (9785, 13092473, 499, 'BA');
Insert into Reservation Values (7851, 84749384, 398, 'AF');
Insert into Reservation Values (8521, 84651685, 998, 'KAL');
Insert into Reservation Values (8857, 84651685, 123, 'JAL');
Insert into Reservation Values (0213, 84651685, 155, 'ANA');
Insert into Reservation Values (3054, 84651685, 629, 'EVA');
Insert into Reservation Values (9787, 13456893, 518, 'BA');
Insert into Reservation Values (5874, 84561325, 128, 'AEY');
Insert into Reservation Values (2135, 12547538, 629, 'EVA');
Insert into Reservation Values (9485, 12547538, 155, 'ANA');
Insert into Reservation Values (5462, 12547538, 998, 'KAL');
Insert into Reservation Values (7456, 12547538, 590, 'KAL');
Insert into Reservation Values (8563, 21654032, 998, 'KAL');
Insert into Reservation Values (9853, 21654032, 590, 'KAL');
Insert into Reservation Values (2348, 21654032, 155, 'ANA');
Insert into Reservation Values (5132, 34829784, 008, 'AEY');
Insert into Reservation Values (5133, 34829784, 128, 'AEY');
Insert into Reservation Values (9637, 46841358, 001, 'CSX');
Insert into Reservation Values (6321, 46841358, 129, 'CSX');
Insert into Reservation Values (3682, 46841358, 123, 'CSX');
Insert into Reservation Values (9863, 45681278, 508, 'AEY');
Insert into Reservation Values (3512, 32135759, 510, 'CTL');
Insert into Reservation Values (7852, 78954238, 118, 'CTL');
Insert into Reservation Values (3215, 83750283, 001, 'CSX');
Insert into Reservation Values (6852, 48513355, 145, 'JAL');
Insert into Reservation Values (1523, 48513355, 155, 'ANA');
Insert into Reservation Values (9865, 78941453, 129, 'CSX');
Insert into Reservation Values (1235, 21354852, 145, 'ANA');
Insert into Reservation Values (9968, 21354852, 234, 'JAL');
Insert into Reservation Values (5125, 21354852, 123, 'JAL');
Insert into Reservation Values (9963, 21354852, 998, 'KAL');
Insert into Reservation Values (1524, 21354852, 590, 'KAL');
Insert into Reservation Values (9635, 51684312, 902, 'LH');
Insert into Reservation Values (1584, 51684312, 299, 'LH');
Insert into Reservation Values (9967, 51684312, 308, 'LH');
Insert into Reservation Values (1845, 51684312, 123, 'CSX');
Insert into Reservation Values (9631, 91875873, 518, 'EVA');
Insert into Reservation Values (8451, 91875873, 398, 'EVA');
Insert into Reservation Values (1111, 91875873, 998, 'KAL');
Insert into Reservation Values (1745, 91875873, 590, 'KAL');
Insert into Reservation Values (9638, 96851345, 123, 'CSX');
Insert into Reservation Values (8455, 91587527, 902, 'LH');
Insert into Reservation Values (8457, 91587527, 299, 'LH');
Insert into Reservation Values (9861, 73829754, 181, 'EIN');
Insert into Reservation Values (1568, 21354687, 778, 'JMG');


Insert into CheckIn Values(1503468,998,'check-in', 'KAL');
Insert into CheckIn Values(1503468,590,'boarded', 'ANA');
Insert into CheckIn Values(12547538,145,'check-in', 'ANA');
Insert into CheckIn Values(13092473,868,'cancelled', 'ATT');
Insert into CheckIn Values(74390475,122,'boarded', 'ATT');
Insert into CheckIn Values(84749384,398,'check-in', 'AF');
Insert into CheckIn Values(13092473,499,'check-in', 'BA');
Insert into CheckIn Values(84749384,003,'check-in', 'AF');
Insert into CheckIn Values(84651685,998,'check-in', 'KAL');
Insert into CheckIn Values(84651685,155,'check-in', 'ANA');
Insert into CheckIn Values(84651685,234,'check-in', 'JAL');
Insert into CheckIn Values(84651685,518,'check-in', 'EVA');
Insert into CheckIn Values(13456893,518,'check-in', 'AF');
Insert into CheckIn Values(84561325,128,'check-in', 'AEY');
Insert into CheckIn Values(12547538,629,'check-in', 'EVA');
Insert into CheckIn Values(12547538,155,'check-in', 'ANA');
Insert into CheckIn Values(12547538,998,'check-in', 'KAL');
Insert into CheckIn Values(12547538,590,'check-in', 'KAL');
Insert into CheckIn Values(21654032,998,'check-in', 'KAL');
Insert into CheckIn Values(21654032,590,'check-in', 'KAL');
Insert into CheckIn Values(21654032,155,'check-in', 'ANA');
Insert into CheckIn Values(34829784,008,'check-in', 'AEY');
Insert into CheckIn Values(34829784,128,'check-in', 'AEY');
Insert into CheckIn Values(46841358,001,'check-in', 'CSX');
Insert into CheckIn Values(46841358,129,'check-in', 'CSX');
Insert into CheckIn Values(46841358,123,'check-in', 'CSX');
Insert into CheckIn Values(45681278,508,'check-in', 'AEY');
Insert into CheckIn Values(32135759,510,'check-in', 'CTL');
Insert into CheckIn Values(78954238,118,'check-in', 'CTL');
Insert into CheckIn Values(83750283,001,'check-in', 'CSX');
Insert into CheckIn Values(48513355,145,'check-in', 'JAL');
Insert into CheckIn Values(48513355,155,'check-in', 'ANA');
Insert into CheckIn Values(78941453,129,'check-in', 'CSX');
Insert into CheckIn Values(21354852,145,'check-in', 'ANA');
Insert into CheckIn Values(21354852,234,'check-in', 'JAL');
Insert into CheckIn Values(21354852,123,'check-in', 'JAL');
Insert into CheckIn Values(21354852,998,'check-in', 'KAL');
Insert into CheckIn Values(21354852,590,'check-in', 'KAL');
Insert into CheckIn Values(51684312,902,'check-in', 'LH');
Insert into CheckIn Values(51684312,299,'check-in', 'LH');
Insert into CheckIn Values(51684312,308,'check-in', 'LH');
Insert into CheckIn Values(51684312,123,'check-in', 'CSX');
Insert into CheckIn Values(91875873,518,'check-in', 'EVA');
Insert into CheckIn Values(91875873,398,'check-in', 'EVA');
Insert into CheckIn Values(91875873,998,'check-in', 'KAL');
Insert into CheckIn Values(91875873,590,'check-in', 'KAL');
Insert into CheckIn Values(96851345,123,'check-in', 'CSX');
Insert into CheckIn Values(91587527,902,'check-in', 'LH');
Insert into CheckIn Values(91587527,299,'check-in', 'LH');
Insert into CheckIn Values(73829754,181,'check-in', 'EIN');
Insert into CheckIn Values(21354687,778,'check-in', 'JMG');

Insert into HasCrewMember values(773, 'JMG', 21211628);
Insert into HasCrewMember values(778, 'JMG', 00099228);
Insert into HasCrewMember values(499, 'BA', 83782472);
Insert into HasCrewMember values(518, 'BA', 21991972);
Insert into HasCrewMember values(003, 'AF', 90183891);
Insert into HasCrewMember values(398, 'AF', 12842824);
Insert into HasCrewMember values(003, 'AF', 12919919);
Insert into HasCrewMember values(234, 'JAL', 20340555);
Insert into HasCrewMember values(123, 'JAL', 20921001);
Insert into HasCrewMember values(145, 'ANA', 281828117);
Insert into HasCrewMember values(155, 'ANA', 000311117);
Insert into HasCrewMember values(122, 'ATT', 3299994);
Insert into HasCrewMember values(868, 'ATT', 7000234);
Insert into HasCrewMember values(128, 'AEY', 32048930);
Insert into HasCrewMember values(008, 'AEY', 43029849);
Insert into HasCrewMember values(518, 'EVA', 54383544);
Insert into HasCrewMember values(629, 'EVA', 81927318);
Insert into HasCrewMember values(001, 'CSX', 02939249);
Insert into HasCrewMember values(123, 'CSX', 22980333);
Insert into HasCrewMember values(510, 'CTL', 43294032);
Insert into HasCrewMember values(118, 'CTL', 09808918);
Insert into HasCrewMember values(998, 'KAL', 09439399);
Insert into HasCrewMember values(590, 'KAL', 09439399);
Insert into HasCrewMember values(777, 'EIN', 73299329);
Insert into HasCrewMember values(181, 'EIN', 73299329);
    
Delimiter $$
Create Trigger updatemileage After Update on Checkin
    For Each Row
    Begin
        If New.CusStatus='boarded' then
            update Customer C, Flight F set C.mileage =C.Mileage+F.Distance where New.CusID=C.CusID and F.FlightNum=New.FlightNum and F.abbreviation=New.Abbreviation;
        elseIf  New.CusStatus='cancelled' then
            update Luggage L set L.LuggageStatus ='removed' where New.CusID=L.CusID and L.FlightNum=New.FlightNum and L.abbreviation=New.Abbreviation;
        END IF;
    END;





