start transaction;
-- Query OK, 0 rows affected (0.01 sec)

# Creating a new customer
select @newCustomerNumber := max(customerNumber) + 1 from customers;
/*
+-----------------------------------------------+
| @newCustomerNumber := max(customerNumber) + 1 |
+-----------------------------------------------+
|                                           497 |
+-----------------------------------------------+
1 row in set (0.00 sec)
*/

insert into customers (customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, city, country)
values (@newCustomerNumber, 'Customer1', 'ContactL', 'ContactF', '1111111111', 'AddressLine1', 'City', 'Country');
-- Query OK, 1 row affected (0.00 sec)



# Placing an order for motorcycle
select @newOrderNumber := max(orderNumber) + 1 from orders;
/*
+-----------------------------------------+
| @newOrderNumber := max(orderNumber) + 1 |
+-----------------------------------------+
|                                   10426 |
+-----------------------------------------+
1 row in set (0.00 sec)
*/

insert into orders (orderNumber, orderDate, requiredDate, status, customerNumber)
values (@newOrderNumber, '2020-6-7', '2020-7-6', 'In Process', @newCustomerNumber);
-- Query OK, 1 row affected (0.00 sec)

# 5% discount
select @motorcycleCode := productCode, @price := round(MSRP*0.95, 2) from products where productLine = 'Motorcycles' limit 1;
/*
+--------------------------------+-------------------------------+
| @motorcycleCode := productCode | @price := round(MSRP*0.95, 2) |
+--------------------------------+-------------------------------+
| S10_1678                       |                         90.92 |
+--------------------------------+-------------------------------+
1 row in set (0.00 sec)
*/

insert into orderdetails (orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
values (@newOrderNumber, @motorcycleCode, 1, @price, 1);
-- Query OK, 1 row affected (0.00 sec)



# Payment
insert into payments (customerNumber, checkNumber, paymentDate, amount, orderNumber)
values (@newCustomerNumber, 'MN899234', '2020-6-7', @price, @newOrderNumber);
-- Query OK, 1 row affected (0.00 sec)



commit;