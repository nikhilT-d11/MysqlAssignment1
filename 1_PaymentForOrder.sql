alter table payments
add orderNumber int;
-- Query OK, 0 rows affected (0.99 sec)
-- Records: 0  Duplicates: 0  Warnings: 0

alter table payments
add foreign key (orderNumber) references orders(orderNumber);
-- Query OK, 273 rows affected (1.73 sec)
-- Records: 273  Duplicates: 0  Warnings: 0

/*
 * some orders may not have payments, like cancelled orders, etc...
 * so orderNumber column in payments is allowed to have null value
*/