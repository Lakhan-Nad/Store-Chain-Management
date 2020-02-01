create or replace procedure DISPLAY_BILL (bill_number number)
as
c_name customer.customer_name%type;
c_email customer.customer_email%type;
bill_date bill.bdate%type;
bill_total bill.total%type;
cursor prod_list is 
    select product_id, product_name, ibill_quantity, price from prod_bill natural join product
    where bill_no = bill_number;
products_data prod_list%rowtype;
ptotal bill.total%type;
begin
    select customer_name,customer_email into c_name,c_email from customer
    where customer_email in (select customer_email from bill where bill_no = bill_number);
    select bdate, total into bill_date,bill_total from bill where bill_no = bill_number;
    dbms_output.put_line(chr(10));
    dbms_output.put_line('BILL NUMBER: ' || bill_number);
    dbms_output.put_line('BILL DATE: ' || bill_date);
    dbms_output.put_line('CUSTOMER NAME: ' || c_name);
    dbms_output.put_line('CUSTOMER EMAIL: ' || c_email);
    dbms_output.put_line(rpad('NAME',25,' ') || rpad('ID',10,' ') || rpad('PRICE',10, ' ') || rpad('QTY.',7, ' ') || rpad('TOTAL',10, ' '));
    open prod_list;
    loop
        fetch prod_list into products_data;
        exit when prod_list%NOTFOUND;
        ptotal := products_data.price * products_data.ibill_quantity;
        dbms_output.put_line(rpad(products_data.product_name,25,' ') || rpad(products_data.product_id,10,' ') || 
        rpad(products_data.price,10, ' ') || rpad(products_data.ibill_quantity,7, ' ') || rpad(ptotal,10, ' '));
    end loop;
    close prod_list;
    dbms_output.put_line('BILL TOTAL: ' || bill_total);
    dbms_output.put_line(chr(10));
end;
/