/* A New Database Phase3 is created using the code : CREATE SCHEMA phase3;
Next Process is creating Tables in Phase3 database
 */
 
 /*
  DELETE TABLE ?
  
 DROP TABLE TEAM;
 DROP TABLE STADIUM; 
 DROP TABLE PLAYER;
 DROP TABLE GAME;
 DROP TABLE STARTING_LINEUPS;
 DROP TABLE SUBSITUTIONS;
 DROP TABLE GOALS;
 DROP TABLE OWN_GOALS;
 DROP TABLE CARDS;
 .
 .
	
    */

-- CREATE TABLES

CREATE TABLE TEAM (
	TeamID VARCHAR(10) NOT NULL,
	Team VARCHAR(50) NOT NULL,
	Continent VARCHAR(15) NOT NULL,
	League CHAR(10),
	Population INT NOT NULL,
    PRIMARY KEY (TeamID)
);

CREATE TABLE STADIUM (
	SID VARCHAR(10) NOT NULL,
    SName VARCHAR(50) NOT NULL,
    SCity VARCHAR(50) NOT NULL,
    SCapacity INT NOT NULL,
    PRIMARY KEY (SID)
);

CREATE TABLE PLAYER (									-- Player corresponds to the data in the "rosters" data file
	Team VARCHAR(50),
    TeamID VARCHAR(10) NOT NULL,
	PNo INT NOT NULL,									-- PNo corresponds to Player ID
	`Position` VARCHAR(10) NOT NULL,
    PName VARCHAR(50) NOT NULL,							-- PName corresponds to FIFA Popular Name
    BirthDate VARCHAR(10),
    ShirtName VARCHAR(50) NOT NULL,
    Club VARCHAR(50),
    Height INT NOT NULL,
    Weight INT NOT NULL,
    PRIMARY KEY (PNo,TeamID),
	FOREIGN KEY (TeamID) REFERENCES TEAM (TeamID)
				ON DELETE CASCADE	ON UPDATE CASCADE
);

CREATE TABLE GAME (										-- GAME corresponds to the Data in the "matches" data file
	GameID VARCHAR(10) NOT NULL,
    MatchType CHAR,
    MatchDate VARCHAR(10) NOT NULL,
    SID VARCHAR(10) NOT NULL,
    TeamID1 VARCHAR(10) NOT NULL,
    TeamID2 VARCHAR(10) NOT NULL,
    Team1_Score INT,
    Team2_Score INT,
    PRIMARY KEY (GameID,SID),
	FOREIGN KEY (SID) REFERENCES STADIUM (SID)
				ON DELETE CASCADE	ON UPDATE CASCADE
);

CREATE TABLE STARTING_LINEUPS (
	GameID VARCHAR(10) NOT NULL,
    TeamID VARCHAR(10) NOT NULL,
    PNo INT NOT NULL,
    PRIMARY KEY (GameID,TeamID,PNo),
    FOREIGN KEY (GameID) REFERENCES GAME (GameID)
				ON DELETE CASCADE	ON UPDATE CASCADE
);

CREATE TABLE CARDS (
	GameID VARCHAR(10) NOT NULL,
    TeamID VARCHAR(10) NOT NULL,
    PNo INT NOT NULL,
    Color VARCHAR(10),
    Time VARCHAR(5) NOT NULL,
    PRIMARY KEY (GameID,TeamID,PNo, Color),
    FOREIGN KEY (GameID) REFERENCES GAME (GameID)
				ON DELETE CASCADE	ON UPDATE CASCADE
);


CREATE TABLE GOALS (
	GameID VARCHAR(10) NOT NULL,
    TeamID VARCHAR(10) NOT NULL,
    PNo INT NOT NULL,
    Time VARCHAR(5) NOT NULL,
    Penalty CHAR,
    PRIMARY KEY (GameID,TeamID,PNo, Time),
    FOREIGN KEY (PNo) REFERENCES PLAYER (PNo)
				ON DELETE CASCADE 	ON UPDATE CASCADE
);

CREATE TABLE SUBSITUTIONS (
	GameID VARCHAR(10) NOT NULL,
    TeamID VARCHAR(10) NOT NULL,
    PNoIn INT NOT NULL,
    `Position` VARCHAR(10),
    PNoOut INT NOT NULL,
    Time VARCHAR(5) NOT NULL,
    PRIMARY KEY (GameID,TeamID, PNoIn),
    FOREIGN KEY (PNoIn) REFERENCES PLAYER (PNo),
    FOREIGN KEY (PNoOut) REFERENCES PLAYER (PNo)
);


