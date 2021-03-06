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
    StartDate VARCHAR(50) ,
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
	LName VARCHAR(10) NOT NULL,
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
	      	FOREIGN KEY (StudentId) REFERENCES PHD_STUDENT(SectionId)
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
            FOREIGN KEY (StudentId) REFERENCES PHD_STUDENR(StudentId),
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

	
    



/* if the server variable local_infile is set to FALSE|0 , use the following commands to set is true */
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

/*To load the text file  */
/* DO IT IN MYSQL Commmand Line Client */

LOAD DATA LOCAL INFILE '/Project1_Phase1/course.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_CoursesTaught.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/instructor.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_TT.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_PhDStudent.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_GRA.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_GTA.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_SelfSupport.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_ScholarshipSupport.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_Grants.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_GrantAssociated.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_Milestone.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_MilestonesPassed.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_PhDCommittee.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/Project1_Phase1/_Section.csv' INTO TABLE Course FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;



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


