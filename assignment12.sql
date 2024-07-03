 create database pizza_shop;
 CREATE TABLE `customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `customer_name` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL
);
CREATE TABLE `pizza_shop`.`order` (
  `order_date_time` DATETIME NOT NULL,
  `customer_id` INT NULL,
  `order_id` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`order_id`),
  CONSTRAINT `customer_id`
    FOREIGN KEY (customer_id)
    REFERENCES `pizza_shop`.`customer` (customer_id));
CREATE TABLE `pizza_shop`.`pizza` (
  `pizza_id` INT NOT NULL AUTO_INCREMENT,
  `pizza_name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`pizza_id`));
  CREATE TABLE `pizza_shop`.`pizza_order` (
  `order_id` INT NULL,
  `pizza_id` INT NULL,
  `order_pizza_id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NOT NULL,
  PRIMARY KEY (`order_pizza_id`),
  CONSTRAINT `pizza_id`
    FOREIGN KEY (pizza_id)
    REFERENCES `pizza_shop`.`pizza` (pizza_id)
   ,
  CONSTRAINT `order_id`
    FOREIGN KEY (order_id)
    REFERENCES `pizza_shop`.`orders` (order_id));


 insert into pizza_shop.pizza(pizza_name,price) values('Pepperoni & Cheese' , 7.99),
 ('Vegetarian' ,9.99),('Meat Lovers',14.99),('Hawaiian',12.99);
  insert into pizza_shop.customer(customer_name,phone_number) values('Trevor page','226-555-4982'),('John Doe','555-555-9498');
 insert into pizza_shop.orders(order_date_time,customer_id) values('2023-09-10 09:47:00',1),('2023-09-10 13:20:00',2),('2023-09-10 09:47:00',1),('2023-10-10 10:37:00',2);
 insert into pizza_shop.pizza_order(order_id,pizza_id,quantity)values(17,1,1),(17,3,1),(18,2,1),(18,3,2),(19,3,1),(19,4,1),(20,2,3),(20,4,1);
 SELECT 
    c.customer_name,
    SUM(p.price * od.quantity) AS total_spent
 FROM
    pizza_shop.customer c
    JOIN orders o ON c.customer_id = o.customer_id
     JOIN pizza_order od ON o.order_id = od.order_id
    JOIN pizza p ON od.pizza_id = p.pizza_id
 GROUP BY 
    c.customer_id, c.customer_name
 ORDER BY 
    total_spent DESC;
   SELECT
    c.customer_name,
    DATE(o.order_date_time) AS order_date,
    SUM(p.price * po.quantity) AS total_spent
FROM
    customer c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN pizza_order po ON o.order_id = po.order_id
    JOIN pizza p ON po.pizza_id = p.pizza_id
GROUP BY
    c.customer_id, c.customer_name, order_date
ORDER BY
    c.customer_name, order_date;