CREATE TABLE OWN_GOALS (
	GameID VARCHAR(10) NOT NULL,
    TeamID VARCHAR(10) NOT NULL,
    PNo INT NOT NULL,
    Time VARCHAR(5) NOT NULL,
    ForTeamID VARCHAR(10) NOT NULL,
    PRIMARY KEY (GameID,TeamID,PNo),
    FOREIGN KEY (ForTeamID) REFERENCES TEAM (TeamID),	-- Matching respective IDs with respective tables.
     FOREIGN KEY (TeamID) REFERENCES TEAM (TeamID)
				ON DELETE CASCADE	ON UPDATE CASCADE
);
/* ATTENDENCE */
CREATE TABLE Admins (
	id INT(10) NOT NULL,
    puser_name VARCHAR(100) NOT NULL,
    pnetid VARCHAR(100) NOT NULL,
    pcode VARCHAR(100) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE TABLE student (
	id INT(10) NOT NULL,
    puser_name VARCHAR(100) NOT NULL,
	netid VARCHAR(100) NOT NULL,
    code VARCHAR(100) NOT NULL,
    PRIMARY KEY (ID)
);



INSERT INTO Admins (id,puser_name,pnetid,pcode) VALUES (1,'jeewangw','jxg7734','8097');
INSERT INTO Admins (id,puser_name,pnetid,pcode) VALUES (2,'jeewangw','jxg7734','8097');
INSERT INTO Admins (id,puser_name,pnetid,pcode) VALUES (3,'jee','jxg7734','0027');
INSERT INTO Admins (id,puser_name,pnetid,pcode) VALUES (4,'jengw','jxg7734','87');
INSERT INTO Admins (id,puser_name,pnetid,pcode) VALUES (5,'jeewangw','jxg7734','8097');

INSERT INTO student (id,puser_name,netid,code) VALUES (1,'jeewangw','jxg7734','8097');
INSERT INTO student (id,puser_name,netid,code) VALUES (2,'jengw','jxg7734','87');
INSERT INTO student (id,puser_name,netid,code) VALUES (3,'jeewangw','jxg7734','8097');
INSERT INTO student (id,puser_name,netid,code) VALUES (4,'jeewangw','jxg734','8097');
INSERT INTO student (id,puser_name,netid,code) VALUES (5,'jeewangw','jxg7734','8097');

/*LAST ROW */
SELECT * FROM (SELECT * FROM student ORDER BY student.id DESC LIMIT 1) as s INNER JOIN ( SELECT * FROM Admins ORDER BY Admins.id DESC LIMIT 1) as ad ON s.code = ad.pcode AND s.puser_name = ad.puser_name;
DELETE  s1, s2 FROM  student as s1 INNER JOIN student as s2 ON s1.netid = s2.netid AND s1.puser_name = s2.puser_name AND s1.code = s2.code;
/* ALL ROW COMPARING LAST ROW OF ANOTHER TABLE*/
SELECT * FROM (SELECT * FROM student ORDER BY student.id DESC LIMIT 1) as s1 INNER JOIN (SELECT * FROM student) as s2 ON s1.puser_name = s2.puser_name AND s1.netid = s2.netid ;


DELETE t1 FROM students t1 INNER JOIN students t2 WHERE t1.id > t2.id AND t1.code = t2.code AND t1.netid = t2.netid;
                      
/* END ATTENDENCE */



 
/* if the server variable local_infile is set to FALSE|0 , use the following commands to set is true */
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

/*To load the text file  */
/* DO IT IN MYSQL Commmand Line Client */

-- For Table Team
LOAD DATA LOCAL INFILE 'C:/Users/Jeevan/Desktop/Files/teams.csv' INTO TABLE TEAM FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

-- SIMILARLY FOR STADIUM TABLE AND OTHER TABLES 
LOAD DATA LOCAL INFILE 'C:/Users/Jeevan/Desktop/Files/stadiums.csv' INTO TABLE STADIUM FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

--  FOR PLAYER TABLE ; make sure to turn off foreign constraint at first
set foreign_key_checks=0;
LOAD DATA LOCAL INFILE 'C:/Users/Jeevan/Desktop/Files/rosters.csv' INTO TABLE PLAYER FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;
set foreign_key_checks=1;

--  FOR MATCHES TABLE ; make sure to turn off foreign constraint at first
set foreign_key_checks=0;
LOAD DATA LOCAL INFILE 'C:/Users/Jeevan/Desktop/Files/matches.csv' INTO TABLE GAME FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;
set foreign_key_checks=1;

-- for Starting_lineup table
LOAD DATA LOCAL INFILE 'C:/Users/Jeevan/Desktop/Files/starting.csv' INTO TABLE STARTING_LINEUPS FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

-- for subsitutions
LOAD DATA LOCAL INFILE 'C:/Users/Jeevan/Desktop/Files/substitution.csv' INTO TABLE SUBSITUTIONS FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

-- for goals
LOAD DATA LOCAL INFILE 'C:/Users/Jeevan/Desktop/Files/goals.csv' INTO TABLE GOALS FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;

-- for own_goals
set foreign_key_checks=0;
LOAD DATA LOCAL INFILE 'C:/Users/Jeevan/Desktop/Files/own_goals.csv' INTO TABLE OWN_GOALS FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;
set foreign_key_checks=1;

-- for cards
LOAD DATA LOCAL INFILE 'C:/Users/Jeevan/Desktop/Files/cards.csv' INTO TABLE CARDS FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;


/*DISPLAYS ALL TABLES */
SHOW TABLES;

/*SELECT ALL DATA */
SELECT * from TEAM;
SELECT * from STADIUM;
SELECT * from PLAYER;
SELECT * from GAME;
SELECT * from STARTING_LINEUPS;
SELECT * from SUBSITUTIONS;
SELECT * from GOALS;
SELECT * from OWN_GOALS;
SELECT * from CARDS;

-- Queries


-- Q.1 Retrieve player’s name, number, and team name that their teams belong to 'UEFA' League. List
-- the results in an ascending order based on player’s name.

SELECT P.PName, P.PNo, P.Team
FROM PLAYER as P, Team as T
WHERE P.TeamID = T.TeamID
	AND T.League = 'UEFA'
ORDER BY P.PName ASC; 

 
-- Q.2 Retrieve the scores of all games played in Group C or D where team 1 or team 2 had score at
-- least two goals. List the match type, match date, team 1 name, team 1 score, team 2 name, and
-- team 2 score. Sort the result by the match type and use alias to rename all attributes

SELECT G.MatchType,G.MatchDate, t1.team as "Team 1 name", t2.team as "Team 2 Name", G.Team1_Score as "Team 1 Score", G.Team2_Score as "Team 2 Score"
FROM GAME as G, TEAM AS T1, Team as T2
WHERE G.TeamID1 = T1.TeamID
	AND G.TeamID2 = T2.TeamID
	AND (G.MatchType = 'C' OR G.MatchType = 'D')
	AND (G.Team1_Score >=2 OR G.Team2_Score >=2)
	AND T1.League = 'UEFA'
ORDER BY G.MatchType;


-- Q.3 Retrieve the starting lineups of both teams for the game whose GameID is 51. List the team id
-- and name, Player id, name and position ordered by the team id.

SELECT T.TeamID, T.team,p.PNo as "Player ID", p.PName, p.Position
FROM starting_lineups as S, player as p, Team as T
WHERE 	S.PNo = P.PNo
		AND T.TeamID = S.TeamID
        AND T.TeamID = P.TeamID
        AND S.GameID = 'G51'
ORDER BY T.TeamID;


-- Q.4 What is the total number of own goals scored in the tournament? Rename the attribute name to
-- something meaningful.

SELECT Count(O.GameID) AS "OWN GOALS TOTAL"
FROM own_goals as O;

-- Q.5 Retrieve the id and name of the teams that scored own goal(s) in more than one games, as well
-- as the player id and name. Also, list the opponent team id, and name. 
        
SELECT T1.TEAMID, T1.team, T2.TeamID,T2.team, P.PName,O.PNo
FROM OWN_GOALS as O, Player as P, Team as T1, Team as T2
  WHERE 
		 O.PNo = P.PNo  AND
		 O.TEAMID = P.TEAMID AND
         O.TEAMID = T1.TEAMID AND
        O.FOR_TeamID = T2.TEAMID AND
        O.TEAMID IN (
	SELECT O.TEAMID
    FROM OWN_GOALS as O
       GROUP BY O.TEAMID
	   HAVING COUNT(O.TEAMID) >1 )
;


-- Q.6 Retrieve the total number of goals per player. List the player’s team id and name, player’s id and
-- name, and the number of total goals scored (Do not include own goals in this query results). List
-- at the top the players with the most goals. Also rename all attributes to something nice and
-- meaningful. 

SELECT COUNT(PENALTY) AS "GOALS", G.PNo, G.TEAMID, T.TEAM,P.PName
FROM GOALS as G, Player as P, Team as T
 WHERE G.TeamID = P.TeamID AND
	   G.PNo = P.PNo AND
       G.TEAMID = T.TEAMID
GROUP BY (CONCAT(G.PNo,'-',G.TEAMID))
ORDER BY COUNT(PENALTY) DESC
;


-- Q.7 Find the top 3 players with the most replacements. For each replaced player, retrieve the team
-- name, the player name and the total number of replacements.

 SELECT count(S.PNoIN) as "Total Number of Replacements", P.PName, P.team, P.TeamID
 FROM subsitutions as S, player as P
 WHERE P.PNo = S.PNoIN AND
	   P.TeamID = S.TeamID
 GROUP BY (CONCAT(S.PNoIN,'-',S.TEAMID))
 ORDER BY count(S.PNoIN) DESC
 LIMIT 3 
;
 
/* Q.8 Create a view GAME_INFO that retrieves for each team all that team’s game scores ordered by
Match type. The view should have the following attributes: Team, and for each game that the
team has participated in (either as TeamID1 or TeamID2) the following information: Stadium
Name, SCity, Match Type, MatchDate, Team1Name, Team1Score, Team2Name, Team2Score.
Rename all attributes to something meaningful and print the results of the view */

CREATE OR REPLACE VIEW GAME_INFO
		AS
        SELECT G.GameID as "GameNumber", S.SName as "StadiumName", S.SCity as "StadiumCity", G.MatchType as "GameType", G.MatchDate as "GameDate", T1.team as "Team1", G.Team1_Score as "Team1Goals", T2.team as "Team2", G.Team2_Score as "Team2Goals"
        FROM Stadium as S, Game as G, Team as T1 , Team as T2
        WHERE  G.TeamID1 = T1.teamID AND
		       G.TeamID2 = T2.teamID AND
               G.SID = S.SID
        ORDER BY G.MatchType;
        

SELECT * FROM GAME_INFO;



/* Q.9 Write the following queries in the view you created:
(i) Retrieve all games where ‘France’ won.
(ii) Retrieve all tie games
(iii) Retrieve the total number of goals that each team scored either as team 1 or team 2 and order
the results by the total # of goals in a descending order */


-- 1)

