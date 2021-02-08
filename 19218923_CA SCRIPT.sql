create database WATCHONLINE; 
Create Database DataMart;
use watchonline;
create table SALES (
SalesN varchar(50),
CustomerID varchar(50),
PaymentAmount int ,
Payment_date datetime,
PRIMARY KEY (SalesN)
);
create table STOCK (
ProductID VARCHAR(10),
SupplierID VARCHAR(10),
QuantityStock int,
PRIMARY KEY (ProductID)
);
create table SUPPLIERS (
SupplierID varchar(100),
S_Name varchar(100),
S_contactdetails varchar(100),
PRIMARY KEY (SupplierID)
);
create table REFUNDS (
ReturnN varchar(50),
OrderID varchar(50),
RefundQ int,
Refundpmt int,
PRIMARY KEY (ReturnN)
 );
 create table CUSTOMER_DETAILS (
 CustomerID varchar(50),
 C_name varchar(50),
 C_contactdetails varchar(100),
 PRIMARY KEY (CustomerID)
 );
 
CREATE TABLE ORDER_DETAILS (
OrderDetailsID varchar(50),
OrderID varchar(50),
ProductID varchar(50),
QuantitySold int,
CustomerID varchar(50),
PRIMARY KEY (OrderDetailsID)
);

insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (1, '877702497-4', '3526.99', '2020-02-18 00:42:50');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (2, '713239066-X', '1106.96', '2020-03-20 03:44:35');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (3, '168950580-X', '923.21', '2019-10-17 22:46:11');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (4, '731111285-0', '2468.95', '2020-03-23 08:07:50');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (5, '707520582-X', '3054.36', '2019-08-17 03:54:40');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (6, '877702497-4', '4410.13', '2019-12-05 02:35:25');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (7, '168950580-X', '2160.87', '2019-05-11 21:04:57');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (8, '168950580-X', '2674.29', '2019-03-07 07:34:39');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (9, '731111285-0', '5854.85', '2019-04-08 20:03:09');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (10, '262275335-7', '2182.70', '2020-01-28 01:43:19');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (11, '877702497-4', '5129.48', '2020-01-12 05:38:24');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (12, '521163612-0', '786.26', '2019-03-06 14:58:39');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (13, '284779202-3', '2757.61', '2020-03-26 03:26:08');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (14, '877702497-4', '3707.11', '2019-12-30 11:29:00');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (15, '197660168-1', '528.37', '2019-06-03 19:09:39');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (16, '262275335-7', '877.66', '2020-02-26 22:42:37');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (17, '474660500-9', '1669.23', '2019-08-31 05:15:37');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (18, '197660168-1', '2862.53', '2019-09-08 18:39:17');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (19, '877702497-4', '4751.89', '2019-06-17 12:27:08');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (20, '284779202-3', '1364.56', '2019-11-29 04:33:45');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (21, '521163612-0', '3841.97', '2019-08-17 06:28:58');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (22, '262275335-7', '2662.89', '2019-09-06 02:53:41');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (23, '877702497-4', '1851.08', '2019-07-24 13:48:14');
insert into SALES (SalesN, CustomerID, PaymentAmount, Payment_date) values (24, '707520582-X', '3529.26', '2020-03-21 09:17:20');

##insert values into stock table

insert into STOCK (ProductID, SupplierID, QuantityStock) values (1997, '#b1a', 416);
insert into STOCK (ProductID, SupplierID, QuantityStock) values (2001, '#445', 374);
insert into STOCK (ProductID, SupplierID, QuantityStock) values (1990, '#e39', 367);
insert into STOCK (ProductID, SupplierID, QuantityStock) values (1993, '#dfd', 88);
insert into STOCK (ProductID, SupplierID, QuantityStock) values (2003, '#eea', 604);
insert into STOCK (ProductID, SupplierID, QuantityStock) values (2012, '#b1a', 136);
insert into STOCK (ProductID, SupplierID, QuantityStock) values (2000, '#e39', 165);
insert into STOCK (ProductID, SupplierID, QuantityStock) values (1995, '#eea', 310);
insert into STOCK (ProductID, SupplierID, QuantityStock) values (1987, '#445', 85);
insert into STOCK (ProductID, SupplierID, QuantityStock) values (2005, '#b1a', 644);

