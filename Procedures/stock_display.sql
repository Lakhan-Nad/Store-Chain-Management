create or replace procedure show_stocks (branchId number)
as
cursor stock_list is
    select product_id, stock_quantity from stock
    where branch_id = branchId;
stock_data stock_list%rowtype;
pname  product.product_name%type;
pprice product.price%type;
pdesc  product.product_desc%type;
psaled  sale.discount%type;
psalesd sale.sdate%type;
psaleed sale.edate%type;
begin
    dbms_output.put_line('Branch Id: ' || branchId);
    dbms_output.put_line(rpad('NAME',17,' ')||rpad('ID',7,' ')||rpad('DESCRIPTION',20,' ')||rpad('PRICE',7,' ')||
    rpad('Qty',5,' ')||rpad('SALE',6,' ')||rpad('Sale_Start',15,' ')||rpad('Sale_End',15,' '));
    open stock_list;
    loop
        begin
            fetch stock_list into stock_data;
            exit when stock_list%NOTFOUND;
            select product_name,product_desc,price into pname,pdesc,pprice from product where product_id = stock_data.product_id;
            select discount,sdate,edate into psaled,psalesd,psaleed from sale where product_id = stock_data.product_id and branch_id = branchId;
            exception 
                when NO_DATA_FOUND then
                psaled := 0;
                psalesd := null;
                psaleed := null;
        end;
        dbms_output.put_line(rpad(pname,17,' ')||rpad(stock_data.product_id,7,' ')||rpad(pdesc,20,' ')||
        rpad(stock_data.stock_quantity,5,' ')||rpad(pprice,7,' ')||rpad(psaled,6,' ')||rpad(psalesd,15,' ')||rpad(psaleed,15,' '));
    end loop;
    close stock_list;
end;
/




