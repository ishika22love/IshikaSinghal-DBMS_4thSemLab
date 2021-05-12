CREATE DATABASE Insurance_database;
USE Insurance_database;
SHOW TABLES;

CREATE TABLE PERSON(driver_id VARCHAR(20),dname VARCHAR(20),address VARCHAR(40),PRIMARY KEY(driver_id));
DESC PERSON;

CREATE TABLE CAR(regno VARCHAR(10),model VARCHAR(10),year INT ,PRIMARY KEY(regno));
DESC CAR;

CREATE TABLE ACCIDENT(report_no INT,adate date,location VARCHAR(20),PRIMARY KEY(report_no));
DESC ACCIDENT;

CREATE TABLE OWNS(driver_id VARCHAR(10),regno VARCHAR(10),PRIMARY KEY(driver_id,regno),foreign key(driver_id) references PERSON(driver_id) on delete cascade,foreign key(regno) references CAR(regno) on delete cascade);

CREATE TABLE PARTICIPATED(driver_id VARCHAR(10),regno VARCHAR(10),report_no INT,damage_amt float, foreign key (driver_id,regno) references OWNS(driver_id,regno)ON DELETE CASCADE,foreign key (REPORT_NO) references ACCIDENT(REPORT_NO) ON DELETE CASCADE);
DESC PARTICIPATED;

INSERT INTO PERSON VALUES('11','P1','Add1');
commit;
SELECT* FROM PERSON;
INSERT INTO PERSON VALUES('22','P2','Add2');
INSERT INTO PERSON VALUES('33','P3','Add3');
INSERT INTO PERSON VALUES('44','P4','Add4');
INSERT INTO PERSON VALUES('55','P5','Add5');
commit;

INSERT INTO CAR VALUES('Reg1','Model1', 2000);
INSERT INTO CAR VALUES('Reg2', 'Model2', 2000);
INSERT INTO CAR VALUES('Reg3',' Model3',1999);
INSERT INTO CAR VALUES('Reg4', 'Model1', 2002);
INSERT INTO CAR VALUES('Reg5', 'Model4', 2002);
commit;

SELECT * FROM CAR;

INSERT INTO ACCIDENT VALUES(12,'2002-06-01', 'Loc1');
INSERT INTO ACCIDENT VALUES(200, '2002-12-10', 'Loc2');
INSERT INTO ACCIDENT VALUES(300, '1999-07-23', 'Loc1');
INSERT INTO ACCIDENT VALUES(25000, '2000-06-11', 'Loc3');
INSERT INTO ACCIDENT VALUES(26500, '2001-10-16', 'Loc4');
commit;

SELECT * FROM ACCIDENT;

INSERT INTO OWNS VALUES('11','Reg1');
INSERT INTO OWNS VALUES('11', 'Reg2');
INSERT INTO OWNS VALUES('22', 'Reg3');
INSERT INTO OWNS VALUES('33', 'Reg4');
INSERT INTO OWNS VALUES('44', 'Reg5');
commit;

SELECT * FROM OWNS;

INSERT INTO PARTICIPATED VALUES('11', 'Reg1', 12 ,20000);
INSERT INTO PARTICIPATED VALUES('22', 'Reg3', 200, 500);
INSERT INTO PARTICIPATED VALUES('33', 'Reg4', 300, 10000);
INSERT INTO PARTICIPATED VALUES('44', 'Reg5', 25000 ,2375);
INSERT INTO PARTICIPATED VALUES('11', 'Reg2', 26500 ,70000);


UPDATE PARTICIPATED SET DAMAGE_AMT=25000 WHERE REPORT_NO =12 AND REGNO='Reg1';
SELECT * FROM PARTICIPATED;


SELECT count(*) FROM ACCIDENT WHERE Adate like '2002--';
SELECT count(A.Report_no) FROM ACCIDENT A, PARTICIPATED P, CAR C WHERE A.Report_no=P.Report_no AND P.Regno=C.Regno AND C.Model="Model1";
