-- CREATE database IPL;
use IPL;


-- Venue table
CREATE TABLE Venue (
    Venue_Id INT PRIMARY KEY,
    Venue_Name VARCHAR(255),
    City_Id INT,
    FOREIGN KEY (City_Id) REFERENCES City(City_Id)
);

-- Wicket_Taken table
CREATE TABLE Wicket_Taken (
    Match_Id INT,
    Over_Id INT,
    Ball_Id INT,
    Player_Out INT,
    Kind_Out INT,
    Fielders INT DEFAULT NULL,  -- Assuming Fielders can be NULL
    Innings_No INT,
    PRIMARY KEY (Match_Id, Over_Id, Ball_Id, Innings_No),
    FOREIGN KEY (Match_Id, Over_Id, Ball_Id, Innings_No) REFERENCES Ball_by_Ball(Match_Id, Over_Id, Ball_Id, Innings_No)
);

-- Win_By table
CREATE TABLE Win_By (
    Win_Id INT PRIMARY KEY,
    Win_Type VARCHAR(255)
);


-- Player table
CREATE TABLE Player (
    Player_Id INT PRIMARY KEY,
    Player_Name VARCHAR(255),
    DOB DATE,
    Batting_hand INT,
    Bowling_skill INT NULL,  -- Assuming Bowling_skill can be NULL
    Country_Name INT,
    FOREIGN KEY (Country_Name) REFERENCES Country(Country_Id)
);

-- Team table
CREATE TABLE Team (
    Team_Id INT PRIMARY KEY,
    Team_Name VARCHAR(255)
);

-- Toss_Decision table
CREATE TABLE Toss_Decision (
    Toss_Id INT PRIMARY KEY,
    Toss_Name VARCHAR(255)
);

-- Extra_Type table
CREATE TABLE Extra_Type (
    Extra_Id INT PRIMARY KEY,
    Extra_Name VARCHAR(255)
);

-- Country table
CREATE TABLE Country (
    Country_Id INT PRIMARY KEY,
    Country_Name VARCHAR(255)
);

-- City table
CREATE TABLE City (
    City_Id INT PRIMARY KEY,
    City_Name VARCHAR(255),
    Country_id INT,
    FOREIGN KEY (Country_id) REFERENCES Country(Country_Id)
);

-- Bowling_Style table
CREATE TABLE Bowling_Style (
    Bowling_Id INT PRIMARY KEY,
    Bowling_skill VARCHAR(255)
);

-- Player_Match table
CREATE TABLE Player_Match (
    Match_Id INT,
    Player_Id INT,
    Role_Id INT,
    Team_Id INT,
    PRIMARY KEY (Match_Id, Player_Id),
    FOREIGN KEY (Match_Id) REFERENCES Match_(Match_Id),
    FOREIGN KEY (Player_Id) REFERENCES Player(Player_Id),
    FOREIGN KEY (Role_Id) REFERENCES Rolee(Role_Id),
    FOREIGN KEY (Team_Id) REFERENCES Team(Team_Id)
);

-- Rolee table
CREATE TABLE Rolee (
    Role_Id INT PRIMARY KEY,
    Role_Desc VARCHAR(255)
);

-- Season table
CREATE TABLE Season (
    Season_Id INT PRIMARY KEY,
    Man_of_the_Series INT,
    Orange_Cap INT,
    Purple_Cap INT,
    Season_Year INT
);

-- Match table
CREATE TABLE Match_ (
    Match_Id INT PRIMARY KEY,
    Team_1 INT,
    Team_2 INT,
    Match_Date DATE,
    Season_Id INT,
    Venue_Id INT,
    Toss_Winner INT,
    Toss_Decide INT,
    Win_Type INT,
    Win_Margin INT,
    Outcome_type INT,
    Match_Winner INT NULL,  -- Assuming Match_Winner can be NULL
    Man_of_the_Match INT NULL,  -- Assuming Man_of_the_Match can be NULL
    FOREIGN KEY (Season_Id) REFERENCES Season(Season_Id),
    FOREIGN KEY (Venue_Id) REFERENCES Venue(Venue_Id),
    FOREIGN KEY (Team_1) REFERENCES Team(Team_Id),
    FOREIGN KEY (Team_2) REFERENCES Team(Team_Id),
    FOREIGN KEY (Toss_Decide) REFERENCES Toss_Decision(Toss_Id),
    FOREIGN KEY (Win_Type) REFERENCES Win_By(Win_Id)
);

-- Out_Type table
CREATE TABLE Out_Type (
    Out_Id INT PRIMARY KEY,
    Out_Name VARCHAR(255)
);

-- Outcome table
CREATE TABLE Outcome (
    Outcome_Id INT PRIMARY KEY,
    Outcome_Type VARCHAR(255)
);

-- Extra_Runs table
CREATE TABLE Extra_Runs (
    Match_Id INT,
    Over_Id INT,
    Ball_Id INT,
    Extra_Type_Id INT,
    Extra_Runs INT,
    Innings_No INT,
    PRIMARY KEY (Match_Id, Over_Id, Ball_Id, Innings_No),
    FOREIGN KEY (Extra_Type_Id) REFERENCES Extra_Type(Extra_Id),
    FOREIGN KEY (Match_Id, Over_Id, Ball_Id, Innings_No) REFERENCES Ball_by_Ball(Match_Id, Over_Id, Ball_Id, Innings_No)
);

-- Batsman_Scored table
CREATE TABLE Batsman_Scored (
    Match_Id INT,
    Over_Id INT,
    Ball_Id INT,
    Innings_No INT,
    Runs_Scored INT,
    PRIMARY KEY (Match_Id, Over_Id, Ball_Id, Innings_No),
    FOREIGN KEY (Match_Id, Over_Id, Ball_Id, Innings_No) REFERENCES Ball_by_Ball(Match_Id, Over_Id, Ball_Id, Innings_No)
);

-- Batting_Style table
CREATE TABLE Batting_Style (
    Batting_Id INT PRIMARY KEY,
    Batting_hand VARCHAR(255)
);

-- Ball_by_Ball table
CREATE TABLE Ball_by_Ball (
    Match_Id INT,
    Over_Id INT,
    Ball_Id INT,
    Innings_No INT,
    Team_Batting INT,
    Team_Bowling INT,
    Striker_Batting_Position INT,
    Striker INT,
    Non_Striker INT,
    Bowler INT,
    PRIMARY KEY (Match_Id, Over_Id, Ball_Id, Innings_No),
    FOREIGN KEY (Match_Id) REFERENCES Match_(Match_Id),
    FOREIGN KEY (Striker) REFERENCES Player(Player_Id),
    FOREIGN KEY (Non_Striker) REFERENCES Player(Player_Id),
    FOREIGN KEY (Bowler) REFERENCES Player(Player_Id),
    FOREIGN KEY (Team_Batting) REFERENCES Team(Team_Id),
    FOREIGN KEY (Team_Bowling) REFERENCES Team(Team_Id)
);
SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/IPL_2016/Batsman_Scored.csv" INTO TABLE Batsman_Scored
FIELDS terminated by ','
IGNORE 1 LINES;

ALTER TABLE Match_ MODIFY Match_Date VARCHAR(255);
ALTER TABLE Match_ MODIFY Win_Margin INT NULL;
TRUNCATE TABLE ipl.bowling_style; -- used to remove all the rows from bowling_style table
ALTER TABLE player MODIFY DOB VARCHAR(255);
TRUNCATE TABLE ipl.batsman_scored; -- used to remove all the rows from bowling_style table



