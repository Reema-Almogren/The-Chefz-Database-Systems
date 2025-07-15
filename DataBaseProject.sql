-- Creation
DROP TABLE Restaurant CASCADE CONSTRAINT;
CREATE TABLE Restaurant(
Res_name VARCHAR2(50) NOT NULL,
Res_type VARCHAR2(50) UNIQUE,
Res_menu VARCHAR2(50) ,
Res_add  VARCHAR2(50) ,
CONSTRAINT Res_PK PRIMARY KEY(Res_name));


DROP TABLE Employee CASCADE CONSTRAINT;
CREATE TABLE Employee(
Emp_id CHAR(10) NOT NULL,
Emp_phone CHAR(10),
Emp_name VARCHAR2(15) NOT NULL,
Emp_pass NUMBER(8),
Emp_email VARCHAR2(30),
Emp_add VARCHAR2(225),
Res_name VARCHAR2(20),
CONSTRAINT Emp_PK PRIMARY KEY(Emp_id),
CONSTRAINT Emp_Fk FOREIGN KEY (Res_name) REFERENCES Restaurant(Res_name));


DROP TABLE Customer CASCADE CONSTRAINT;
CREATE TABLE Customer(
Cus_id CHAR(10) NOT NULL,
Cus_name VARCHAR2(15) NOT NULL,
Cus_phone CHAR(10) ,
Cus_pass NUMBER(8) ,
Cus_email VARCHAR2(30),
CONSTRAINT Cus_PK PRIMARY KEY(Cus_id ));


DROP TABLE CustomerAdd  CASCADE CONSTRAINT;
CREATE TABLE CustomerAdd  (
Cus_add VARCHAR2(20) NOT NULL,
Cus_id CHAR(10) ,
CONSTRAINT CusAdd_PK PRIMARY KEY(Cus_add,Cus_id),
CONSTRAINT CusAdd_FK FOREIGN KEY(Cus_id) REFERENCES Customer(Cus_id));


DROP TABLE  Delivery_agent  CASCADE CONSTRAINT;
CREATE TABLE  Delivery_agent(
Del_id CHAR(10) NOT NULL,
Del_name VARCHAR2(15) NOT NULL,
Del_pass NUMBER(8) ,
Del_phone CHAR(10),
CONSTRAINT Del_PK PRIMARY KEY(Del_id ));


DROP TABLE Order_ CASCADE CONSTRAINT;
CREATE TABLE Order_(
ord_number NUMBER(20),
ord_description VARCHAR(25),
Res_name VARCHAR2(20),
Cus_id CHAR(10),
Del_id CHAR(10),
CONSTRAINT Order__PK PRIMARY KEY(ord_number),
CONSTRAINT Order__FK_Res FOREIGN KEY(Res_name) REFERENCES Restaurant(Res_name),
CONSTRAINT Order__FK_Cus  FOREIGN KEY(Cus_id) REFERENCES Customer(Cus_id),
CONSTRAINT Order__FK_Del  FOREIGN KEY(Del_id) REFERENCES Delivery_agent(Del_id));


-- Insertion
INSERT INTO Restaurant VALUES('Piatto','Italian','English-Arabic','Al Yasmin');
INSERT INTO Restaurant VALUES('Chilis','American','English','Ar-rabi');
INSERT INTO Restaurant VALUES('Al-baik','Fast Food','Arabic','Qurtubah');

INSERT INTO Employee  VALUES ('EMP01','05555','Nouf',1223 ,'Nouf1@gmail.com','Al Olaya', 'Piatto'); 
INSERT INTO Employee  VALUES ('EMP03','05066','Mohammed',2555 ,'Mohammed@gmail.com', 'Al Malqa ', 'Chilis');
INSERT INTO Employee  VALUES ('EMP02','00544','Razan',3444 ,'Razan@gmail.com','Al Yarmouk' , 'Al-baik');

INSERT INTO Customer VALUES('CUS01','Sama','05011',2333,'Sama@gmail.com');
INSERT INTO Customer VALUES('CUS02','Farah','05022',4555,'Farah@gmail.com');
INSERT INTO Customer VALUES('CUS03','Khaled','05033',3777,'Khaled@gmail.com');

INSERT INTO CustomerAdd VALUES('Narjis','CUS01');
INSERT INTO CustomerAdd VALUES('Al Hamra','CUS02');
INSERT INTO CustomerAdd VALUES('Al Sahafah','CUS03');

INSERT INTO Delivery_agent VALUES('DEL01','Zayed',6677,'05144');
INSERT INTO Delivery_agent VALUES('DEL02','Hamad',7788,'05155');
INSERT INTO Delivery_agent VALUES('DEL03','Omar',9933,'05177');

INSERT INTO Order_ VALUES(07,'Out for Delivery','Piatto','CUS01','DEL01');
INSERT INTO Order_ VALUES(08,'Preparing','Chilis','CUS02','DEL02');
INSERT INTO Order_ VALUES(09,'Delivered','Al-baik','CUS03','DEL03');

--Queries

--to retrive the details of a specific resturant excluding resturant menu
SELECT Res_name, Res_type, Res_add
FROM Restaurant
WHERE Res_name = 'Chilis';


--to identify customer's orders in a specific neighbor
SELECT Cus_id
FROM CustomerAdd
WHERE Cus_add LIKE '%Al Hamra%';


--to make sure that all orders got delivered
UPDATE Order_
SET ord_description = 'Out for Delivery'
WHERE ord_description = 'Preparing';

SELECT * FROM Order_
WHERE Res_name= 'Chilis';


--Query with group by clause
SELECT Res_name, COUNT(*) AS TotalOrders
FROM Order_
GROUP BY Res_name;

--Query with group by and having clauses
SELECT Res_name, COUNT(*) AS TotalOrders
FROM Order_
GROUP BY Res_name
HAVING COUNT(*) > 5;

--Query with join
SELECT Cus_name, Res_name
FROM Customer
JOIN Order_ ON Customer.Cus_id = Order_.Cus_id;