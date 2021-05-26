CREATE DATABASE banking_enterprise_db;
USE banking_enterprise_db;

CREATE TABLE Branch(
	branchname VARCHAR(30), 
    branchcity VARCHAR(30), 
    assets REAL, 
    PRIMARY KEY(branchname)
    );
DESC Branch;

CREATE TABLE Accounts(
	accno INT, 
    branchname VARCHAR(30),
    balance REAL, 
    PRIMARY KEY(accno),
    FOREIGN KEY(branchname) 
	REFERENCES Branch(branchname) ON DELETE CASCADE
    );
DESC Accounts;
    
CREATE TABLE Customer(
	customername VARCHAR(20), 
    customerstreet VARCHAR(20), 
    customercity VARCHAR(20), 
	PRIMARY KEY(customername)
    );
    DESC Customer;
    
	CREATE TABLE Depositor(
    customername VARCHAR(30),
    accno INT, 
    PRIMARY KEY(customername, accno), 
	FOREIGN KEY(customername) REFERENCES Customer(customername) ON UPDATE CASCADE, 
    FOREIGN KEY(accno) REFERENCES Cccounts(accno) ON DELETE CASCADE
    );
    DESC Depositor;
    
CREATE TABLE Loan(
	loanno INT,
	branchname VARCHAR(30), 
    amount REAL, 
    PRIMARY KEY(loanno), 
	FOREIGN KEY(branchname) REFERENCES Branch(branchname) ON DELETE CASCADE
    );
    DESC Loan;
    
CREATE TABLE Borrower(
	customername VARCHAR(20), 
    loanno INT, 
    PRIMARY KEY(customername, loanno),
	FOREIGN KEY(customername) REFERENCES Customer(customername) ON UPDATE CASCADE, 
    FOREIGN KEY(loanno) REFERENCES Loan(loanno) ON DELETE CASCADE);


INSERT INTO Branch VALUES("SBI_PD_NAGAR", "BANGALORE", 200000);
INSERT INTO Branch VALUES("SBI_RAJAJI_NAGAR", "BANGALORE", 500000);
INSERT INTO Branch VALUES("SBI_JAYANAGAR", "BANGALORE", 660000);
INSERT INTO Branch VALUES("SBI_VIJAY_NAGAR", "BANGALORE", 870000);
INSERT INTO Branch VALUES("SBI_HOSAKEREHALLI", "BANGALORE", 550000);
SELECT * FROM Branch;

INSERT INTO Accounts VALUES(1234602, "SBI_HOSAKEREHALLI", 5000);
INSERT INTO Accounts VALUES(1234603, "SBI_VIJAY_NAGAR", 5000);
INSERT INTO Accounts VALUES(1234604, "SBI_JAYANAGAR", 5000);
INSERT INTO Accounts VALUES(1234605, "SBI_RAJAJI_NAGAR", 10000);
INSERT INTO Accounts VALUES(1234503, "SBI_VIJAY_NAGAR", 40000);
SELECT * FROM Accounts;

INSERT INTO Customer VALUES("KEZAR", "MG_ROAD", "BANGALORE");
INSERT INTO Customer VALUES("LAL_KRISHNA", "ST_MKS_ROAD", "BANGALORE");
INSERT INTO Customer VALUES("RAHUL", "AUGSTEN_ROAD", "BANGALORE");
INSERT INTO Customer VALUES("LALLU", "VS_ROAD", "BANGALORE");
INSERT INTO Customer VALUES("FAIZAL", "RESIDENCY_ROAD", "BANGALORE");
INSERT INTO Customer VALUES("RAJEEV", "DICKNSN_ROAD", "BANGALORE");
SELECT * FROM Customer;

INSERT INTO Loan VALUES(10011, "SBI_JAYANAGAR", 10000);
INSERT INTO Loan VALUES(10012, "SBI_VIJAY_NAGAR", 5000);
INSERT INTO Loan VALUES(10013, "SBI_HOSAKEREHALLI", 20000);
INSERT INTO Loan VALUES(10014, "SBI_PD_NAGAR", 15000);
INSERT INTO Loan VALUES(10015, "SBI_RAJAJI_NAGAR", 25000);
SELECT * FROM Loan;

INSERT INTO Borrower VALUES("KEZAR", 10011);
INSERT INTO Borrower VALUES("LAL_KRISHNA", 10012);
INSERT INTO Borrower VALUES("RAHUL", 10013);
INSERT INTO Borrower VALUES("LALLU", 10014);
INSERT INTO Borrower VALUES("LAL_KRISHNA", 10015);
SELECT * FROM Borrower;

INSERT INTO Depositor VALUES("LAL_KRISHNA", 1234603);
INSERT INTO Depositor VALUES("LAL_KRISHNA", 1234503);
INSERT INTO Depositor VALUES("KEZAR", 1234604);
INSERT INTO Depositor VALUES("RAHUL", 1234602);
SELECT * FROM Depositor;


/* *************QUERY 1************** 
Find all the customers who have at least two accounts at the Main branch.*/


SELECT customername FROM Depositor D, Accounts A where D.accno=A.accno and A.branchname="SBI_VIJAY_NAGAR" GROUP BY D.customername having count(D.customername) >= 2;

/* ************ QUERY 2 *************
Find all the customers who have an account at all the branches located in a specific city.*/

SELECT D.customername FROM Accounts A, Branch B, Depositor D where B.branchname=A.branchname and A.accno=D.accno and B.branchcity="BANGALORE" 
GROUP BY D.customername HAVING count(distinct B.branchname)=(SELECT count(branchname) FROM branch WHERE branchcity="BANGALORE");

/* ************QUERY 3 **************
Demonstrate how you delete all account tuples at every branch located in a specific city.*/

DELETE FROM accounts WHERE branchname IN(SELECT branchname FROM Branch WHERE branchcity="BANGALORE");
commit;
