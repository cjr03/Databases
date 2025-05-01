DROP DATABASE IF EXISTS Lab2;
CREATE DATABASE IF NOT EXISTS Lab2 DEFAULT CHARACTER SET latin1;
USE Lab2;

DROP TABLE IF EXISTS User;
CREATE TABLE User (
	phlid varchar(15) NOT NULL,
	email varchar(45) NOT NULL,
	pswd varchar(15) NOT NULL, 
	PRIMARY KEY (phlid)
);

DROP TABLE IF EXISTS PHLogger;
CREATE TABLE PHLogger (
	phlid varchar(15) NOT NULL,
	`name` varchar(45) NOT NULL,
    address_street varchar(45) NOT NULL,
    address_city varchar(45) NOT NULL,
    address_state varchar(45) NOT NULL,
    address_pcode int(6) NOT NULL,
	PRIMARY KEY (phlid),
    FOREIGN KEY (phlid) REFERENCES User(phlid) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Supporter;
CREATE TABLE Supporter (
	phlid varchar(15) NOT NULL,
    `role` varchar(15)  NOT NULL,
    phone varchar(15)  NOT NULL,
    PRIMARY KEY (phlid),
    FOREIGN KEY (phlid) REFERENCES User(phlid) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Interest;
CREATE TABLE Interest (
	iname varchar(15) NOT NULL,
    `description` varchar(200) NOT NULL,
    topic varchar(15) NOT NULL,
    `date` date NOT NULL,
    PRIMARY KEY (iname)
);

DROP TABLE IF EXISTS Observer;
CREATE TABLE Observer (
	observer_id varchar(15) NOT NULL,
    kind varchar(15) NOT NULL,
    manufacturer varchar(45) NOT NULL,
    model varchar(15) NOT NULL,
    software_version varchar(15),
    phlid varchar(15) NOT NULL,
    PRIMARY KEY (observer_id),
    FOREIGN KEY (phlid) REFERENCES PHLogger(phlid) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Observation;
CREATE TABLE Observation (
	observation_id varchar(15) NOT NULL,
    phlid varchar(15),
    `start` time NOT NULL,
    `end` time,
    PRIMARY KEY (observation_id),
    FOREIGN KEY (phlid) REFERENCES User(phlid) ON DELETE SET NULL
);

DROP TABLE IF EXISTS Observable;
CREATE TABLE Observable (
	observation_id varchar(15) NOT NULL,
	observer_id varchar(15),
	is_Heart_rate bool NOT NULL,
    is_Blood_prsr bool NOT NULL,
    is_Picture bool NOT NULL,
    rate int(4),
    diastolic int(4),
    systolic int(4),
    picture varbinary(60000),
    label varchar(15),
    `text` varchar(200),
    FOREIGN KEY (observation_id) REFERENCES Observation(observation_id) ON DELETE CASCADE,
    FOREIGN KEY (observer_id) REFERENCES Observer(observer_id) ON DELETE SET NULL
);

DROP TABLE IF EXISTS PHLG_obs;
CREATE TABLE PHLG_obs (
	observation_id varchar(15) NOT NULL,
	`text` varchar(45) NOT NULL,
    FOREIGN KEY (observation_id) REFERENCES Observation(observation_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `Event`;
CREATE TABLE `Event` (
	eid varchar(15) NOT NULL,
    ename varchar(15) NOT NULL,
    `start` time NOT NULL,
    `end` time,
    origin varchar(45),
    phlid varchar(15) NOT NULL,
    PRIMARY KEY (eid),
    FOREIGN KEY (phlid) REFERENCES PHLogger(phlid) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Thought;
CREATE TABLE Thought (
	tnum varchar(15) NOT NULL,
    `text` varchar(200) NOT NULL,
    `date` date NOT NULL,
    phlid int(11) NOT NULL,
    PRIMARY KEY (tnum, phlid),
    FOREIGN KEY (phlid) REFERENCES PHLogger(phlid) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `Member`;
CREATE TABLE `Member` (
	phlid varchar(15) NOT NULL,
    iname varchar(15) NOT NULL,
    PRIMARY KEY (phlid, iname),
    FOREIGN KEY (phlid) REFERENCES PHLogger(phlid) ON DELETE CASCADE,
    FOREIGN KEY (iname) REFERENCES Interest(iname) ON DELETE CASCADE
);

DROP TABLE IF EXISTS About;
CREATE TABLE About (
	tnum varchar(15) NOT NULL,
    iname varchar(15) NOT NULL,
    phlid varchar(15) NOT NULL,
    PRIMARY KEY (tnum, iname),
    FOREIGN KEY (tnum, phlid) REFERENCES Thought(tnum, phlid) ON DELETE CASCADE,
    FOREIGN KEY (iname) REFERENCES Interest(iname) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Indicate;
CREATE TABLE Indicate (
	eid varchar(15) NOT NULL,
    observation_id varchar(15) NOT NULL,
    PRIMARY KEY (eid, observation_id),
    FOREIGN KEY (eid) REFERENCES `Event`(eid) ON DELETE CASCADE,
    FOREIGN KEY (observation_id) REFERENCES Observation(observation_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Contacts;
CREATE TABLE Contacts (
	phlid varchar(15) NOT NULL,
    phone varchar(15) NOT NULL,
    PRIMARY KEY (phlid, phone),
    FOREIGN KEY (phlid) REFERENCES PHLogger(phlid) ON DELETE CASCADE
);