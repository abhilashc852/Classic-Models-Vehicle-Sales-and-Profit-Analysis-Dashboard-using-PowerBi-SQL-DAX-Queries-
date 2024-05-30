/* CREATING THE DATABASE WITH THE NAME OF CLASSIC_MODEL*/

CREATE DATABASE CLASSIC_MODEL;

USE CLASSIC_MODEL; --USE THE CLASSIC MODEL DATABASE

/* CREATING THE Table 1  WITH THE NAME OF CUSTOMERS*/
CREATE TABLE CUSTOMERS (
	Customer_Number int NOT NULL Primary key(Customer_Number),
	CustomerName varchar(50) NOT NULL,
	ContactLastName varchar(50) NOT NULL,
	ContactFirstName varchar(50) NOT NULL,
	Phone varchar(50) NOT NULL,
	AddressLine1 varchar(50) NOT NULL,
	AddressLine2 varchar(50) DEFAULT NULL,
	City varchar(50) NOT NULL,
	State varchar(50) DEFAULT NULL,
	PostalCode varchar(15) DEFAULT NULL,
	Country varchar(50) NOT NULL,
	SalesRepEmployeeNumber int Not NULL,
	CreditLimit decimal(10,2) DEFAULT NULL
  );

/* CREATING THE Table 2  WITH THE NAME OF EMPLOYEES*/
CREATE TABLE EMPLOYEES (
	EmployeeNumber int NOT NULL PRIMARY KEY(EmployeeNumber),
	LastName varchar(50) NOT NULL,
	FirstName varchar(50) NOT NULL,
	Extension varchar(10) NOT NULL,
	Email varchar(100) NOT NULL,
	OfficeCode varchar(10) NOT NULL,
	ReportsTo int DEFAULT NULL,
	Job_Title varchar(50) NOT NULL
);

/* CREATING THE Table 3  WITH THE NAME OF OFFICES*/
 CREATE TABLE OFFICES (
	OfficeCode varchar(10) NOT NULL PRIMARY KEY (OfficeCode) ,
	City varchar(50) NOT NULL,
	Phone varchar(50) NOT NULL,
	AddressLine1 varchar(50) NOT NULL,
	AddressLine2 varchar(50) DEFAULT NULL,
	State varchar(50) DEFAULT NULL,
	Country varchar(50) NOT NULL,
	PostalCode varchar(15) NOT NULL,
	Territory varchar(10) NOT NULL
);
  

/* CREATING THE Table 4  WITH THE NAME OF ORDER_DETAILS*/

CREATE TABLE ORDER_DETAILS (
	OrderNumber int NOT NULL ,
	ProductCode varchar(15) NOT NULL,
	QuantityOrdered int NOT NULL,
	PriceEach decimal(10,2) NOT NULL,
	OrderLineNumber smallint NOT NULL
);


/* CREATING THE Table 5  WITH THE NAME OF ORDERS*/

CREATE TABLE ORDERS (
	OrderNumber int NOT NULL  PRIMARY KEY (OrderNumber),
	OrderDate date NOT NULL,
	RequiredDate date NOT NULL,
	ShippedDate date DEFAULT NULL,
	Status varchar(15) NOT NULL,
	Comments text,
	CustomerNumber int NOT NULL
);

/* CREATING THE Table 6  WITH THE NAME OF PAYMENTS*/
CREATE TABLE PAYMENTS (
	CustomerNumber int NOT NULL,
	CheckNumber varchar(50) NOT NULL PRIMARY KEY (CheckNumber) ,
	PaymentDate date NOT NULL,
	Amount decimal(10,2) NOT NULL
);

/* CREATING THE Table 7  WITH THE NAME OF PRODUCT_LINES*/

CREATE TABLE PRODUCT_LINES (
	ProductLine varchar(50) NOT NULL PRIMARY KEY (ProductLine),
	TextDescription varchar(4000) DEFAULT NULL,
	HtmlDescription  text,
	Image  varbinary(max)
);
  

/* CREATING THE Table 8  WITH THE NAME OF PRODUCTS*/

