/* A New Database Phase2 is created using the code : CREATE SCHEMA phase2;
Next Process is creating Tables in Phase2 database
 */
 CREATE SCHEMA phase2;
 
 /* Change Database */
 use phase2;
 
 -- DROP TABLE---
 DROP TABLE INSTRUCTOR;
DROP TABLE TT;
DROP TABLE PHD_STUDENT;
DROP TABLE GRA;
DROP TABLE GTA;
DROP TABLE SELF_SUPPORT;
DROP TABLE SCHOLARSHIP_SUPPORT;
DROP TABLE COURSE;
DROP TABLE COURSESTAUGHT;
DROP TABLE MILESTONE;
DROP TABLE MILESTONESPASSED;
DROP TABLE GRANTSS;
DROP TABLE GRANTSASSOCIATED;
DROP TABLE PHDCOMMITTEE;
DROP TABLE SECTION;

 -- CREATE TABLES--

CREATE TABLE INSTRUCTOR (									
	InstructorId VARCHAR(50) NOT NULL,
    FName VARCHAR(50) NOT NULL,
	LName VARCHAR(50) NOT NULL,
    StartDate VARCHAR(50) NOT NULL ,
    Degree  VARCHAR(50) NOT NULL,	
	Ranks  VARCHAR(50) NOT NULL,
	Typs VARCHAR(50),
    PRIMARY KEY (InstructorId)
	
);

CREATE TABLE TT(									
	InstructorId VARCHAR(50) NOT NULL,
    NoofPhStudents VARCHAR(50) NOT NULL,
    PRIMARY KEY (InstructorId),
          	FOREIGN KEY (InstructorId) REFERENCES INSTRUCTOR (InstructorId)
				ON DELETE CASCADE	ON UPDATE CASCADE
	           
);

CREATE TABLE PHD_STUDENT (									
	StudentId VARCHAR(50) NOT NULL,
    FName VARCHAR(50) NOT NULL,
	LName VARCHAR(50) NOT NULL,
    StSem VARCHAR(50) NOT NULL,
    StYear INT NOT NULL,
    Supervisor VARCHAR(50) NOT NULL,
   
    PRIMARY KEY (StudentId),
	FOREIGN KEY (Supervisor) REFERENCES TT(InstructorId)
				ON DELETE CASCADE	ON UPDATE CASCADE
);

CREATE TABLE GRA (									
	StudentId VARCHAR(50) NOT NULL,
    Funding VARCHAR(50) NOT NULL,
    MonthlyPay VARCHAR(50) NOT NULL,
      PRIMARY KEY (StudentId),
      	FOREIGN KEY (Funding) REFERENCES GRANTSS(AccountNo)
				ON DELETE CASCADE	ON UPDATE CASCADE

);

CREATE TABLE GTA(									
	StudentId VARCHAR(50) NOT NULL,
    SectionId VARCHAR(50) NOT NULL,
	MonthlyPay VARCHAR(50) NOT NULL,

   
      PRIMARY KEY (StudentId),
      	FOREIGN KEY (SectionId) REFERENCES SECTION (SectionId)
				ON DELETE CASCADE	ON UPDATE CASCADE
);

CREATE TABLE SELF_SUPPORT(									
	StudentId VARCHAR(50) NOT NULL,
    
    PRIMARY KEY (StudentId),
	      	FOREIGN KEY (StudentId) REFERENCES PHD_STUDENT(StudentId)
				ON DELETE CASCADE	ON UPDATE CASCADE
);

CREATE TABLE COURSE (
	CourseId VARCHAR(50) NOT NULL,
    CName VARCHAR(50) NOT NULL,
	
    PRIMARY KEY (CourseId)

);

CREATE TABLE COURSESTAUGHT (
	CourseId VARCHAR(50) NOT NULL,
    InstructorId VARCHAR(50) NOT NULL,
   
    PRIMARY KEY (CourseId, InstructorId),
        FOREIGN KEY (CourseId) REFERENCES COURSE (CourseId),
    FOREIGN KEY (InstructorId) REFERENCES TT (InstructorId)
    
	
);

