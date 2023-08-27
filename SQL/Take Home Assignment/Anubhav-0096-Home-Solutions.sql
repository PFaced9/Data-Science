CREATE DATABASE takehome;
USE takehome;

SELECT * FROM department_details;  
SELECT * FROM employee_details;
SELECT * FROM property_price_train_new pptn;

-- Answer 1 - 
UPDATE property_price_train_new 
SET Sale_Price = Sale_Price * (1.15) 
WHERE Sale_Condition = 'Normal';

-- Answer 2 - 
ALTER TABLE property_price_train_new 
MODIFY BsmtUnfSF varchar(30);

-- Answer 3 -
SELECT  lpad(convert(Garage_Size, char), 4, "0") 
FROM Property_Price_Train_new;

-- Answer 4 -
SELECT Brick_Veneer_Area, Brick_Veneer_Type 
FROM property_price_train_new pptn 
WHERE Brick_Veneer_Type <> 'None' 
AND Brick_Veneer_Type <> 'BrkCmn';

-- Answer 5 -
SELECT W_Deck_Area 
FROM property_price_train_new pptn 
WHERE W_Deck_Area < 0;

-- Answer 6 -
SELECT Brick_Veneer_Type 
FROM property_price_train_new pptn 
WHERE Brick_Veneer_Type 
LIKE  "%___e";

-- Answer 7 -
SELECT REPLACE(Pool_Quality, 'NA', 'Null')
AS Pool_Quality_new
FROM property_price_train_new pptn;

-- Answer 8 - 
SELECT count(Miscellaneous_Feature)
FROM property_price_train_new pptn 
WHERE Miscellaneous_Feature = 'NA';

SELECT count(Pool_Quality)
FROM property_price_train_new pptn 
WHERE Pool_Quality = 'NA';

-- Answer 10 -
SELECT table_schema 
AS 'db_name', ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) 
AS "Size (MB)" FROM information_schema.TABLES 
GROUP BY table_schema;

-- Answer 11 - 
SELECT Brick_Veneer_Area, Exterior_Material, BsmtFinSF1
FROM property_price_train_new pptn 
WHERE Remodel_Year 
BETWEEN 1950 AND 1976;

-- Answer 12 - 
SELECT Brick_Veneer_Area, Exterior_Material, BsmtFinSF1, Remodel_Year, Sale_Price
FROM property_price_train_new pptn 
WHERE Sale_Price > 
(SELECT avg(Sale_Price) 
FROM property_price_train_new pptn2); 

-- Answer 13 -
CREATE or REPLACE view check_id AS
SELECT employee_id , first_name , last_name, manager_id 
FROM employee_details 
WHERE  MANAGER_ID 
BETWEEN 100 AND 124;

-- Answer 14 -
UPDATE check_id SET employee_id = '131' 
WHERE first_name='Anubhav' 
AND last_name='Gupta';

-- Answer 15 -
DELETE FROM employee_details WHERE EMPLOYEE_ID = '104';

-- Answer 16 - 
SELECT employee_id , first_name ,last_name phone_number ,salary, job_id
FROM employee_details ed 
WHERE DEPARTMENT_ID NOT IN (SELECT DEPARTMENT_ID FROM department_details dd 
WHERE department_name = 'Contracting');

-- Answer 17 - 
SELECT first_name , last_name department_id 
FROM employee_details ed 
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM department_details dd WHERE
LOCATION_ID = '1700');

-- Answer 18 -
SELECT employee_id, first_name, last_name, job_id, department_id 
FROM employee_details ed 
WHERE MANAGER_ID = EMPLOYEE_ID;

-- Answer 19 -
SELECT email 
FROM employee_details ed 
WHERE email LIKE '%@gmail.com%' OR '%@yahoo.com%';
















