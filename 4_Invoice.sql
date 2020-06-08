select @recentOrderNumber := max(orderNumber) - 1 from orders;
/*
+----------------------------------------+
| @recentOrderNumber := max(orderNumber) |
+----------------------------------------+
|                                  10425 |
+----------------------------------------+
1 row in set (0.00 sec)
*/

select @customerNumber := customerNumber from orders where orderNumber = @recentOrderNumber;
/*
+-----------------------------------+
| @customerNumber := customerNumber |
+-----------------------------------+
|                               119 |
+-----------------------------------+
1 row in set (0.00 sec)
*/

select temp.customerName,
       @recentOrderNumber as orderNumber,
       temp.shippedDate,
       temp.paymentDate,
       temp.amount,
       orderdetails.quantityOrdered,
       products.productName,
       productlines.image
from (
        select customers.customerName,
               orders.shippedDate,
               payments.paymentDate,
               payments.amount
        from customers, orders, payments
        where customers.customerNumber = @customerNumber
            and orders.orderNumber = @recentOrderNumber
            and payments.customerNumber = @customerNumber
    ) as temp, orderdetails, products, productlines
where orderdetails.orderNumber = @recentOrderNumber
    and products.productCode = orderdetails.productCode
    and productlines.productLine = products.productLine;

/*
+-------------------+-------------+-------------+-------------+----------+-----------------+-------------------------------------+-------+
| customerName      | orderNumber | shippedDate | paymentDate | amount   | quantityOrdered | productName                         | image |
+-------------------+-------------+-------------+-------------+----------+-----------------+-------------------------------------+-------+
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              38 | 1962 LanciaA Delta 16V              | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              33 | 1957 Chevy Pickup                   | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              28 | 1998 Chrysler Plymouth Prowler      | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              38 | 1964 Mercedes Tour Bus              | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              19 | 1926 Ford Fire Engine               | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              28 | 1992 Ferrari 360 Spider red         | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              38 | 1940s Ford truck                    | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              55 | 1970 Dodge Coronet                  | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              49 | 1962 Volkswagen Microbus            | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              31 | 1958 Chevy Corvette Limited Edition | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              41 | 1980’s GM Manhattan Express         | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              11 | 1954 Greyhound Scenicruiser         | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-11-14  | 19501.82 |              18 | Diamond T620 Semi-Skirted Tanker    | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              38 | 1962 LanciaA Delta 16V              | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              33 | 1957 Chevy Pickup                   | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              28 | 1998 Chrysler Plymouth Prowler      | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              38 | 1964 Mercedes Tour Bus              | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              19 | 1926 Ford Fire Engine               | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              28 | 1992 Ferrari 360 Spider red         | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              38 | 1940s Ford truck                    | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              55 | 1970 Dodge Coronet                  | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              49 | 1962 Volkswagen Microbus            | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              31 | 1958 Chevy Corvette Limited Edition | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              41 | 1980’s GM Manhattan Express         | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              11 | 1954 Greyhound Scenicruiser         | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2004-08-08  | 47924.19 |              18 | Diamond T620 Semi-Skirted Tanker    | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              38 | 1962 LanciaA Delta 16V              | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              33 | 1957 Chevy Pickup                   | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              28 | 1998 Chrysler Plymouth Prowler      | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              38 | 1964 Mercedes Tour Bus              | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              19 | 1926 Ford Fire Engine               | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              28 | 1992 Ferrari 360 Spider red         | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              38 | 1940s Ford truck                    | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              55 | 1970 Dodge Coronet                  | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              49 | 1962 Volkswagen Microbus            | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              31 | 1958 Chevy Corvette Limited Edition | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              41 | 1980’s GM Manhattan Express         | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              11 | 1954 Greyhound Scenicruiser         | NULL  |
| La Rochelle Gifts |       10425 | NULL        | 2005-02-22  | 49523.67 |              18 | Diamond T620 Semi-Skirted Tanker    | NULL  |
+-------------------+-------------+-------------+-------------+----------+-----------------+-------------------------------------+-------+
39 rows in set (0.00 sec)
*/

/* explain <query> output
+----+-------------+--------------+------------+--------+---------------------+---------+---------+----------------------------------------+------+----------+-------+
| id | select_type | table        | partitions | type   | possible_keys       | key     | key_len | ref                                    | rows | filtered | Extra |
+----+-------------+--------------+------------+--------+---------------------+---------+---------+----------------------------------------+------+----------+-------+
|  1 | SIMPLE      | customers    | NULL       | const  | PRIMARY             | PRIMARY | 4       | const                                  |    1 |   100.00 | NULL  |
|  1 | SIMPLE      | orders       | NULL       | const  | PRIMARY             | PRIMARY | 4       | const                                  |    1 |   100.00 | NULL  |
|  1 | SIMPLE      | payments     | NULL       | ref    | PRIMARY             | PRIMARY | 4       | const                                  |    3 |   100.00 | NULL  |
|  1 | SIMPLE      | orderdetails | NULL       | ref    | PRIMARY,productCode | PRIMARY | 4       | const                                  |   13 |   100.00 | NULL  |
|  1 | SIMPLE      | products     | NULL       | eq_ref | PRIMARY,productLine | PRIMARY | 17      | classicmodels.orderdetails.productCode |    1 |   100.00 | NULL  |
|  1 | SIMPLE      | productlines | NULL       | eq_ref | PRIMARY             | PRIMARY | 52      | classicmodels.products.productLine     |    1 |   100.00 | NULL  |
+----+-------------+--------------+------------+--------+---------------------+---------+---------+----------------------------------------+------+----------+-------+
*/