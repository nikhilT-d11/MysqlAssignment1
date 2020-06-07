drop table if exists customerordercount;
-- Query OK, 0 rows affected (0.23 sec)

create table customerordercount (
    customerNumber int not null,
    orderCount bigint default 0,
    primary key (customerNumber),
    foreign key (customerNumber) references customers(customerNumber)
);
-- Query OK, 0 rows affected (0.35 sec)


# Pre-filling data
insert into customerordercount (customerNumber, orderCount)
    select customers.customerNumber, count(1) as orderCount
    from customers
    join orders
    using (customerNumber)
    group by customerNumber;
-- Query OK, 98 rows affected (0.13 sec)
-- Records: 98  Duplicates: 0  Warnings: 0

describe customerordercount;
/*
+----------------+------------+------+-----+---------+-------+
| Field          | Type       | Null | Key | Default | Extra |
+----------------+------------+------+-----+---------+-------+
| customerNumber | int(11)    | NO   | PRI | NULL    |       |
| orderCount     | bigint(20) | YES  |     | 0       |       |
+----------------+------------+------+-----+---------+-------+
2 rows in set (0.00 sec)
*/

drop trigger if exists after_order_update_orderCount;
-- Query OK, 0 rows affected, 1 warning (0.00 sec)
-- Note (Code 1360): Trigger does not exist

create trigger after_order_update_orderCount
    after insert
    on orders for each row
    insert into customerordercount (customerNumber, orderCount)
        values (new.customerNumber, 1)
        on duplicate key update orderCount = orderCount + 1;
-- Query OK, 0 rows affected (0.09 sec)