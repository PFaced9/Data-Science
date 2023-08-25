use property_new;
select * from property_price_train_new;

#Q1.Update Sale_Price column of property_price_train_new with an increase of 15%  when the Sale_condition is Normal.
Update property_price_train_new set Sale_Price = Sale_Price * 1.15 Where Sale_condition = "Normal";

#Q2.Increase the length of BsmtUnfSF column size by 30 characters from property_price_train_new.
Alter table  property_price_train_new modify BsmtUnfSF VARCHAR (30);

#Q3. In property_price_train_new, 
-- a) convert Quantity data type from numeric to character 
-- b) Add then, add zeros before the Quantity field.  
SELECT lpad( convert(Garage_Size , char) , 4, "0")  from property_price_train_new;

#Q4.Write a MySQL query to print the observations from the columns “Brick_Veneer_Area” and “Brick_Veneer_Type” of the table “Property_Price_Train_new”, excluding the values “None” And “BrkCmn” from the column “Brick_Veneer_Type”.
SELECT
Brick_Veneer_Area, Brick_Veneer_Type 
FROM Property_Price_Train_new  
WHERE Brick_Veneer_Type NOT IN ('None','BrkCmn');

#Q5. Extract all negative values from the column “W_Deck_Area”.
Select W_Deck_Area from Property_Price_Train_new where W_Deck_Area < 0;

#Q6.Write a MySQL query to print the observations of the table “Property_Price_Train_new” where the values of the column “Brick_Veneer_Type” ends with “e” and contains 4 alphabets.
Select Brick_Veneer_Type from Property_Price_Train_new where Brick_Veneer_Type like '____e';

#Q7. Replace NA values with 'Null' for column Pool_Quality and show result is new column 'Pool_Quality_new' 
SELECT REPLACE(Pool_Quality,'NA','null') AS Pool_Quality_new 
FROM Property_Price_Train_new;

#Q7. Check Miscellaneous_Feature and Pool_Quality columns contains how many NA values. 
select count(Pool_Quality) from Property_Price_Train_new where Pool_Quality = 'NA';
select count(Miscellaneous_Feature) from Property_Price_Train_new where Miscellaneous_Feature = 'NA';

#Q8 If Miscellaneous_Feature and Pool_Quality contains count of NA value greater than 80 delete those column.
ALTER TABLE Property_Price_Train_new
    DROP COLUMN Pool_Quality,
    DROP COLUMN Miscellaneous_Feature;
    
#Q9. Display size of each database in mysql server.
SELECT table_schema 'db_name',
round(((data_length + index_length) / 1024 / 1024), 2) AS  "Size (MB)"
FROM information_schema.TABLES 
GROUP BY table_schema;

#Q10. Display Brick_Veneer_Area, Exterior_Material, BsmtFinSF1 when remodel_year was between 1950 - 1976
select Brick_Veneer_Area, Exterior_Material, BsmtFinSF1, Remodel_Year 
from property_price_train_new where Remodel_Year between 1950 and 1976;

#Q11. Q1. Retrive Brick_Veneer_Area, Exterior_Material, BsmtFinSF1, Remodel_Year and Sale_Pricey from property_price_train_new table and display only those columns whose Sale_Price is greater than average Sale_Price.
SELECT Brick_Veneer_Area,Exterior_Material,BsmtFinSF1,Remodel_Year,Sale_Price
       FROM property_price_train_new WHERE Sale_Price > 
	        (SELECT AVG(Sale_Price) FROM property_price_train_new);
            
select * from employee_details;

#Q12. Create view 'check_id' that contains columns employee_id , first_name , last_name and manager_id that is between 100 and 114.
CREATE VIEW check_id AS
SELECT employee_id, first_name, last_name
FROM  employee_details
WHERE manager_id between 100 and 114
WITH CHECK OPTION;
select * from check_id;

#Q13 Update view check_id and add new record in check_id.
-- --example(employee_id=121, first_name=Bob, last_name=Tan)
UPDATE check_id
   SET employee_id = '113'
    WHERE first_name = 'Bob' and last_name = 'Tan';
    
#Q14. Delete record from check_id view where employee_id is 104
delete from check_age1
where employee_id = '104';
select * from check_age1;

#Q15. From employee_details retrieve only employee_id , first_name ,last_name phone_number ,salary, job_id where department_name is Contracting (Note
#Department_id of employee_details table must be other than the list within IN operator.
SELECT employee_id , first_name,last_name,phone_number,salary, job_id
FROM employee_details
WHERE DEPARTMENT_ID NOT IN(
SELECT DEPARTMENT_ID FROM Department_Details
WHERE DEPARTMENT_NAME='Contracting');

#Q16. Display first_name , last_name and department_id from table employee where location_id =1700 from department table.
 SELECT FIRST_NAME, LAST_NAME,DEPARTMENT_ID 
   FROM employee_details WHERE DEPARTMENT_ID= ANY
   (SELECT DEPARTMENT_ID FROM Department_Details WHERE LOCATION_ID=1700); 

#Q17. From the table (employees_details) find employees (employee_id, first_name, last_name, job_id, department_id) where manager_id is equal to employee_id.
SELECT employee_id, FIRST_NAME, LAST_NAME, JOB_ID, DEPARTMENT_ID 
FROM employee_details E 
WHERE EXISTS (SELECT * FROM employee_details WHERE MANAGER_ID = E.EMPLOYEE_ID);

#Q18. Check whether the email_id is valid or not from employee_details
SELECT email, email REGEXP '^[A-Za-z0-9._%\-+!#$&/=?^|~]+@[A-Za-z0-9.-]+[.][A-Za-z]+$' AS valid_email FROM employee_details;