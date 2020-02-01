/*Update prices of product.*/
UPDATE product
SET price= 220.2
WHERE product_id=90001;

/*Update dates of the sale*/
UPDATE sale
SET sdate=to_date('02-FEB-2000','DD-MON-YYYY')
WHERE product_id=90002 AND branch_id=11111;

/*Change manager of a branch*/
UPDATE branch
SET manager_name='new_manager_name'
WHERE branch_id=11111;

/*Update contact details of the seller*/
UPDATE seller 
SET pHno=9893965437
WHERE seller_id=70010;

/*Increase or decrease the discount percentage of an ongoing sale in a particular branch*/
UPDATE sale
SET discount=discount+5
WHERE branch_id=11111 AND product_id=90001;

/*Update salary of employees*/
UPDATE employee
SET esalary=esalary+1000
WHERE emp_id=40028 and branch_id=11111;

/*Update bank details of the seller*/
UPDATE seller
SET bank_acc=703052820
WHERE seller_id=70019;

/* Update Total of Bill from product Bills */
UPDATE bill
SET total = (SELECT total FROM (SELECT bill_no, sum(price * ibill_quantity) AS total FROM product NATURAL JOIN prod_bill GROUP BY bill_no) t
WHERE t.bill_no = bill.bill_no);

/* Update Stock Quantity */
UPDATE stock
SET stock_quantity = stock_quantity - (SELECT sum(ibill_quantity) from bill NATURAL JOIN prod_bill 
WHERE branch_id = stock.branch_id AND product_id = stock.product_id 
GROUP BY product_id);