/* Replace View with Updated Data */

-- at first, RUN CREATE OR REPLACE VIEW 
-- finally, RUN Select statement

CREATE OR REPLACE VIEW GAME_INFO
		AS
        SELECT G.GameID as "GameNumber", S.SName as "StadiumName", S.SCity as "StadiumCity", G.MatchType as "GameType", G.MatchDate as "GameDate", T1.team as "Team1", G.Team1_Score as "Team1Goals", T2.team as "Team2", G.Team2_Score as "Team2Goals"
        FROM Stadium as S, Game as G, Team as T1 , Team as T2
        WHERE  G.TeamID1 = T1.teamID AND
		       G.TeamID2 = T2.teamID AND
               G.SID = S.SID AND
               ((T1.team = 'France' AND (G.Team1_Score > G.Team2_Score)) OR (T2.team = 'France' AND (G.Team1_Score < G.Team2_Score)))
               
        ORDER BY G.MatchType;
	
    
Select * from Game_INFO ;
 
 /* ALTERNATIVE WAY WITHOUT REPLACING VIEW ........................................................................ */
SELECT * FROM GAME_INFO
WHERE ((Team1 = 'France' AND (Team1Goals > Team2Goals)) OR (Team2= 'France' AND (Team1Goals < Team2Goals)));
/* ..........................................................................*/
 
 
-- 2) 


