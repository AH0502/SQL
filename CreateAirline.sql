CREATE TABLE Airports(
	AID INTEGER auto_increment PRIMARY KEY,
    Code VARCHAR(3) UNIQUE NOT NULL,
    City varchar(20) NOT NULL,
    State varchar(2) NOT NULL,
    Gate Integer NOT NULL CONSTRAINT Gate_Num Check (Gate > 0)
    );
    
    
CREATE TABLE Routes(
	RouteNum INTEGER auto_increment PRIMARY KEY,
    Origin INTEGER NOT NULL,
    OGate INTEGER NOT NULL CONSTRAINT Ogate_Num Check (OGate > 0),
    DEST INTEGER NOT NULL,
    DGate INTEGER NOT NULL CONSTRAINT Dgate_Num Check (DGate > 0),
    Foreign Key (Origin) References Airports(AID) ON DELETE CASCADE,
    Foreign Key (DEST) References Airports(AID) ON DELETE CASCADE,
    CONSTRAINT Gate_Chk Check (Origin != DEST)
    );


CREATE TABLE Flights (
	RouteNum INTEGER NOT NULL,
    Date Datetime NOT NULL,
    Price DECIMAL NOT NULL,
    FOREIGN KEY (RouteNum) References Routes(RouteNum) ON DELETE CASCADE
);
    
    
CREATE TABLE Passengers (
PID INTEGER AUTO_INCREMENT PRIMARY KEY,
fname varchar(20) NOT NULL,
lname varchar(20) NOT NULL,
addr varchar(30) NOT NULL,
state char(2) NOT NULL,
zip varchar(5) NOT NULL 
);


CREATE TABLE PassengerPhone (
PhoneID Integer auto_increment PRIMARY KEY,
PID Integer NOT NULL,
PhoneNum varchar(15) NOT NULL,
FOREIGN KEY (PID) References Passengers(PID)
);


CREATE TABLE Bookings (
BID INTEGER AUTO_INCREMENT PRIMARY KEY,
PID INTEGER NOT NULL,
FlightNum INTEGER NOT NULL,
FOREIGN KEY (PID) References Passengers(PID) ON DELETE CASCADE,
FOREIGN KEY (RouteNum) References Flights(RouteNum) ON DELETE CASCADE ON UPDATE CASCADE
);
# Had a problem here where I realized that i needed to make a new primary key for the Flights table due to me misunderstanding the assignment specifications.
alter table Flights
Rename Column Date to FlightDate;

alter table Flights
MODIFY column FlightDate DATE;

alter table Flights
Modify column Price Decimal(5, 2);

alter table Flights
ADD COLUMN FlightNum INTEGER FIRST;
/* Created the 'FlightNum' column which will eventually be the PK.
Need to drop the foreign key constraint in the 'Bookings' table.
Then I can modfiy the RouteNum column */

select * from Flights;
alter table Flights 
MODIFY COLUMN RouteNum INTEGER NOT NULL;
alter table Bookings
Drop FOREIGN KEY bookings_ibfk_2;
show create table Bookings;

select * from Flights;
alter table Flights
Modify column RouteNum INTEGER NOT NULL;
# RouteNum still used in foreign key apparently, so need to drop that
alter table Flights
DROP foreign KEY flights_ibfk_1;
select * from Flights;
# now we should be able to add primary key and fix foreign key constraints
# need to drop primary key first
Alter table Flights
Drop Primary key;
Alter table Flights
Modify column FlightNum Integer Auto_increment PRIMARY KEY;
select * from Flights;

#test
INSERT INTO Flights (RouteNum, FlightDate, Price) Values
(1, '2022-05-01', 120.01);
select * from Flights;

show create table bookings;
alter table Bookings
rename column RouteNum to FlightNum;
alter table Bookings
Add Foreign Key (FlightNum) References Flights(FlightNum);
show create table Flights;
alter table Flights
add foreign key (RouteNum) References Routes(RouteNum) ON DELETE CASCADE;
alter table Bookings
modify column BID Integer auto_increment;
SHOW CREATE TABLE BOOKINGS;


    

    
    
    
