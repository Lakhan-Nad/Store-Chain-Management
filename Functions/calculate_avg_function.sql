create or replace function avg_sale(dateavg  in date)
return number
as
average number;
cursor branches is
    select branch_id from branch;
branch_data branches%rowtype;
branch_count number;
branch_sum number;
begin
    select count(branch_id) into branch_count from branch;
    average := 0;
    open branches;
    loop
        begin
            fetch branches into branch_data;
            exit when branches%NOTFOUND;
            select sum(total) into branch_sum from bill where branch_id = branch_data.branch_id and bdate = dateavg;
            if branch_sum is null then
                branch_sum := 0;
            end if;
        end;
        average := average + branch_sum;
    end loop;
    close branches;
    average := average / branch_count;
    return(average);
end;
/

