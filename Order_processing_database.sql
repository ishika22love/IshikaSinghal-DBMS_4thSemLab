CREATE DATABASE Order_processing_database;
USE Order_processing_database;
CREATE TABLE Customer(
	cust_id int,
    cname varchar(30),
    city varchar(30),
    PRIMARY KEY(cust_id)
);
DESC Customer;

CREATE TABLE Orders(
	order_id int,
    odate date,
    cust_id int,
    ord_amt int,
    PRIMARY KEY(order_id),
    FOREIGN KEY(cust_id) REFERENCES Customer(cust_id) ON DELETE CASCADE
);
DESC Orders;

CREATE TABLE Item(
	item_id int,
    unit_price int,
    PRIMARY KEY(item_id)
);
DESC Item;

CREATE TABLE Order_item(
	order_id int,
    item_id int,
    qty int,
    FOREIGN KEY(item_id) REFERENCES Item(item_id) ON DELETE CASCADE,
    FOREIGN KEY(order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);
DESC Order_item;

CREATE TABLE Warehouse(
	warehouse_id int,
    city varchar(30),
    PRIMARY KEY(warehouse_id)
);
DESC Warehouse;

CREATE TABLE Shipment(
	order_id int, 
	warehouse_id int, 
    shipdate date,
    FOREIGN KEY(order_id) REFERENCES ORDERS(order_id) ON DELETE CASCADE, 
    FOREIGN KEY(warehouse_id) REFERENCES Warehouse(warehouse_id) ON DELETE CASCADE
);
DESC Shipment;

INSERT INTO Customer values(771, 'PUSHPA K' , 'BANGALORE');
INSERT INTO Customer values(772, 'SUMAN', 'MUMBAI');
INSERT INTO Customer values(773, 'SOURAV', 'CALICUT');
INSERT INTO Customer values(774, 'LAILA', 'HYDERABAD');
INSERT INTO Customer values(775, 'FAIZAL', 'BANGALORE');
SELECT* FROM Customer;

INSERT INTO Orders values(11, '2002-01-22', 771, 18000);
INSERT INTO Orders values(12, '2002-07-30', 774, 6000);
INSERT INTO Orders values(13, '2003-04-03', 775, 9000);
INSERT INTO Orders values(14, '2003-11-03', 775, 29000);
INSERT INTO Orders values(15, '2003-12-10', 773, 29000);
INSERT INTO Orders values(16, '2004-08-04', 772, 56000);
INSERT INTO Orders values(17, '2004-09-10', 771, 20000);
INSERT INTO Orders values(18, '2004-11-20', 775, 29000);
INSERT INTO Orders values(19, '2005-02-13', 774, 29000);
INSERT INTO Orders values(20, '2005-10-13', 775, 29000);
SELECT * FROM Orders;

INSERT INTO Item VALUES('5001','503');
INSERT INTO Item VALUES('5002','750');
INSERT INTO Item VALUES('5003','150');
INSERT INTO Item VALUES('5004','600');
INSERT INTO Item VALUES('5005','890');
SELECT * FROM Item;

INSERT INTO Order_item VALUES('11','5001','50');
INSERT INTO Order_item VALUES('12','5003','20');
INSERT INTO Order_item VALUES('13','5002','50');
INSERT INTO Order_item VALUES('14','5005','60');
INSERT INTO Order_item VALUES('15','5004','90');
INSERT INTO Order_item VALUES('16','5001','10');
INSERT INTO Order_item VALUES('17','5003','80');
INSERT INTO Order_item VALUES('18','5005','50');
INSERT INTO Order_item VALUES('19','5002','10');
INSERT INTO Order_item VALUES('20','5004','45');
SELECT * FROM Order_item;


INSERT INTO Warehouse VALUES('1','DELHI');
INSERT INTO Warehouse VALUES('2','BOMBAY');
INSERT INTO Warehouse VALUES('3','CHENNAI');
INSERT INTO Warehouse VALUES('4','BANGALORE');
INSERT INTO Warehouse VALUES('5','BANGALORE');
SELECT * FROM warehouse;


INSERT INTO Shipment VALUES('11','1','2002-02-10');
INSERT INTO Shipment VALUES('12','5','2002-09-10');
INSERT INTO Shipment VALUES('13','2','2003-02-10');
INSERT INTO Shipment VALUES('14','3','2003-12-10');
INSERT INTO Shipment VALUES('15','4','2004-01-19');
SELECT * FROM Shipment;

/*                                       *************QUERY1**********
Produce a listing: CUSTNAME, #oforders, AVG_ORDER_AMT, where the middle column is the total numbers of orders by the customer and the last column is the average order amount for that
customer.
*/

SELECT cname , count(*), avg(ord_amt) FROM Customer right join Orders on Customer.cust_id = Orders.cust_id GROUP BY Customer.cname;


/*                                      *************QUERY2**********
List the order# for orders that were shipped from all warehouses that the company has in a specific city. */

SELECT order_id FROM warehouse AS wh, shipment as sh where wh.warehouse_id=sh.warehouse_id and city="Bombay";



/*                                      *************QUERY2**********
Demonstrate how you delete item# 10 from the ITEM table and make that field null in the ORDER_ITEM table */

SELECT * FROM item;
delete from item where item_no = 5005;
SELECT * FROM item;
