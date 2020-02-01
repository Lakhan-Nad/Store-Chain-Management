create or replace trigger salary_update
before update of esalary on employee
for each row
begin
if (:new.esalary < :old.esalary) then
    :new.esalary := :old.esalary;
end if;
end;
