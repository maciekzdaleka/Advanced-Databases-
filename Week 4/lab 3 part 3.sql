DROP TABLE Teams;

DROP TABLE Matches;

CREATE TABLE Matches
(
	mactch_id            NUMERIC(6) NOT NULL,
	teama_id             NUMERIC(6) NULL,
	teamb_id             NUMERIC(6) NULL,
	goal_a               NUMERIC(2) NULL,
	goal_b               NUMERIC(2) NULL,
	competition          VARCHAR(30) NULL
);

ALTER TABLE Matches
ADD PRIMARY KEY (mactch_id);

CREATE TABLE Teams
(
	team_id              NUMERIC(6) NOT NULL,
	team_name            VARCHAR(30) NULL,
	team_country         VARCHAR(30) NULL
);

ALTER TABLE Teams
ADD PRIMARY KEY (team_id);

ALTER TABLE Matches
ADD CONSTRAINT fk_team_a
FOREIGN KEY (teama_id)
REFERENCES Teams(team_id);

ALTER TABLE Matches
ADD CONSTRAINT fk_team_b
FOREIGN KEY (teamb_id)
REFERENCES Teams(team_id);


INSERT INTO Teams  VALUES ('1', 'Arsenal', 'England');
INSERT INTO Teams  VALUES ('2', 'Manchester United', 'England');
INSERT INTO Teams  VALUES ('3', 'Chelsea', 'England');
INSERT INTO Teams  VALUES ('4', 'Manchester City', 'England');
INSERT INTO Teams  VALUES ('5', 'Barcelona', 'Spain');
INSERT INTO Teams  VALUES ('6', 'Real Madrid', 'Spain');
INSERT INTO Teams  VALUES ('7', 'Getafe', 'Spain');
INSERT INTO Teams  VALUES ('8', 'Sevilla', 'Spain');

CREATE TABLE ltable
(
	action          VARCHAR(20) NOT NULL,
  whenoccured     TIMESTAMP NOT NULL
);

CREATE OR REPLACE TRIGGER triger_on_Teams_Table_Insert
AFTER INSERT or UPDATE ON Teams
BEGIN
	INSERT into ltable values ('Insertion or update happened on: ', SYSDATE) ;
END;

CREATE OR REPLACE TRIGGER triger_comp
BEFORE INSERT OR UPDATE ON Matches
FOR EACH ROW
BEGIN
	IF (:new.competition NOT LIKE 'Champions League' and :new.competition NOT LIKE 'Premier League' and 
  :new.competition NOT LIKE 'La Liga' and :new.competition NOT LIKE 'Europa Leauge')
  THEN
	  Raise_application_error(-20000,(:new.competition || ' is not recognised '));
  END IF;
END;

CREATE OR REPLACE TRIGGER triger_spain_or_england
BEFORE INSERT OR UPDATE ON Teams
FOR EACH ROW
BEGIN
	IF (:new.team_country NOT LIKE 'England' and :new.team_country NOT LIKE 'Spain')
  THEN
	  Raise_application_error(-20000,('Please insert England or Spain only!'));
	END IF;
END;

CREATE OR REPLACE TRIGGER triger_goals
BEFORE INSERT OR UPDATE ON Matches
FOR EACH ROW
BEGIN
	IF (:new.goal_a + :new.goal_b <0)
  THEN
	  Raise_application_error(-20000,('There has to be 0 or more goals in a match'));
	END IF;
END;

CREATE OR REPLACE TRIGGER triger_right_league_for_teams
BEFORE INSERT OR UPDATE ON Matches
FOR EACH ROW
BEGIN
	IF (:new.competition LIKE 'Premier League')
  THEN
	  IF ((:new.teama_id NOT BETWEEN 1 AND 4) OR (:new.teamb_id NOT BETWEEN 1 AND 4))
    THEN
      Raise_application_error(-20000,('Only teams from England can play in Premier League'));
    END IF;
  ELSE IF (:new.competition LIKE 'La Liga')
   THEN
	  IF ((:new.teama_id NOT BETWEEN 5 AND 8) OR (:new.teamb_id NOT BETWEEN 5 AND 8))
    THEN
      Raise_application_error(-20000,('Only teams from Spain can play in La Liga'));
    END IF;
	END IF;
  END IF;
END;

CREATE OR REPLACE TRIGGER triger_3_matches
BEFORE INSERT OR UPDATE ON Matches
FOR EACH ROW
DECLARE
	match_no NUMBER;
BEGIN
	SELECT COUNT(*) INTO match_no FROM Matches
		WHERE teama_id = :new.teama_id;
	IF match_no >= 3
	THEN
	  Raise_application_error(-20000,(:new.teama_id || ' has alredy too many matches '));
	END IF;
END;


