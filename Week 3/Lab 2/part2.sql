
CREATE TABLE Student
(
	StudentID            INTEGER NOT NULL ,
	StudentName          VARCHAR2(50) NULL ,
CONSTRAINT  XPKStudent PRIMARY KEY (StudentID)
);

CREATE TABLE Application
(
	ApplicationNo        INTEGER NOT NULL ,
	StudentID            INTEGER NOT NULL ,
	App_Year             INTEGER NULL ,
CONSTRAINT  XPKApplication PRIMARY KEY (ApplicationNo,StudentID,App_Year)
);

CREATE TABLE Address
(
	Street               VARCHAR2(100) NOT NULL ,
	StudentID            INTEGER NOT NULL ,
	State                VARCHAR2(30) NULL ,
	ZipCode              VARCHAR2(7) NULL ,
CONSTRAINT  XPKAddress PRIMARY KEY (Street,StudentID)
);

CREATE TABLE Reference
(
	ReferenceStatement   VARCHAR2(500) NOT NULL ,
	StudentID            INTEGER NOT NULL ,
	ReferenceName        VARCHAR2(100) NULL ,
	RefInstitution       VARCHAR2(100) NULL ,
CONSTRAINT  XPKReference PRIMARY KEY (ReferenceStatement,StudentID)
);

CREATE TABLE PriorSchool
(
	PriorSchool_Id       INTEGER NOT NULL ,
	StudentID            INTEGER NOT NULL ,
	PriorSchoolAddr      VARCHAR2(100) NULL ,
	GPA                  NUMBER(2) NULL ,
CONSTRAINT  XPKPriorSchool PRIMARY KEY (PriorSchool_Id,StudentID)
);

ALTER TABLE Application
	ADD (CONSTRAINT R_3 FOREIGN KEY (StudentID) REFERENCES Student (StudentID));

ALTER TABLE Address
	ADD (CONSTRAINT R_2 FOREIGN KEY (StudentID) REFERENCES Student (StudentID));

ALTER TABLE Reference
	ADD (CONSTRAINT R_4 FOREIGN KEY (StudentID) REFERENCES Student (StudentID));

ALTER TABLE PriorSchool
	ADD (CONSTRAINT R_1 FOREIGN KEY (StudentID) REFERENCES Student (StudentID));
	
	
insert into Student values(1,'Mark');
insert into Student values(2,'Sarah');
insert into Student values(3,'Paul');
insert into Student values(4,'Jack');
insert into Student values(5,'Mary');
insert into Student values(6,'Susan');

insert into Address values('Grafton Street',1,'New York','NY234');
insert into Address values('White Street',1,'Florida','Flo435');
insert into Address values('Green Road',2,'California','Cal123');
insert into Address values('Red Crescent',3,'Carolina','Ca455');
insert into Address values('Yellow Park',3,'Mexico','Mex1');
insert into Address values('Dartry Road',4,'Ohio','Oh34');
insert into Address values('Malahide Road',5,'Ireland','IRE');
insert into Address values('Black Bay',5,'Kansas','Kan45');
insert into Address values('River Road',6,'Kansas','Kan45');

insert into Reference values ('Good guy',1,'Dr. Jones','Trinity College');
insert into Reference values ('Very Good guy',1,'Dr. Jones','U Limerick');
insert into Reference values ('Perfect',2,'Dr. Byrne','DIT');
insert into Reference values ('Average',2,'Dr. Byrne','UCD');
insert into Reference values ('Poor',3,'Dr. Jones','Trinity College');
insert into Reference values ('Excellent',3,'Prof. Cahill','UCC');
insert into Reference values ('Fair',4,'Prof. Lillis','DIT');
insert into Reference values ('Good girl',5,'Prof. Lillis','DIT');
insert into Reference values ('Perfect',5,'Dr. Byrne','DIT');
insert into Reference values ('Messy',6,'Prof. Cahill','UCC');

insert into PriorSchool values (1,1,'Castleknock',65);
insert into PriorSchool values (2,1,'Loreto College',87);
insert into PriorSchool values (1,2,'Castleknock',90);
insert into PriorSchool values (3,2,'St. Patrick',76);
insert into PriorSchool values (4,2,'DBS',66);
insert into PriorSchool values (5,2,'Harvard',45);
insert into PriorSchool values (1,3,'Castleknock',45);
insert into PriorSchool values (3,3,'St. Patrick',67);
insert into PriorSchool values (4,3,'DBS',23);
insert into PriorSchool values (5,3,'Harvard',67);
insert into PriorSchool values (3,4,'St. Patrick',29);
insert into PriorSchool values (4,4,'DBS',88);
insert into PriorSchool values (5,4,'Harvard',66);
insert into PriorSchool values (3,5,'St. Patrick',44);
insert into PriorSchool values (4,5,'DBS',55);
insert into PriorSchool values (5,5,'Harvard',66););
insert into PriorSchool values (1,5,'Castleknock',74);
insert into PriorSchool values (1,6,'Castleknock',88);
insert into PriorSchool values (3,6,'St. Patrick',77);
insert into PriorSchool values (4,6,'DBS',56);
insert into PriorSchool values (2,6,'Loreto College',45);

insert into Application values (1,1,2003);
insert into Application values (1,1,2004);
insert into Application values (2,1,2007);
insert into Application values (3,1,2012);
insert into Application values (2,2,2010);
insert into Application values (2,2,2011);
insert into Application values (2,2,2012);
insert into Application values (1,3,2012);
insert into Application values (3,3,2008);
insert into Application values (1,4,2009);
insert into Application values (2,5,2009);
insert into Application values (1,5,2005);
insert into Application values (3,6,2011);