CREATE TABLE MILESTONE (									
	MId VARCHAR(50) NOT NULL,
    MName VARCHAR(50) NOT NULL,
   
      PRIMARY KEY (MId)

);

CREATE TABLE MILESTONESPASSED(									
	StudentId VARCHAR(50) NOT NULL,
    MId VARCHAR(50) NOT NULL,
	PassDate VARCHAR(50) NOT NULL,
    
   
    PRIMARY KEY (StudentId, MId),
            FOREIGN KEY (StudentId) REFERENCES PHD_STUDENT(StudentId),
    FOREIGN KEY (MId) REFERENCES MILESTONE (MId)
    				ON DELETE CASCADE	ON UPDATE CASCADE
	
);

CREATE TABLE GRANTSS (									
	AccountNo VARCHAR(50) NOT NULL,
    GrantTitle VARCHAR(50) NOT NULL,
	Sourc VARCHAR(50) NOT NULL,
    Typ VARCHAR(50) NOT NULL,							
    StDate VARCHAR(50) NOT NULL,	
    EndDate VARCHAR(50) NOT NULL,	
    CurrBalance INT NOT NULL,
   
    PRIMARY KEY (AccountNo)

);

CREATE TABLE GRANTSASSOCIATED (									
	AccountNo VARCHAR(50) NOT NULL,
    InstructorId VARCHAR(10) NOT NULL,
	InstrType VARCHAR(50) NOT NULL,
    
   
    PRIMARY KEY (AccountNo, InstructorId),
	        FOREIGN KEY (AccountNo) REFERENCES GRANTSS(AccountNo),
    FOREIGN KEY (InstructorId) REFERENCES TT (InstructorId)
    				ON DELETE CASCADE	ON UPDATE CASCADE
);

CREATE TABLE PHDCOMMITTEE (									
	StudentId VARCHAR(50) NOT NULL,
    InstructorId VARCHAR(50) NOT NULL,
	
   
    PRIMARY KEY (StudentId, InstructorId),
    FOREIGN KEY (StudentId) REFERENCES PHD_STUDENT(StudentId),
    FOREIGN KEY (InstructorId) REFERENCES TT (InstructorId)
    				ON DELETE CASCADE	ON UPDATE CASCADE

);

CREATE TABLE SCHOLARSHIP_SUPPORT (									
	StudentId VARCHAR(50) NOT NULL,
    Type VARCHAR(50) NOT NULL,
	Source VARCHAR(50) NOT NULL,
    
   
    PRIMARY KEY (StudentId),
          	FOREIGN KEY (StudentId) REFERENCES PHD_STUDENT (StudentId)
				ON DELETE CASCADE	ON UPDATE CASCADE
    
	
);

CREATE TABLE SECTION (									
	SectionId VARCHAR(50) NOT NULL,
    CourseId VARCHAR(50) NOT NULL,
   
    PRIMARY KEY (SectionId, CourseId),
    FOREIGN KEY (CourseId) REFERENCES COURSE(CourseId)
                       ON DELETE CASCADE	ON UPDATE CASCADE
    
	
);

	
    
SET FOREIGN_KEY_CHECKS=0;
SET FOREIGN_KEY_CHECKS=1;


/* if the server variable local_infile is set to FALSE|0 , use the following commands to set is true */
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

/*To load the text file  */
/* DO IT IN MYSQL Commmand Line Client */

LOAD DATA LOCAL INFILE '/Project1_Phase2/course.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_CoursesTaught.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/instructor.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_TT.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_PhDStudent.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_GRA.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_GTA.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_SelfSupport.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_ScholarshipSupport.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_Grants.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_GrantAssociated.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_Milestone.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_MilestonesPassed.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_PhDCommittee.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase2/_Section.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;



