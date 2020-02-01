create or replace trigger stock_empty 
before insert or update on stock
for each row
begin
if(:new.stock_quantity < 0) then
    raise_application_error(-21000, 'not that much quantity available');
end if;
end;