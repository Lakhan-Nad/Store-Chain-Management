create or replace trigger employee_salary_update
before update of esalary on employee
for each row
begin
if(SYSDATE - :old.join_date < 180) then
    raise_application_error(-20000,'Invalid Update Option');
end if;
end;
/