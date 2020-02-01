create table branch (
    branch_id       number(5) ,
    city            varchar(10) ,
    manager_id      number(5),
    manager_name    varchar(20),
    pin_code        number(6),
    primary key(branch_id),
    check (pin_code > 100000),
    check(manager_id is NOT NULL)
);

create table employee(
    emp_id  number(5) ,
    ename  VARCHAR(20) ,
    esalary number(9,2) ,
    join_date DATE,
    branch_id references branch,
    primary key(emp_id,branch_id),
    check (length(ename) > 0),
    check (esalary between 10000.00 and 99999999.00)
);


create table customer(
    customer_email varchar(50), 
    contact_no number(10),
    customer_name varchar(10),
    primary key(customer_email),
    check (regexp_like(customer_email,'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$','i')),
    check(regexp_like(to_char(contact_no),'^[6789][0-9]{9}$'))
);

create table product (
    product_id number(5) ,
    product_name varchar(20),
    product_desc varchar(40),
    price number(5,2),
    primary key(product_id),
    check (price > 0),
    check (length(product_name) > 0)
);


CREATE TABLE stock(
    product_id  references product,
    branch_id   references branch,
    stock_quantity    number(3),
    primary key(product_id,branch_id)
);

create table sale(
    product_id  references product,
    branch_id references branch,
    sdate  date,
    edate date,
    discount number(4,2),
    primary key(product_id,branch_id),
    check (sdate < edate),
    check (discount between 01.00 and 99.99) 
);

create table bill(
    bill_no number(4),
    customer_email references customer,
    bdate DATE,
    total number(9,2),
    branch_id references branch,
    primary key(bill_no),
    check (total > 1.00)
);

create table seller(
    seller_id number(5) ,
    bank_acc number(9),
    semail varchar(50),
    sname varchar(10),
    phno number(10),
    primary key(seller_id),
    check (phno >= 1000000000),
    check (bank_acc >= 10000000)
);

create table prod_bill(
    product_id references product,
    bill_no references bill,
    ibill_quantity number(2),
    primary key(product_id,bill_no),
    check (ibill_quantity between 1 and 100)
);

create table seller_bill(
    seller_id references seller,
    product_id references product,
    squantity number(3),
    sdate date,
    primary key(seller_id,product_id,sdate),
    check (squantity between 9 and 9999)
);