CREATE TABLE PRODUCTS (
	ProductCode varchar(15) NOT NULL PRIMARY KEY (ProductCode) ,
	ProductName varchar(70) NOT NULL,
	ProductLine varchar(50) NOT NULL,
	ProductScale varchar(10) NOT NULL,
	ProductVendor varchar(50) NOT NULL,
	ProductDescription text NOT NULL,
	QuantityInStock smallint NOT NULL,
	BuyPrice decimal(10,2) NOT NULL,
	MSRP decimal(10,2) NOT NULL
);
 


 /* ADD FOREIGN KEY CONSTRAINT TO ENSURE REFERENTIAL INTEGRITY BETWEEN RELATED TABLES, 
 PREVENTING INVALID DATA AND MAINTAINING CONSISTENT RELATIONSHIPS.*/

ALTER TABLE CUSTOMERS ADD FOREIGN KEY (SalesRepEmployeeNumber) REFERENCES EMPLOYEES(EmployeeNumber);

ALTER TABLE EMPLOYEES ADD FOREIGN KEY (ReportsTo) REFERENCES EMPLOYEES(EmployeeNumber);

ALTER TABLE EMPLOYEES ADD FOREIGN KEY (OfficeCode) REFERENCES OFFICES(OfficeCode);

ALTER TABLE ORDER_DETAILS ADD FOREIGN KEY (OrderNumber) REFERENCES ORDERS (OrderNumber);

ALTER TABLE ORDER_DETAILS ADD FOREIGN KEY (ProductCode) REFERENCES PRODUCTS(ProductCode);

ALTER TABLE ORDERS ADD FOREIGN KEY (CustomerNumber) REFERENCES CUSTOMERS(Customer_Number);

ALTER TABLE PAYMENTS ADD FOREIGN KEY (CustomerNumber) REFERENCES CUSTOMERS(Customer_Number);

ALTER TABLE PRODUCTS ADD FOREIGN KEY (ProductLine) REFERENCES PRODUCT_LINES(ProductLine);

/* CALLING THE TABLES*/

SELECT* FROM CUSTOMERS;

SELECT* FROM EMPLOYEES;

SELECT* FROM OFFICES;

SELECT* FROM ORDER_DETAILS;

SELECT* FROM ORDERS;

SELECT* FROM PAYMENTS;

SELECT* FROM PRODUCT_LINES;

SELECT* FROM PRODUCTS;



/* Joins and Calucation that you can help you for Power Bi Projects*/



SELECT 
    ORDERS.orderDate,
    ORDERS.orderNumber,
    PRODUCTS.productName,
    PRODUCTS.productLine,
    CUSTOMERS.customerName,
    CUSTOMERS.city AS customer_city,
    CUSTOMERS.country AS customer_country,
    OFFICES.city AS office_city,
    OFFICES.country AS office_country,
    PRODUCTS.buyPrice, 
    ORDER_DETAILS.priceEach,
    ORDER_DETAILS.quantityOrdered,
    SUM(ORDER_DETAILS.quantityOrdered) * SUM(ORDER_DETAILS.priceEach) AS sales_value,
    SUM(PRODUCTS.buyPrice) * SUM(ORDER_DETAILS.quantityOrdered) AS cost_of_sales
INTO classicmodels_sales
FROM 
    orders 
    LEFT JOIN ORDER_DETAILS ON ORDERS.orderNumber = ORDER_DETAILS.orderNumber
    LEFT JOIN CUSTOMERS ON ordERS.CustomerNumber = CUSTOMERS.Customer_Number
    LEFT JOIN products ON ORDER_DETAILS.productCode = PRODUCTS.productCode
    LEFT JOIN employees  ON CUSTOMERS.salesRepEmployeeNumber = EMPLOYEES.employeeNumber
    LEFT JOIN offices ON EMPLOYEES.officeCode = OFFICES.officeCode
GROUP BY
 ORDERS.orderDate,
    ORDERS.orderNumber,
    PRODUCTS.productName,
    PRODUCTS.productLine,
    CUSTOMERS.customerName,
    CUSTOMERS.city ,
    CUSTOMERS.country,
    OFFICES.city ,
    OFFICES.country,
    PRODUCTS.buyPrice, 
    ORDER_DETAILS.priceEach,
    ORDER_DETAILS.quantityOrdered;
   