/* Replace View with Updated Data */
-- at first, RUN CREATE OR REPLACE VIEW 
-- finally, RUN Select statement

CREATE OR REPLACE VIEW GAME_INFO
		AS
        SELECT G.GameID as "GameNumber", S.SName as "StadiumName", S.SCity as "StadiumCity", G.MatchType as "GameType", G.MatchDate as "GameDate", T1.team as "Team1", G.Team1_Score as "Team1Goals", T2.team as "Team2", G.Team2_Score as "Team2Goals"
        FROM Stadium as S, Game as G, Team as T1 , Team as T2
        WHERE  G.TeamID1 = T1.teamID AND
		       G.TeamID2 = T2.teamID AND
               G.SID = S.SID AND
               G.Team1_score= G.Team2_score
        ORDER BY G.MatchType;
        
Select * from Game_INFO ;


/* ALTERNATIVE WAY WITHOUT REPLACING VIEW ........................................................................ */
SELECT * FROM GAME_INFO
WHERE Team1Goals = Team2Goals;
/* ..........................................................................*/


-- 3)

/*Retrieve the total number of goals that each team scored either as team 1 or team 2 and order
the results by the total # of goals in a descending order */

SELECT Team1, SUM(TEAM1GOALS) 
FROM GAME_INFO
WHERE (TEAM1 = TEAM1 OR TEAM1 = TEAM2) AND TEAM1GOALS IN (
SELECT TEAM1GOALS
FROM GAME_INFO
Having SUM(TEAM1GOALS));
 
