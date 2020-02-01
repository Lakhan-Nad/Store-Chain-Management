create or replace trigger customer_trigger
before insert on bill
for each row
declare 
c number;
begin
    select count(*) into c from bill where customer_email = :new.customer_email group by customer_email;
    exception
    when NO_DATA_FOUND then
        :new.total := :new.total * 0.80;
        dbms_output.put_line('You Got 20% Off Coz This Is Your 1st Shopping At Our Stores.');
end;
/