/*SELECT ALL DATA */
SELECT * from INSTRUCTOR;
SELECT * from TT;
SELECT * from PHD_STUDENT;
SELECT * from GRA;
SELECT * from GTA;
SELECT * from SELF_SUPPORT;
SELECT * from SCHOLARSHIP_SUPPORT;
SELECT * from COURSE;
SELECT * from COURSESTAUGHT;
SELECT * from MILESTONE;
SELECT * from MILESTONESPASSED;
SELECT * from GRANTSS;
SELECT * from GRANTSASSOCIATED;
SELECT * from PHDCOMMITTEE;
SELECT * from SECTION;

/* Create a view SUPERVISION_INFO(INSTRUCTOR.InstructorId, INSTRUCTOR.FName, INSTRUCTOR.LName, PHDSTUDENTS.StudentId, PHDSTUDENTS.FName, 
PHDSTUDENTS.LName, PHDSTUDENTS.StSem, PHDSTUDENTS.StYear) that retrieves the info about each PHD STUDENT and their SUPERVISOR Name.
 The view should have the attributes renamed as: (IId, IFName, ILName, SId, SFName, SLName, SStSem, SStYear) */

CREATE VIEW SUPERVISION_INFO
as select I.InstructorId as IId,
 I.FName as IFName, 
 I.LName as ILName,
 P.StudentId as SId,
 P.FName as SFName, 
 P.LName as SLName, 
P.StSem as SStSem, 
 P.StYear as SStYear
 FROM INSTRUCTOR AS I, PHD_STUDENT AS P
 where P.Supervisor=I.InstructorId AND 
 I.Typs="TT";
 
 /*To show all the records in the view table */
    SELECT * FROM SUPERVISION_INFO;
 
 
 DROP view SUPERVISION_INFO;
 
/*2A. Retrieve for each instructor the IId, IFName, ILName, NoOfStudentsSupervised 
(the last is a COUNT aggregate function) */
SELECT DISTINCT IId, IFName, ILName, COUNT(IId) AS "NoOfStudentsSupervised"
FROM SUPERVISION_INFO
GROUP BY IId ;


/*2B.  Retrieve the student names (FName, LName) whose supervisor is FName=Ahmed and LName=Sarhan    */

SELECT SFName, SLName
FROM SUPERVISION_INFO
WHERE IFName='Ahmed' 
AND ILName='Sarhan';

/* 2C. Retrieve the supervisor names (FName, LName) for the students whose names (FName, LName) are Ife,Jelani and Maya,Smith and 
Raymond,Wilson (include the student names in the result). */
SELECT IFName, ILName, SFName, SLName
FROM SUPERVISION_INFO
WHERE SFName='Ife' and SLName='Jelani'
  or   SFName='Maya' and SLName='Smith'
  or   SFName='Raymond' and SLName='Wilson';



/* 3(i) Retrieve the PHDSTUDENT Id, FName, LName, and MILESTONE MName and PassDate for the milestones 
passed by each student.                */

SELECT P.StudentId, P.FName, P.LName, M.Mname, MP.PassDate
FROM PHD_STUDENT AS P, MILESTONESPASSED AS MP, MILESTONE AS M
WHERE P.StudentId=MP.StudentId
AND   M.MId=MP.MId; 

/* 3(ii) Retrieve the PHDSTUDENT Id, FName, Lname, and the supporting GRANT Name for all students who are GRAs.*/

SELECT P.StudentId, P.FName, P.LName, G.Granttitle AS "Grant Name"
FROM PHD_STUDENT AS P, GRA AS GR, GRANTSS AS G
WHERE P.StudentId=GR.StudentId
AND   GR.Funding=G.AccountNo;

/*3(iii)Retrieve the PHDSTUDENT Id, FName, Lname, and the COURSE Name they are working on for all students who are GTAs. */

SELECT P.StudentId, P.FName, P.LName, C.CName
FROM PHD_STUDENT AS P, GTA AS GT, COURSE AS C, SECTION AS S
WHERE P.StudentId=GT.StudentId
AND   GT.SectionId=S.SectionId
AND   C.CourseId= S.CourseId;