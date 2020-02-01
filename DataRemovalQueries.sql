/* Delete customer info if last purchase was a year ago */
DELETE FROM customer
where customer_email in
(SELECT customer_email FROM customer NATURAL JOIN bill
GROUP BY customer_email
HAVING max(bdate) < add_months(SYSDATE,-12));

/* Delete Stock if quantity reaches 0 */
DELETE FROM stock
WHERE stock_quantity = 0;

/* Delete Sale info if its over */
DELETE FROM sale
WHERE edate < SYSDATE;

/* Delete bill info if purchase was made a year ago */

/*Deleting Child Records */
DELETE FROM prod_bill
WHERE EXISTS 
(SELECT 1 from bill 
 WHERE bill_no = prod_bill.bill_no
 AND 
 bdate < add_months(SYSDATE,-12)
)
/*Deleting Parent Record */
DELETE FROM bill
WHERE bdate < add_months(SYSDATE,-12);

/* Remove Seller Info If no purchase has been made from him in last 1 year */
DELETE FROM seller S WHERE NOT EXISTS
(SELECT max(sdate) FROM seller_bill WHERE seller_id = S.seller_id AND sdate > add_months(SYSDATE,-12)
GROUP BY seller_id);