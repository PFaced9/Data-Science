use inclass;

#Q1
select Product, Price, sum(Quantity) as Quantity
from Bank_Inventory_pricing
group by Product, Price, Month
having sum(Quantity)>5;

#Q2
select Product, Quantity, Month, count(*) as Count
from Bank_Inventory_pricing
where Estimated_sale_price < purchase_cost
group by Product, Month, Quantity;

#Q3
select Estimated_sale_price
from Bank_Inventory_pricing
order by Estimated_sale_price desc
limit 2,1;

#Q4
select Product, count(Product) as Count
from bank_inventory_pricing
group by Product
having count(Product) > 1
order by Count;

#Q5
create or replace view bank_details as
select * from bank_inventory_pricing
where Product = "PayPoints" and Quantity>2;
select * from bank_details;

#Q6
insert into bank_details(Product, Quantity, Price) values ('PayPoints', 3, 410.67);
select * from bank_details;

#Q7
SELECT Branch, Product, SUM(revenue) - SUM(Cost) AS Real_Profit, SUM(Estimated_profit) AS Estimated_Profit
FROM bank_branch_pl
GROUP BY Branch, Product
HAVING Real_Profit > sum(Estimated_profit);

#Q8
SELECT Product, MIN(revenue - Cost) AS Least_Calculated_Profit
FROM bank_branch_pl
group by Product
order by Least_Calculated_Profit
limit 1;

#Q9
#a)
alter table bank_inventory_pricing modify Quantity varchar(10);

#b)
select lpad(Quantity, 3, '0') Quantity from bank_inventory_pricing;

#Q10
select FIRST_NAME, LAST_NAME from employee_details where FIRST_NAME like "%U%";

#Q11
select Product, Branch, sum(revenue) - sum(cost*0.7) as Real_Profit, sum(Estimated_profit)
from bank_branch_pl
group by Product, Branch
having Real_Profit > sum(Estimated_profit);

#Q12
SELECT * from bank_inventory_pricing where Product not in ("BusiCard", "SuperSave");

#Q13
select *
from bank_inventory_pricing
where Price between 220 and 300;

#Q14
select distinct(Product) from bank_inventory_pricing limit 5;

#Q15
update bank_inventory_pricing
set Price = Price * 1.15
where Quantity > 3;
select * from bank_inventory_pricing;

#Q16
select round(Price) as new_price from bank_inventory_pricing;

#Q17
alter table bank_inventory_pricing modify Product VARCHAR(30);

#Q18
select Product, Quantity, round(Price,2), round((Price+100),2) as new_price
from bank_inventory_pricing
where Quantity > 3;

#Q19
select bar_1.Customer_id,bar_1.Account_Number, bar_1.Account_type, bar_2.Account_Number, bar_2.Account_type
from bank_account_relationship_details bar_1
join bank_account_relationship_details bar_2
on bar_1.Account_Number = bar_2.Linking_Account_Number
where bar_2.Account_type like "%Credit%";

#Q20
select bar1.Account_Number as Main_Account,
       bar1.Account_Type as Main_Account_Type,
       sum(bat1.Transaction_amount) as Main_Account_Transaction_Amount,
       bar2.Account_Number as Linked_Account,
       bar2.Account_Type as Linked_Account_Type,
       sum(bat2.Transaction_amount) as Linked_Account_Transaction_Amount
from bank_account_relationship_details as bar1
left join bank_account_transaction as bat1
on  bar1.Account_Number = bat1.Account_Number
left join bank_account_relationship_details as bar2
ON  bar1.Account_Number = bar2.Linking_Account_Number
left join bank_account_transaction as bat2
ON  bar2.Account_Number = bat2.Account_Number
GROUP BY bar1.Account_Number,
         bar1.Account_Type,
         bar2.Account_Number,
         bar2.Account_Type;


#Q21
select bar.Account_Number,
       bar.Account_Type,
       sum(bat.Transaction_amount) as Total_Transaction_Amount
from bank_account_relationship_details as bar
left join bank_account_transaction as bat
on bar.Account_Number = bat.Account_Number
where bar.Account_Type = 'Credit Card' or bar.Account_Number in (
    select Linking_Account_Number
    from bank_account_relationship_details
    where Account_Type = 'Add-on Credit Card')
group by bar.Account_Number, bar.Account_Type;

#Q22
select
    bat1.account_number as primary_account_number,
    sum(bat2.transaction_amount) as current_month_transaction,
    date_format(bat2.transaction_date, '%Y-%m') as next_month_transaction_date,
    sum(bat1.transaction_amount) as prev_month_transaction,
    date_format(bat1.transaction_date, '%Y-%m') as previous_month_transaction_date
from bank_account_transaction as bat2
join bank_account_transaction as bat1
on bat2.account_number = bat1.account_number
and date_format(bat2.transaction_date, '%Y-%m') > date_format(bat1.transaction_date, '%Y-%m')
group by bat1.account_number,
         date_format(bat2.transaction_date, '%Y-%m'),
         date_format(bat1.transaction_date, '%Y-%m');

#Q23
select bat2.account_number as primary_account_num,
       sum(bat2.transaction_amount) as current_month_total,
       bat2.transaction_date as current_trans_date,
       sum(bat1.transaction_amount) as previous_month_total,
       bat1.transaction_date as prev_trans_date
from bank_account_transaction as bat2
join bank_account_transaction as bat1
on bat2.account_number = bat1.account_number
and bat2.transaction_date > bat1.transaction_date
group by bat2.account_number,
         bat2.transaction_date,
         bat1.transaction_date
having abs(sum(bat2.transaction_amount)) > abs(sum(bat1.transaction_amount));

#Q24
select count(bat.account_number) as total_credit_card_transactions
from bank_account_transaction as bat
join bank_account_relationship_details as bar
on bat.account_number = bar.account_number
where bar.account_type = 'Credit Card' or bar.account_number in (
    select linking_account_number
    from bank_account_relationship_details
    where account_type = 'Add-on Credit Card'
);

#Q25
select ed.EMPLOYEE_ID, ed.FIRST_NAME, ed.LAST_NAME, ed.PHONE_NUMBER, ed.SALARY, ed.JOB_ID
from employee_details as ed
join department_details as dd
on ed.DEPARTMENT_ID = dd.DEPARTMENT_ID
where dd.DEPARTMENT_NAME = 'Contracting';

#Q26
select bar1.account_number as savings_account,
bar2.account_number as recurring_deposit_account,
count(bat.account_number) as num_recurring_deposits
from bank_account_relationship_details as bar1
join bank_account_relationship_details as bar2
on bar1.account_number = bar2.linking_account_number
and bar1.account_type = 'SAVINGS'
and bar2.account_type = 'RECURRING DEPOSITS'
join bank_account_transaction as bat
on bar2.account_number = bat.account_number
group by bar1.account_number, bar2.account_number
having count(bat.account_number) > 4;

#Q27
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, EMAIL, JOB_ID
from employee_details
where JOB_ID != 'IT_PROG';

#Q29
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, JOB_ID
from employee_details
where MANAGER_ID not in (
    select DEPARTMENT_ID from Department_Details
    where MANAGER_ID=60);

#Q30
create table emp_dept as
select e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.EMAIL, e.PHONE_NUMBER, e.JOB_ID, e.SALARY, e.MANAGER_ID, e.DEPARTMENT_ID, d.DEPARTMENT_NAME, d.MANAGER_ID as DEPT_MANAGER_ID, d.LOCATION_ID
from employee_details as e
inner join department_details as d
on e.DEPARTMENT_ID = d.DEPARTMENT_ID;
select * from emp_dept;
