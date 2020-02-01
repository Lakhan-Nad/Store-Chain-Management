create or replace trigger stock_availability
before insert on prod_bill
for each row
declare 
branchId number;
productId number;
quantity number;
begin
select branch_id into branchId from bill where bill.bill_no = :new.bill_no;
productId := :new.product_id;
select stock_quantity into quantity from stock where product_id = productId and branch_id = branchId;
if(quantity >= :new.ibill_quantity) then
    quantity := quantity - :new.ibill_quantity;
else
    :new.ibill_quantity := quantity;
    quantity := 0;
end if;
update stock
set stock_quantity = quantity
where product_id = productId and branch_id = branchId;
end;
/
