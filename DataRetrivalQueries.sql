/* Retrieve Branch Wise Data Of All Employees */
SELECT * FROM employee
ORDER BY branch_id;

/* Upcoming sales in 3 months */
SELECT * FROM sale 
WHERE add_months(SYSDATE, 3) BETWEEN sdate AND edate;

/* Find total sale in a branch within last 3 months */
SELECT SUM(total) FROM bill 
WHERE branch_id = 11111 AND 
bdate BETWEEN add_months(SYSDATE, -3) and SYSDATE;

/* Customers who have visited more than thrice in a particular branch */
SELECT customer_email, count(*) FROM customer C NATURAL JOIN bill
WHERE branch_id = 11111
GROUP BY customer_email
HAVING COUNT(*) > 3;

/* Most purchased product on a particular day */
SELECT * FROM product WHERE
product_id IN (SELECT product_id FROM (SELECT product_id, sum(ibill_quantity) AS total_qty FROM bill NATURAL JOIN prod_bill 
GROUP BY (product_id)
ORDER BY total_qty DESC)
WHERE ROWNUM < 2);

/* 5 most costly products in supply chain */
SELECT * FROM (SELECT * FROM product
ORDER BY price DESC)
WHERE ROWNUM < 6;

/* Find details of customers who visited a particular branch */
SELECT * FROM customer WHERE
customer_email IN (SELECT DISTINCT(customer_email) FROM BILL 
WHERE branch_id = 11111);

/* Number of Employees working in various branches */
SELECT branch_id, count(*) FROM employee
GROUP BY branch_id;

/* Details of product bought on a particular day */
SELECT product_id,sum(squantity)
FROM product NATURAL JOIN seller_bill
WHERE sdate = SYSDATE
GROUP BY product_id;

/* Get last purchase dates of customers */
SELECT customer_email, max(bdate) AS LAST_PURCHASE_DATE FROM customer NATURAL JOIN bill
GROUP BY customer_email;

/* Get Data of all newly joined employees whose salary is either grater than 500000 or less than 200000 */
SELECT * FROM employee WHERE esalary > 500000
UNION
SELECT * FROM employee WHERE esalary < 200000;

/* Get details of Seller who sells all the products */
SELECT * FROM seller S WHERE NOT EXISTS
(SELECT product_id FROM product
MINUS
SELECT DISTINCT(product_id) FROM seller_bill WHERE seller_id = S.seller_id);

