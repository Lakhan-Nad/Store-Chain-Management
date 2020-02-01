create or replace function popular_prod(branch1 number, branch2 number, productId number)
return number
as
branch3 number;
qbranch1 number := 0;
qbranch2 number := 0;
temp number;
cursor qb1 is select bill_no from bill where branch_id = branch1;
qb1d qb1%rowtype;
cursor qb2 is select bill_no from bill where branch_id = branch2;
qb2d qb2%rowtype;
begin
    open qb1;
    loop
        temp := 0;
        begin 
            fetch qb1 into qb1d;
            exit when qb1%NOTFOUND;
            select ibill_quantity into temp from prod_bill where product_id = productId and bill_no = qb1d.bill_no;
            exception
                when NO_DATA_FOUND then temp := 0;
        end;
        qbranch1 := qbranch1 + temp;
    end loop;
    close qb1;
    open qb2;
    loop
        temp := 0;
        begin 
            fetch qb2 into qb2d;
            exit when qb2%NOTFOUND;
            select ibill_quantity into temp from prod_bill where product_id = productId and bill_no = qb2d.bill_no;
            exception
                when NO_DATA_FOUND then temp := 0;
        end;
        qbranch2 := qbranch2 + temp;
    end loop;
    close qb2;
    if (qbranch1 > qbranch2) then branch3 := branch1;
    elsif (qbranch2 > qbranch1) then branch3 := branch2;
    else branch3 := 0;
    end if;
    return branch3;
end;
/

