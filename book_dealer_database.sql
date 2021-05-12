CREATE DATABASE Book_Dealer_Database;
USE Book_Dealer_Database;
CREATE TABLE Author(
	author_id int,
    A_name varchar(30),
    city varchar(30),
    country varchar(30),
    PRIMARY KEY (author_id)
);
DESC Author;

CREATE TABLE Publisher(
	publisher_id int,
    P_name varchar(30),
    city varchar(30),
    country varchar(30),
    PRIMARY KEY (publisher_id)
);
DESC Publisher;

CREATE TABLE Catalog(
	book_id int,
    title varchar(30),
    author_id varchar(30),
    publisher_id int,
    category_id int,
    year int,
    price int,
    PRIMARY KEY (book_id),
    FOREIGN KEY(publisher_id) references Publisher(publisher_id) ON DELETE CASCADE,
    FOREIGN KEY(category_id) REFERENCES Category(category_id) ON DELETE CASCADE
);
DESC Catalog;

CREATE TABLE Category(
	category_id int,
    description varchar(30),
    PRIMARY KEY(category_id)
);
DESC Category;

CREATE TABLE Order_Details(
	order_no int,
    book_id int, 
    quantity int,
    PRIMARY KEY (Order_no),
    FOREIGN KEY(book_id) REFERENCES Catalog(book_id) ON DELETE CASCADE
);
DESC Order_Details;

INSERT INTO Author VALUES('11','Author1','A_city1','A_country1');
commit;
SELECT * FROM Author;
INSERT INTO Author VALUES('12','Author2','A_city2','A_country2');
INSERT INTO Author VALUES('13','Author3','A_city3','A_country3');
INSERT INTO Author VALUES('14','Author4','A_city4','A_country4');
INSERT INTO Author VALUES('15','Author5','A_city5','A_country5');
commit;

INSERT INTO Publisher VALUES('21','Publisher1','P_city1','P_country1');
commit;
INSERT INTO Publisher VALUES('22','Publisher2','P_city2','P_country2');
INSERT INTO Publisher VALUES('23','Publisher3','P_city3','P_country3');
INSERT INTO Publisher VALUES('24','Publisher4','P_city4','P_country4');
INSERT INTO Publisher VALUES('25','Publisher5','P_city5','P_country5');
commit;

INSERT INTO Category VALUES('31','Category1');
commit;
INSERT INTO Category VALUES('32','Category2');
INSERT INTO Category VALUES('33','Category3');
INSERT INTO Category VALUES('34','Category4');
INSERT INTO Category VALUES('35','Category5');
commit;

INSERT INTO Catalog VALUES('41','Book1','12','24','31','2001','248');
commit;
INSERT INTO Catalog VALUES('42','Book2','15','21','33','2020','3480');
INSERT INTO Catalog VALUES('43','Book3','11','23','31','1962','3569');
INSERT INTO Catalog VALUES('44','Book4','13','25','33','2012','4720');
INSERT INTO Catalog VALUES('45','Book5','14','24','35','2019','369');
commit;

INSERT INTO Order_Details VALUES('51','44','33');
commit;
INSERT INTO Order_Details VALUES('52','44','1');
INSERT INTO Order_Details VALUES('53','43','38');
INSERT INTO Order_Details VALUES('54','41','27');
INSERT INTO Order_Details VALUES('55','43','68');
commit;

-- ********** Query 1: ***********
-- Give the details of the authors who have 2 or more books in the catalog and the price of the books in the catalog and the year of publication is after 2000.

SELECT * FROM Author INNER JOIN Catalog ON Author.author_id = Catalog.author_id where (year >2000 AND price > 2000);

-- ********** Query 2: ***********
-- Find the author of the book which has maximum sales.

SELECT * FROM Author INNER JOIN Catalog ON Author.author_id = Catalog.author_id AND book_id in(SELECT book_id FROM Order_Details WHERE quantity = (SELECT MAX(quantity) from Order_Details));
 
-- ********** Query 3: ***********
-- Demonstrate how you increase the price of books published by a specific publisher by 10%.

UPDATE Catalog SET price =(1+0.1)*price WHERE publisher_id in ( SELECT publisher_id FROM Publisher WHERE P_name ="Publisher3");
SELECT * FROM Catalog;
