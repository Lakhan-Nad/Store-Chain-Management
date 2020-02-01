insert into branch values (&branch_id,'&city',&managerid,'&manager_name', &pin_code);

insert into employee values (&emp_id, '&ename', &esalary, '&join_date', &branch_id);

insert into customer values ('&customer_email', &contac_no, '&customer_name');

insert into seller values (&seller_id,&bank_acc,'&semail','&sname',&phno);

insert into product values (&product_id, '&product_name', '&product_desc', &price);

insert into stock values (&product_id, &branch_id, &stock_quantity);

insert into sale values (&product_id,&branch_id,'&sdate','&edate',&discount);

insert into bill values (&bill_no,'&customer_email','&bdate',&total,&branch_id);

insert into prod_bill values (&product_id, &bill_no, &ibill_quantity);

insert into seller_bill values (&seller_id,&product_id,&squantity,'&sdate');