##insert values into Suppliers table

insert into SUPPLIERS (SupplierID, S_name, S_contactdetails) values ('#b1a', 'Braun LLC', '665-761-0807');
insert into SUPPLIERS (SupplierID, S_name, S_contactdetails) values ('#445','Green-Collins', '111-971-6465');
insert into SUPPLIERS (SupplierID, S_name, S_contactdetails) values ('#e39','Daniel LLC', '858-877-1762');
insert into SUPPLIERS (SupplierID, S_name, S_contactdetails) values ('#dfd','Luettgen-Beer', '887-379-4827');
insert into SUPPLIERS (SupplierID, S_name, S_contactdetails) values ('#eea','Kemmer-Koch', '125-839-8856');

##customerdetails table

insert into Customer_details (CustomerID, C_name, C_contactdetails) values ('713239066-X', 'Carolynn Mauser', 'cmauser0@economist.com');
insert into Customer_details (CustomerID, C_name, C_contactdetails) values ('168950580-X', 'Iolanthe Kilalea', 'ikilalea1@ocn.ne.jp');
insert into Customer_details (CustomerID, C_name, C_contactdetails) values ('731111285-0', 'Karie Gehrels', 'kgehrels2@barnesandnoble.com');
insert into Customer_details (CustomerID, C_name, C_contactdetails) values ('707520582-X', 'Elna Maletratt', 'emaletratt3@comcast.net');
insert into Customer_details (CustomerID, C_name, C_contactdetails) values ('877702497-4', 'Tabina Widdocks', 'twiddocks4@amazon.com');
insert into Customer_details (CustomerID, C_name, C_contactdetails) values ('262275335-7', 'Sharai Kean', 'skean5@networkadvertising.org');
insert into Customer_details (CustomerID, C_name, C_contactdetails) values ('521163612-0', 'Torin Bewlay', 'tbewlay6@yolasite.com');
insert into Customer_details (CustomerID, C_name, C_contactdetails) values ('284779202-3', 'Elnora Manzell', 'emanzell7@spotify.com');
insert into Customer_details (CustomerID, C_name, C_contactdetails) values ('407702497-4', 'Zorah Blanc', 'zblanc8@godaddy.com');
insert into Customer_details (CustomerID, C_name, C_contactdetails) values ('197660168-1', 'Alphonse Dupoy', 'adupoy9@wordpress.com');

##

insert into REFUNDS (ReturnN, OrderID, RefundQ, Refundpmt) values ('27-005-7188', '42361-010', 100, 26);
insert into REFUNDS (ReturnN, OrderID, RefundQ, Refundpmt) values ('28-798-7873', '62372-743', 11, 94);
insert into REFUNDS (ReturnN, OrderID, RefundQ, Refundpmt) values ('37-688-6855', '52125-808', 70, 29);
insert into REFUNDS (ReturnN, OrderID, RefundQ, Refundpmt) values ('46-219-9959', '68745-1153', 54, 86);
insert into REFUNDS (ReturnN, OrderID, RefundQ, Refundpmt) values ('72-943-4929', '43269-652', 97, 84);
insert into REFUNDS (ReturnN, OrderID, RefundQ, Refundpmt) values ('01-025-4438', '51079-169', 11, 70);


insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (1, '36987-1522', 94, 597,'713239066-X');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (2, '36987-1522', 80, 722,'713239066-X');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (3, '37012-486', 64, 896,'877702497-4');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (4, '42361-010', 1997, 677,'877702497-4');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (5, '36800-306', 1997, 789,'262275335-7');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (6, '36800-306', 2001, 251,'262275335-7');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (7, '62372-743', 1995, 673,'521163612-0');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (8, '59779-940', 1993, 640,'521163612-0');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (9, '41520-431', 2003, 27,'284779202-3');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (10, '41520-431', 2000, 199,'284779202-3');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (11, '42291-619', 2012, 694, '284779202-3');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (12, '52125-808', 1987, 473, '197660168-1');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (13, '52125-808', 2000, 556, '197660168-1');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (14, '43269-652', 1997, 410, '284779202-3');
insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (15, '51079-169', 2001, 245, '197660168-1');
##1. Create a View showing all transactions for a given week in your business. 

use watchonline;
ALTER TABLE SALES
Add Yearweek_n int as (yearweek(Payment_date)) ;

create view  weeklytransactions as 
SELECT *
 FROM SALES
 WHERE (yearweek(Payment_date))= 202012;

USE DataMart;
create table Datamart.table1
SELECT *
 FROM watchonline.weeklytransactions;


##2. Create a trigger that stores stock levels once a sale takes place. 
use watchonline;

DELIMITER $$
 CREATE TRIGGER StockUpdate 
 AFTER INSERT ON watchonline.order_details 
 FOR EACH ROW 
  BEGIN 
    UPDATE Stock 
      SET Stock.QuantityStock = Stock.QuantityStock - new.QuantitySold
      where stock.ProductID = new.ProductID;
  END$$
DELIMITER ;


insert into Order_details (OrderDetailsID, OrderID, ProductID, QuantitySold, CustomerID) values (900, '62372-743', 2003, 100,'521163612-0');

##version 2
use watchonline;
DELIMITER $$
CREATE TRIGGER Returnedproducts 
 AFTER INSERT ON watchonline.Refunds
 FOR EACH ROW 
  BEGIN 
   UPDATE order_details 
      SET order_details.Quantitysold = order_details.Quantitysold - New.RefundQ
   where order_details.OrderID = new.OrderID;
  END $$
DELIMITER ;
#t test if trigger 2 works
insert into REFUNDS (ReturnN, OrderID, RefundQ, Refundpmt) values ('01-025-4538', '52125-808', 11, 70);
 
## 3. Create a View of stock (by supplier) purchased by you. 

use watchonline;
create view Stockpurchased as
SELECT St.ProductID, St.quantitystock,St.supplierID, S.S_name
FROM STOCK as St
inner join SUPPLIERS as S
ON St.SupplierID=S.SupplierID
group by SupplierID;

use DataMart;
create table datamart.table3 AS
select *
from watchonline.Stockpurchased;


##4 Total stock sold to general public (group by supplier).

use watchonline;
create view Stocksold as
SELECT Stock.ProductID, QuantitySold, SupplierID, Paymentamount
FROM STOCK
INNER JOIN ORDER_DETAILS
ON STOCK.PRODUCTID=ORDER_DETAILS.PRODUCTID
JOIN SALES
ON order_details.customerID= SALES.customerID
GROUP BY SupplierID;

use DataMart;
create table Datamart.table4
select * from watchonline.Stocksold;

##5. Detail and total all transactions (SALES) for the month-to-date. (A Group By with Roll-Up) OKKK

use watchonline;
SELECT SalesN,CustomerID,Payment_date,PaymentAmount, sum(Paymentamount) AS CumulativeRevenues
FROM SALES
WHERE Payment_date LIKE '2020-03-__%'
group by Payment_date with ROLLUP;


##. 6 Detail and total all SALES for the year-to-date. (A Group By with Roll-Up) OKKK
use watchonline;
SELECT * , sum(Paymentamount) AS CumulativeRevenues
FROM SALES
WHERE Payment_date LIKE '2020-__-__%'
group by Payment_date with ROLLUP;

##7. Detail & total transactions broken down on a monthly basis for 1 year. (A Group By with Roll-Up)

SELECT * , sum(Paymentamount) as Revenues
FROM SALES
WHERE YEAR(Payment_date)= '2019'
group by MONTH(Payment_date)
with ROLLUP;

##8. Display the growth in sales (as a percentage) for your business, 
##from the 1st month of opening until now.


SELECT monthname(payment_date), year(payment_date),
sum(Paymentamount) as Monthlysales,
sum(Paymentamount) - lag(sum(paymentamount),1) over 
(ORDER BY payment_date) AS Monthlydifference,
	round((sum(Paymentamount) - lag(sum(paymentamount),1) over (ORDER BY payment_date)) /
             (lag(sum(paymentamount), 1) OVER (ORDER BY payment_date)) * 100, 1)
              as Montlhydifference_perc
FROM SALES
group by month(payment_date)
order by payment_date;

