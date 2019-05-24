-- grant all privileges to CSY2038_99 identified by CSY2038_99;


--DROP CHECK IN CONSTRAINTS

--DROP FOREIGN KEYS
ALTER TABLE FURNITURE_REVIEWS
DROP CONSTRAINT fk_fr_customers;

ALTER TABLE furniture_reviews
DROP CONSTRAINT fk_fr_furniture;

ALTER TABLE furniture_used
DROP CONSTRAINT fk_fu_furniture;

ALTER TABLE furniture_used
DROP CONSTRAINT fk_fu_customer_rooms;

ALTER TABLE customer_rooms
DROP CONSTRAINT fk_cr_customers;


--DROP PRIMARY KEYS
ALTER TABLE FURNITURE_USED
DROP CONSTRAINT pk_furniture_used;

ALTER TABLE FURNITURE_REVIEWS
DROP CONSTRAINT pk_furniture_reviews

ALTER TABLE furniture
DROP CONSTRAINT pk_furniture

ALTER TABLE CUSTOMER_ROOMS
DROP CONSTRAINT pk_customer_rooms;

ALTER TABLE CUSTOMERS
DROP CONSTRAINT pk_customers

--DROP FUNCTIONS
drop FUNCTION "FUNC_FURN_ORDER"
/

drop FUNCTION "FUNC_TOTAL_MONEY_SPENT"
/

drop FUNCTION "FUNC_COUNT_FURN_ORD_QUANTITY"
/

drop FUNCTION "FUNC_COUNT_FURN_ORDERED"
/

drop FUNCTION "FUNC_COUNT_ROOMS"
/

drop FUNCTION "FUNC_GET_ITEM_RATING"
/

drop FUNCTION "FUNC_COUNT_FURN_BY_CAT"
/

drop FUNCTION "FUNC_COUNT_CUSTOMERS"
/

drop FUNCTION "FUNC_COUNT_KEYS"
/

--DROP PROCEDURES
drop PROCEDURE "PROC_CALC_DISCOUNT"
/

drop PROCEDURE "PROC_COUNT_FURN_BYCUSTOMER"
/

drop PROCEDURE "PROC_UPDATE_RATING"
/

drop PROCEDURE "PROC_DELETE_FURN_ITEM"
/

drop PROCEDURE "PROC_CUR_AVG"
/

drop PROCEDURE "PROC_CUR_FURN_PRICE"
/

drop PROCEDURE "PROC_CUR_CONSTRAINTS"
/


drop PROCEDURE "PROC_CUR_OBJECTS"
/

--DROP TRIGGERS
drop TRIGGER "TRIG_GEN_USERNAME"
/

drop TRIGGER "TRIG_FURN_PRICE_QUANTITY"
/

drop TRIGGER "TRIG_FURN_QUANTITY_CHECK"
/

drop TRIGGER "TRIG_LOGIN_LOG"
/

drop TRIGGER "TRIG_LOGOUT_LOG"
/

drop TRIGGER "TRIG_CONVERT_UPPER"
/

drop TRIGGER "TRIG_DATE_CHECK"
/

drop TRIGGER "TRIG_RATING_GEN"
/

drop TRIGGER "TRIG_CUSTOMER_LOGGING"
/

drop TRIGGER "TRIG_FURNITURE_LOGGING"
/

drop TRIGGER "TRIG_FURNITURE_USED_LOGGING"
/

drop TRIGGER "TRIG_FURNITURE_REVIEWS_LOGGING"
/

drop TRIGGER "TRIG_CUSTOMER_ROOMS_LOGGING"
/

--DROP TABLES
drop TABLE "FURNITURE_REVIEWS"
/

drop TABLE "FURNITURE_USED"
/

drop TABLE "FURNITURE"
/

drop TABLE "CUSTOMER_ROOMS"
/

drop TABLE "CUSTOMERS"
/

drop TABLE "DATABASE_LOG"
/

drop TABLE "DATABASE_CHANGES_LOG"
/

--DROP TYPES
drop TYPE "SOCIAL_MEDIA_VARRAY_TYPE"
/

drop TYPE "PHONE_VARRAY_TYPE"
/

drop TYPE "HOME_TABLE_TYPE"
/

drop TABLE "ADDRESSES"
/

drop TYPE "EMAIL_VARRAY_TYPE"
/

drop TYPE "EMAIL_TYPE"
/

drop TYPE "HOME_TYPE"
/





drop TYPE "SOCIAL_MEDIA_TYPE"
/

drop TYPE "PHONE_TYPE"
/

drop TYPE "FURNITURE_SIZE_TYPE"
/

drop TYPE "ADDRESS_TYPE"
/


drop SEQUENCE "SEQ_CUSTOMER_ID"
/

drop SEQUENCE "SEQ_CUSTOMER_ROOM_ID"
/

drop SEQUENCE "SEQ_FURNITURE_ID"
/

drop SEQUENCE "SEQ_REVIEW_ID"
/


--SETTINGS TO PRINT THE RESULTS PROPERLY
column column_name format a30
set linesize 300
set wrap on
set serverout on;

--CREATION OF TYPES
CREATE OR REPLACE TYPE ADDRESS_TYPE AS OBJECT(
street_no NUMBER(3),
street VARCHAR2(25),
CITY VARCHAR2(25),
COUNTRY VARCHAR2(25),
POSTAL_CODE VARCHAR2(25),
PROVINCE VARCHAR2(25)
);
/

CREATE TABLE ADDRESSES OF ADDRESS_TYPE;


CREATE OR REPLACE TYPE EMAIL_TYPE AS OBJECT(
email_desc VARCHAR2(25),
email VARCHAR2(25)
 );
/

CREATE TYPE EMAIL_VARRAY_TYPE AS VARRAY(10) OF EMAIL_TYPE;
/

CREATE OR REPLACE TYPE FURNITURE_SIZE_TYPE AS OBJECT(
FURNITURE_WIDTH NUMBER(5,2),
FURNITURE_HEIGHT NUMBER(5,2),
FURNITURE_DEPTH NUMBER(5,2)
);
/

CREATE OR REPLACE TYPE HOME_TYPE AS OBJECT(
HOME_DESC VARCHAR2(25),
HOME_ADDRESS ADDRESS_TYPE
);
/

CREATE TYPE HOME_TABLE_TYPE AS TABLE OF HOME_TYPE;
/


CREATE OR REPLACE TYPE PHONE_TYPE AS OBJECT(
PHONE_DESC VARCHAR2(25),
PHONE_NO VARCHAR2(25)
);
/
CREATE TYPE PHONE_VARRAY_TYPE AS VARRAY(10) OF PHONE_TYPE;
/


CREATE OR REPLACE TYPE SOCIAL_MEDIA_TYPE AS OBJECT(
SM_DESC VARCHAR2(25),
SM_HANDLE VARCHAR2(25)
);
/

CREATE TYPE SOCIAL_MEDIA_VARRAY_TYPE AS VARRAY(10) OF SOCIAL_MEDIA_TYPE;
/

--Table Creation
--To username Auto-generated
CREATE TABLE customers(
customer_id NUMBER(5),
username VARCHAR2(25) NULL,
firstname VARCHAR2(25),
lastname VARCHAR2(25),
dob DATE NOT NULL,
discount NUMBER(8,2),
emails EMAIL_VARRAY_TYPE,
homes HOME_TABLE_TYPE,
phones PHONE_VARRAY_TYPE,
social_media SOCIAL_MEDIA_VARRAY_TYPE)
NESTED TABLE homes STORE AS HOME_NESTED_TABLE;

CREATE TABLE customer_rooms(
customer_room_id NUMBER(5),
customer_id NUMBER(5) NOT NULL,
booking_id NUMBER(5) NOT NULL,
room_desc VARCHAR2(25),
room_address REF address_type
			SCOPE IS addresses);

CREATE TABLE furniture(
furniture_id NUMBER(5),
furniture_size FURNITURE_SIZE_TYPE,
furniture_weight VARCHAR2(25),
furniture_name VARCHAR2(50),
furniture_color VARCHAR2(25) DEFAULT 'BLUE',
furniture_material VARCHAR2(25),
furniture_price NUMBER(7,2),
furniture_category VARCHAR2(25),
furniture_rating_avg NUMBER(2,1) DEFAULT 0,
furniture_in_stock NUMBER(7));


CREATE TABLE furniture_used(
customer_room_id NUMBER(5),
furniture_id NUMBER(5) NOT NULL,
quantity NUMBER(3) NOT NULL,
furn_quantity_price NUMBER(9,2),
date_ordered TIMESTAMP);

CREATE TABLE furniture_reviews(
review_id NUMBER(5),
review_author NUMBER(5) NOT NULL,
furniture_id NUMBER(5) NOT NULL,
review_title VARCHAR2(25),
review_rating NUMBER(1) NOT NULL,
review_comment VARCHAR2(255),
review_date TIMESTAMP);

CREATE TABLE database_log(
user_username VARCHAR2(30),
session_id NUMBER(8),
host_comp VARCHAR2(30),
login_day DATE,
login_time VARCHAR2(10),
logout_day DATE,
logout_time VARCHAR2(10),
elapsed_minutes NUMBER(8)
);


CREATE TABLE database_changes_log(
user_username VARCHAR2(30),
session_id NUMBER(8),
host_comp VARCHAR2(30),
date_change_occured DATE,
time_change_occured VARCHAR2(10),
action_taken VARCHAR2(20),
on_table VARCHAR2(25)
);


--ALTER TABLE FURNITURE AND ADDING FURNITURE CONTAINER
ALTER TABLE FURNITURE
ADD furniture_container CHAR(1);


--ALTER TABLES & CONSTRAINT

--PRIMARY KEYS
ALTER TABLE customers
ADD CONSTRAINT pk_customers
PRIMARY KEY (customer_id);

ALTER TABLE customer_rooms
ADD CONSTRAINT pk_customer_rooms
PRIMARY KEY (customer_room_id);

ALTER TABLE furniture_used
ADD CONSTRAINT pk_furniture_used
PRIMARY KEY (customer_room_id, furniture_id, date_ordered);

ALTER TABLE furniture
ADD CONSTRAINT pk_furniture
PRIMARY KEY (furniture_id);

ALTER TABLE furniture_reviews
ADD CONSTRAINT pk_furniture_reviews
PRIMARY KEY (review_id);

--FOREIGN KEYS
ALTER TABLE customer_rooms
ADD CONSTRAINT fk_cr_customers
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

ALTER TABLE furniture_used
ADD CONSTRAINT fk_fu_customer_rooms
FOREIGN KEY (customer_room_id)
REFERENCES customer_rooms(customer_room_id);

ALTER TABLE furniture_used
ADD CONSTRAINT fk_fu_furniture
FOREIGN KEY (furniture_id)
REFERENCES furniture(furniture_id)
ON DELETE CASCADE;

ALTER TABLE furniture_reviews
ADD CONSTRAINT fk_fr_furniture
FOREIGN KEY (furniture_id)
REFERENCES furniture(furniture_id)
ON DELETE CASCADE;

ALTER TABLE furniture_reviews
ADD CONSTRAINT fk_fr_customers
FOREIGN KEY (review_author)
REFERENCES  customers(customer_id);

--CHECKIN
ALTER TABLE furniture_reviews
ADD CONSTRAINT ck_review_rating
CHECK (review_rating BETWEEN 1.0 AND 5.0);




--SEQUENCES
CREATE SEQUENCE seq_customer_id
INCREMENT BY 1
START WITH 1
NOCYCLE;

CREATE SEQUENCE seq_customer_room_id
INCREMENT BY 10
START WITH 100
NOCYCLE;

CREATE SEQUENCE seq_furniture_id
INCREMENT BY 100
START WITH 1000
NOCYCLE;

CREATE SEQUENCE seq_review_id
INCREMENT BY 1
START WITH 1
NOCYCLE;


--ALTERS FOR TYPES
ALTER TABLE HOME_NESTED_TABLE
ADD CONSTRAINT ck_home_desc
CHECK (home_desc IN ('FIRST RESIDENCE', 'SECOND RESIDENCE', 'COUNTRY HOUSE', 'OTHER'));

ALTER TABLE CUSTOMER_ROOMS
ADD CONSTRAINT ck_room_desc
CHECK (room_desc IN ('BEDROOM','LIVING ROOM','BATHROOM','ATTIC','KIDS ROOM','HALL','GARAGE','OFFICE','DRESSING ROOM','DINING ROOM','KITCHEN','CELLAR','OTHER'));


--Functions
--Counts the primary and foreign keys (prints a number)
CREATE OR REPLACE FUNCTION func_count_keys
RETURN number IS
vn_keys   NUMBER(4);
BEGIN
SELECT COUNT(*)
INTO vn_keys
FROM user_constraints
WHERE (constraint_type = 'P' OR constraint_type = 'R')
AND (table_name = 'CUSTOMERS')
OR (table_name = 'CUSTOMER_ROOMS')
OR (table_name = 'FURNITURE')
OR (table_name = 'FURNITURE_USED')
OR (table_name = 'FURNITURE_REVIEW');
RETURN vn_keys ;
END func_count_keys;
/

--Count All customers
CREATE OR REPLACE FUNCTION func_count_customers
RETURN number IS
vn_customers NUMBER(4);
BEGIN
SELECT COUNT(*)
INTO vn_customers
FROM customers;
RETURN vn_customers;
END func_count_customers;
/



--Count furniture from the specified category
CREATE OR REPLACE FUNCTION func_count_furn_by_cat
(in_furniture_type_name furniture.furniture_category%TYPE)
RETURN number IS
vn_furniture NUMBER(7);
BEGIN
SELECT COUNT(*)
INTO vn_furniture
FROM furniture WHERE furniture_category = in_furniture_type_name;
RETURN vn_furniture;
END func_count_furn_by_cat;
/



--Get average rating of a furniture item.
CREATE OR REPLACE FUNCTION func_get_item_rating
(in_furniture_id furniture.furniture_id%TYPE)
RETURN number IS
vn_rating furniture.furniture_rating_avg%TYPE;
BEGIN
SELECT AVG(review_rating) INTO vn_rating
FROM furniture_reviews WHERE furniture_id = in_furniture_id;
-- IF vn_rating IS NULL THEN
-- DBMS_OUTPUT.PUT_LINE(in_furniture_id);
-- vn_rating:=0.0;
-- END IF;
RETURN vn_rating;
END func_get_item_rating;
/



--Count How many rooms a customer has
CREATE OR REPLACE FUNCTION func_count_rooms
(in_customer_id NUMBER) RETURN number IS
vn_rooms NUMBER(4);
BEGIN

SELECT COUNT(*)
INTO vn_rooms
FROM customer_rooms WHERE customer_id = in_customer_id;
RETURN vn_rooms;
END func_count_rooms;
/


--Count the number of furniture ordered by a customer (This function returns number of furniture type ordered)
CREATE OR REPLACE FUNCTION func_count_furn_ordered
(in_customer_id NUMBER) RETURN number IS
vn_furn_ordered NUMBER(4);
BEGIN
SELECT COUNT(*)
INTO vn_furn_ordered
FROM furniture_used WHERE customer_room_id IN (SELECT customer_room_id FROM customer_rooms WHERE customer_id = in_customer_id);
RETURN vn_furn_ordered;
END func_count_furn_ordered;
/

--Count the quantity(#) of furniture ordered. (E.g. how many tables, chairs etc).
CREATE OR REPLACE FUNCTION func_count_furn_ord_quantity
(in_customer_id NUMBER) RETURN number IS
vn_furn_ord_quan NUMBER(4);
BEGIN
SELECT SUM(quantity)
INTO vn_furn_ord_quan
FROM furniture_used WHERE customer_room_id IN (SELECT customer_room_id FROM customer_rooms WHERE customer_id = in_customer_id);
RETURN vn_furn_ord_quan;
END func_count_furn_ord_quantity;
/

-- Total amount of money the customer has spent
CREATE OR REPLACE FUNCTION func_total_money_spent
(in_customer_id customers.customer_id%TYPE) RETURN NUMBER IS
vn_money_total NUMBER(8,2);

BEGIN
SELECT SUM(furn_quantity_price) INTO vn_money_total FROM furniture_used WHERE customer_room_id IN (SELECT customer_room_id FROM customer_rooms WHERE customer_id = in_customer_id);
RETURN vn_money_total;
END func_total_money_spent;
/


--Checks if the quantity of a product ordered by a customer exceeds stock quantity,
--otherwise it updates stock and prints it’s remaining value
CREATE OR REPLACE FUNCTION func_furn_order
(in_product_id NUMBER, in_quan_requested NUMBER) RETURN number IS
vn_quan_in_stock NUMBER(7);
vn_remaining NUMBER(7);
BEGIN
SELECT furniture_in_stock INTO vn_quan_in_stock FROM furniture
WHERE furniture_id = in_product_id;
vn_remaining:=vn_quan_in_stock-in_quan_requested;
IF vn_remaining >= 0 THEN
UPDATE furniture SET furniture_in_stock = vn_remaining WHERE furniture_id = in_product_id;
ELSE NULL;
END IF;
DBMS_OUTPUT.PUT_LINE('PRODUCT ID ' || in_product_id || ' REMAINING IN STOCK: ' || vn_remaining);
RETURN vn_remaining;
END func_furn_order;
/


--Procedures
--Generate discount
CREATE OR REPLACE PROCEDURE proc_calc_discount (in_customer_id customers.customer_id%TYPE) IS

vc_discount NUMBER(4);
vc_amount_spent NUMBER(8,2);
BEGIN
vc_amount_spent:=func_total_money_spent(in_customer_id);
IF vc_amount_spent > 2000 AND vc_amount_spent < 5001 THEN
vc_discount:= 20;
ELSIF vc_amount_spent > 5001 AND vc_amount_spent < 10001 THEN
vc_discount:= 50;
ELSIF vc_amount_spent > 10001 THEN
vc_discount:= 70;
ELSE
vc_discount:= 0;
END IF;
UPDATE customers SET discount = 20 WHERE customer_id = in_customer_id;
DBMS_OUTPUT.PUT_LINE('Customer discount: ' || vc_discount || '%');
END proc_calc_discount;
/

--This procedure shows the sum of types and quantity of furniture ordered.
CREATE OR REPLACE PROCEDURE proc_count_furn_bycustomer (in_customer_id customers.customer_id%TYPE) IS

vc_count_types NUMBER(4);
vc_count_quantity NUMBER(4);
BEGIN
vc_count_types:=func_count_furn_ordered(in_customer_id);
vc_count_quantity:=func_count_furn_ord_quantity(in_customer_id);
DBMS_OUTPUT.PUT_LINE('Customer ordered ' || vc_count_types || ' furniture types');
DBMS_OUTPUT.PUT_LINE('Customer ordered ' || vc_count_quantity || ' furniture in total');
END proc_count_furn_bycustomer;
/



--Updates the rating of a furniture id after a review has been inserted
CREATE OR REPLACE PROCEDURE proc_update_rating(in_furniture_id furniture.furniture_id%TYPE, in_after_rating furniture_reviews.review_rating%TYPE) IS
vc_ex_rating furniture_reviews.review_rating%TYPE;
vc_after_rating furniture_reviews.review_rating%TYPE;
BEGIN
vc_ex_rating:=func_get_item_rating(in_furniture_id);

IF vc_ex_rating IS NULL THEN
vc_after_rating:=in_after_rating;
ELSE vc_after_rating:=vc_ex_rating;
END IF;
UPDATE furniture
SET
furniture_rating_avg = vc_after_rating
WHERE furniture_id = in_furniture_id;
END proc_update_rating;
/


--Giving item ID and deleting the specified item
CREATE OR REPLACE PROCEDURE proc_delete_furn_item(in_furniture_id furniture.furniture_id%TYPE) IS
vc_ck_existing NUMBER(4);
BEGIN
SELECT COUNT(*) INTO vc_ck_existing FROM furniture WHERE furniture_id = in_furniture_id;
IF vc_ck_existing > 0 THEN
DELETE FROM furniture
WHERE furniture_id=in_furniture_id;
ELSE
DBMS_OUTPUT.PUT_LINE('The specified item was not found.');
END IF;
END proc_delete_furn_item;
/


--Cursors


--Displays all furniture items with the same/or above the specified avg rating
CREATE OR REPLACE PROCEDURE proc_cur_avg (in_avg furniture.furniture_rating_avg%TYPE) IS
	CURSOR cur_ck_avg IS
	SELECT furniture_id, furniture_name, furniture_rating_avg
	FROM furniture
	WHERE furniture_rating_avg >= in_avg;

	vn_results NUMBER(3) := 0;
BEGIN

	FOR rec_cur_ck_avg IN cur_ck_avg LOOP
		DBMS_OUTPUT.PUT_LINE(cur_ck_avg%ROWCOUNT || ' ' || rec_cur_ck_avg.furniture_id || ' ' || rec_cur_ck_avg.furniture_name || ' ' || rec_cur_ck_avg.furniture_rating_avg);
		vn_results := cur_ck_avg%ROWCOUNT;
	END LOOP;

	DBMS_OUTPUT.PUT_LINE	('There are '||vn_results||' furniture items above rating '||in_avg);


END proc_cur_avg;
/
show errors;




--Displays furniture item above the specified price in DESC order by price
CREATE OR REPLACE PROCEDURE proc_cur_furn_price (in_price furniture.furniture_price%TYPE) IS
	CURSOR cur_ck_furn_price IS
	SELECT furniture_id, furniture_name, furniture_price
	FROM furniture
	WHERE furniture_price> in_price ORDER BY furniture_price DESC;
	rec_cur_ck_furn_price cur_ck_furn_price%ROWTYPE;
BEGIN
	OPEN cur_ck_furn_price;
	FETCH cur_ck_furn_price INTO rec_cur_ck_furn_price;
	IF cur_ck_furn_price%NOTFOUND
	THEN DBMS_OUTPUT.PUT_LINE('No such furniture item above '||in_price||' GBP');
	ELSE
	DBMS_OUTPUT.PUT_LINE	('The products with price above '||in_price||' GBP, are :');
	WHILE cur_ck_furn_price%FOUND LOOP
			DBMS_OUTPUT.PUT_LINE(rec_cur_ck_furn_price.furniture_id || ' ' ||rec_cur_ck_furn_price.furniture_name || ' ' || rec_cur_ck_furn_price.furniture_price);
		FETCH cur_ck_furn_price INTO rec_cur_ck_furn_price;
	END LOOP;
	END IF;
	CLOSE cur_ck_furn_price;
END proc_cur_furn_price;
/
SHOW ERRORS;




--Displays the count(*) and the names of all PKs and FKs in the database
CREATE OR REPLACE PROCEDURE proc_cur_constraints IS
	CURSOR cur_ck_constraints IS
	SELECT constraint_name, table_name, status FROM user_constraints
	WHERE (constraint_type = 'P' OR constraint_type = 'R' OR constraint_type = 'C')
	AND (constraint_name LIKE 'PK%' OR constraint_name LIKE 'FK%' OR constraint_name LIKE 'CK%');

	vn_row_count NUMBER(3) := 0;
BEGIN

	FOR rec_cur_ck_const IN cur_ck_constraints LOOP
		DBMS_OUTPUT.PUT_LINE(cur_ck_constraints%ROWCOUNT || ' ' || rec_cur_ck_const.constraint_name || ' ' || rec_cur_ck_const.table_name || ' ' || rec_cur_ck_const.status);
		vn_row_count := cur_ck_constraints%ROWCOUNT;
	END LOOP;

	DBMS_OUTPUT.PUT_LINE	('There are '||vn_row_count||' Primary Keys, Foreign Keys or Constraints in the database');


END proc_cur_constraints;
/
show errors;




--LIST ALL PROCEDURES, FUNCTIONS AND TRIGGERS OWNEN BY USER 'CSY2038_99' AND THEIR COUNTS(*)
CREATE OR REPLACE PROCEDURE proc_cur_objects IS
	CURSOR cur_ck_triggers IS
	SELECT * FROM all_triggers
	WHERE table_name = 'CUSTOMERS'
	OR (table_name = 'CUSTOMER_ROOMS')
	OR (table_name = 'FURNITURE')
	OR (table_name = 'FURNITURE_USED')
	OR (table_name = 'FURNITURE_REVIEWS');

	CURSOR cur_ck_obj IS
	SELECT * FROM ALL_OBJECTS WHERE OBJECT_TYPE IN ('FUNCTION','PROCEDURE')
	AND (SUBSTR(OBJECT_NAME,1,4) = 'PROC' OR SUBSTR(OBJECT_NAME,1,4) = 'FUNC');

	vn_trigger_count NUMBER(3) := 0;
	vn_procFunc_count NUMBER(3) := 0;
BEGIN

	FOR rec_cur_ck_trig IN cur_ck_triggers LOOP
		DBMS_OUTPUT.PUT_LINE(cur_ck_triggers%ROWCOUNT || ' ' || rec_cur_ck_trig.trigger_name || ' ' || rec_cur_ck_trig.trigger_type);
		vn_trigger_count := cur_ck_triggers%ROWCOUNT;
	END LOOP;

	DBMS_OUTPUT.PUT_LINE	('---------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE	('There are '||vn_trigger_count||' triggers in the database');
	DBMS_OUTPUT.PUT_LINE	('---------------------------------------------------------------------');

	FOR rec_cur_ck_obj IN cur_ck_obj LOOP
		DBMS_OUTPUT.PUT_LINE(cur_ck_obj%ROWCOUNT || ' ' || rec_cur_ck_obj.OBJECT_NAME || ' ' || rec_cur_ck_obj.OBJECT_TYPE || ' ' || rec_cur_ck_obj.STATUS);
		vn_procFunc_count := cur_ck_obj%ROWCOUNT;
	END LOOP;

	DBMS_OUTPUT.PUT_LINE	('---------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE	('There are '||vn_procFunc_count||' procedures and functions in the database');
	DBMS_OUTPUT.PUT_LINE	('---------------------------------------------------------------------');

END proc_cur_objects;
/
show errors;



--Triggers
--Trigger to generate username from the 2 first characters of the firstname, lastname and the id.
--If any rows on the table do not have a generated username, this trigger ensures that all will get one.
CREATE OR REPLACE TRIGGER trig_gen_username
BEFORE INSERT ON CUSTOMERS
BEGIN
  UPDATE CUSTOMERS SET
    username = (SUBSTR(firstname,1,2) || SUBSTR(lastname,1,2) || TO_CHAR(customer_id))
  WHERE customer_id = customer_id;
END;
/

--Putting a price to the quantity multipled by price of an individual set of same products
CREATE OR REPLACE TRIGGER trig_furn_price_quantity
BEFORE INSERT ON furniture_used
FOR EACH ROW
DECLARE
furn_price NUMBER(7,2);
BEGIN
SELECT furniture_price INTO furn_price FROM furniture WHERE furniture_id = :new.furniture_id;
    :new.furn_quantity_price:=(furn_price * :new.quantity);
END trig_furn_price_quantity;
/




--Checks what the remaining quantity of a furniture item is.
CREATE or REPLACE TRIGGER trig_furn_quantity_check
BEFORE INSERT OR UPDATE OF quantity  ON furniture_used
FOR EACH ROW
DECLARE
f_in_stock NUMBER(7);
f_remaining NUMBER(7);
BEGIN
SELECT furniture_in_stock INTO f_in_stock FROM furniture WHERE furniture_id = :new.furniture_id;
IF f_in_stock = 0 THEN
RAISE_APPLICATION_ERROR(-20000, 'CANNOT ORDER PRODUCT THAT IS OUT OF STOCK');
ELSIF f_in_stock > 0 THEN
IF :new.quantity > f_in_stock THEN
RAISE_APPLICATION_ERROR(-20001, 'CANNOT ORDER MORE OF WHAT IS IN STOCK');
ELSE
f_remaining:=func_furn_order(:new.furniture_id,:new.quantity);
END IF;
ELSE NULL;
END IF;
END trig_furn_quantity_check;
/




--Logs for the login info
CREATE OR REPLACE TRIGGER trig_login_log
AFTER LOGON ON DATABASE
BEGIN
INSERT INTO database_log VALUES(
  user,
  sys_context('USERENV','SESSIONID'),
  sys_context('USERENV','HOST'),
  SYSDATE,
  to_char(sysdate, 'hh24:mi:ss'),
  NULL,
  NULL,
  NULL
);
END;
/




--Logs for the logout info
CREATE OR REPLACE TRIGGER trig_logout_log
BEFORE LOGOFF ON DATABASE
BEGIN
UPDATE
  database_log
SET
  logout_day = SYSDATE,
  logout_time = to_char(SYSDATE, 'hh24:mi:ss'),
  elapsed_minutes = round((logout_day - login_day)*1440)
WHERE
  sys_context('USERENV','SESSIONID') = session_id;
END;
/




--Converts all lastnames to uppercase
CREATE OR REPLACE TRIGGER trig_convert_upper
BEFORE INSERT OR UPDATE OF lastname ON customers FOR EACH ROW
BEGIN
UPDATE customers SET lastname = UPPER(lastname) WHERE customer_id = :new.customer_id;
END trig_convert_upper;
/





--The register date can't be younger than 17 years old and must be before dates.
CREATE OR REPLACE TRIGGER trig_date_check
BEFORE INSERT OR UPDATE OF dob ON customers FOR EACH ROW
DECLARE
vn_today customers.dob%TYPE;
BEGIN
     SELECT SYSDATE
     INTO vn_today
     FROM DUAL;
    IF :NEW.dob > vn_today THEN
    RAISE_APPLICATION_ERROR(-20002, 'CUSTOMER DATE OF BIRTH MUST BE BEFORE CURRENT DATE');
    ELSIF (:NEW.dob > ADD_MONTHS(vn_today, -(12 * 17))) THEN
    RAISE_APPLICATION_ERROR(-20003, 'CUSTOMER DATE OF BIRTH MUST BE OLDER THAN 17 YEARS OLD');
    ELSE NULL;
    END IF;
END trig_date_check;
/




--Before insert trigger that generates the rating of a furniture id
CREATE OR REPLACE TRIGGER trig_rating_gen
BEFORE INSERT OR UPDATE OF review_rating ON furniture_reviews FOR EACH ROW
BEGIN
proc_update_rating(:new.furniture_id, :new.review_rating);
END trig_rating_gen;
/


--Logs the customer details
CREATE OR REPLACE TRIGGER trig_customer_logging
AFTER INSERT OR UPDATE OR DELETE ON customers
BEGIN

     IF INSERTING THEN
           INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
           VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'INSERTING','CUSTOMERS');

     ELSIF UPDATING THEN
          INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
          VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'UPDATING','CUSTOMERS');

     ELSIF DELETING THEN
          INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
          VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'DELETING','CUSTOMERS');

     END IF;

END trig_customer_logging;
/

--Logs the furniture items
CREATE OR REPLACE TRIGGER trig_furniture_logging
AFTER INSERT OR UPDATE OR DELETE ON furniture
BEGIN

     IF INSERTING THEN
           INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
           VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'INSERTING','FURNITURE');

     ELSIF UPDATING THEN
          INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
          VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'UPDATING','FURNITURE');

     ELSIF DELETING THEN
          INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
          VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'DELETING','FURNITURE');

     END IF;

END trig_furniture_logging;
/

--Logs the furniture_used items
CREATE OR REPLACE TRIGGER trig_furniture_used_logging
AFTER INSERT OR UPDATE OR DELETE ON furniture_used
BEGIN

     IF INSERTING THEN
           INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
           VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'INSERTING','FURNITURE_USED');

     ELSIF UPDATING THEN
          INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
          VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'UPDATING','FURNITURE_USED');

     ELSIF DELETING THEN
          INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
          VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'DELETING','FURNITURE_USED');

     END IF;

END trig_furniture_used_logging;
/




--Logs the furniture reviews
CREATE OR REPLACE TRIGGER trig_furniture_reviews_logging
AFTER INSERT OR UPDATE OR DELETE ON furniture_reviews
BEGIN

     IF INSERTING THEN
           INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
           VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'INSERTING','FURNITURE_REVIEWS');

     ELSIF UPDATING THEN
          INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
          VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'UPDATING','FURNITURE_REVIEWS');

     ELSIF DELETING THEN
          INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
          VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'DELETING','FURNITURE_REVIEWS');

     END IF;

END trig_furniture_reviews_logging;
/





--Logs customer rooms
CREATE OR REPLACE TRIGGER trig_customer_rooms_logging
AFTER INSERT OR UPDATE OR DELETE ON customer_rooms
BEGIN

     IF INSERTING THEN
           INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
           VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'INSERTING','CUSTOMER_ROOMS');

     ELSIF UPDATING THEN
          INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
          VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'UPDATING','CUSTOMER_ROOMS');

     ELSIF DELETING THEN
          INSERT INTO database_changes_log (user_username,session_id,host_comp,date_change_occured,time_change_occured,action_taken,on_table)
          VALUES (USER,sys_context('USERENV','SESSIONID'),sys_context('USERENV','HOST'), SYSDATE,to_char(sysdate, 'hh24:mi:ss'), 'DELETING','CUSTOMER_ROOMS');

     END IF;

END trig_customer_rooms_logging;
/




--INSERTS




--ADDRESSES INSERTS
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(131, 'TSIMISKI', 'THESSALONIKI', 'GREECE', '54621', 'MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(54, 'VAS. OLGAS', 'THESSALONIKI', 'GREECE', '54640', 'MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(200, 'PANEPISTIMIOU', 'ATHENS', 'GREECE', '15342', 'STEREA ELLADA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(82, 'KOLOKOTRONI', 'ATHENS', 'GREECE', '13456', 'STEREA ELLADA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(23, 'ELYTI', 'PATRA', 'GREECE', '56732', 'PELOPONISSOS');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(10, 'KAVAFI', 'ZAKYNTHOS', 'GREECE', '44532', 'EPTANISA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(66, 'KANARI', 'CHIOS', 'GREECE', '16783', 'NORTH AEGEAN');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(44, 'BOTSARI', 'KATERINI', 'GREECE', '66432', 'PIERIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(91, 'VENIZELOU', 'KALAMATA', 'GREECE', '13326', 'PELOPONISSOS');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(30, 'PAPANDREOU', 'ALEXANDROUPOLI', 'GREECE', '44562', 'WESTERN MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(29, 'KARAMANLI', 'XANTHI', 'GREECE', '12378', 'WESTERN MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(28, 'EGNATIA', 'FLORINA', 'GREECE', '65432', 'EASTERN MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(65, 'P. SYNDIKA', 'ARTA', 'GREECE', '43242', 'IPIROS');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(55, 'STADIOU', 'ARGOS', 'GREECE', '64556', 'IPIROS');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(34, 'ANAXIMANDROU', 'KOZANI', 'GREECE', '87576', 'WESTERN MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(43, 'VOULGARI', 'PTOLEMAIDA', 'GREECE', '95542', 'WESTERN MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(66, 'MONASTIRIOU', 'VEROIA', 'GREECE', '54367', 'WESTERN MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(11, 'KASSANDROU', 'PATRA', 'GREECE', '12315', 'WESTERN MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(32, 'OLYMPIADOS', 'ALEXANDROUPOLI', 'GREECE', '56334', 'NORTH AEGEAN');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(25, 'DELFON', 'ALEXANDROUPOLI', 'GREECE', '97897', 'WESTERN MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(54, 'IONOS DRAGOUMI', 'KATERINI', 'GREECE', '66432', 'PIERIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(10, 'SINOPIS', 'KATERINI', 'GREECE', '66432', 'PIERIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(22, 'AGRIANON', 'THESSALONIKI', 'GREECE', '25234', 'MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(66, 'KANARI', 'VOLOS', 'GREECE', '32155', 'PIERIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(81, 'RODOU', 'RODOS', 'GREECE', '43215', 'EPTANISA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(99, 'METRON', 'THESSALONIKI', 'GREECE', '12345', 'MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(12, 'SIGALA', 'ALEXANDROUPOLI', 'GREECE', '12356', 'MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(81, 'NIKOMIDEIAS', 'FLORINA', 'GREECE', '12456', 'MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(64, 'ARAVISSOU', 'KATERINI', 'GREECE', '32567', 'PIERIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(12, 'PAPAFI', 'XANTHI', 'GREECE', '77845', 'MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(44, 'KYZIKOU', 'THESSALONIKI', 'GREECE', '54563', 'MACEDONIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(5, 'MALAKOPIS', 'PYRGOS', 'GREECE', '32456', 'ILEIA');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(77, 'AMFIPOLEOS', 'TILOS', 'GREECE', '32461', 'AEGEAN');
INSERT INTO ADDRESSES(street_no, street, city, country, postal_code, province) VALUES(26, 'EPTALOFOU', 'DILOS', 'GREECE', '75413', 'AEGEAN');

--CUSTOMERS INSERTS
INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'MITSOS', 'GRIG', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'DIMITRIS@GMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('FIRST RESIDENCE', ADDRESS_TYPE(131, 'TSIMISKI', 'THESSALONIKI', 'GREECE', '54621', 'MACEDONIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 251888')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'JIMAKOS')),
DATE '1989-5-25');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'TONY', 'TRIA', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'ANTONIS@GMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('SECOND RESIDENCE', ADDRESS_TYPE(54, 'VAS. OLGAS', 'THESSALONIKI', 'GREECE', '54640', 'MACEDONIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 444658')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'ANTONISTRIA')),
DATE '1988-11-12');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'KOSMAS', 'AIGUPTIOS', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('SECONDARY', 'CHINGASPINGAS1@GMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('COUNTRY HOUSE', ADDRESS_TYPE(200, 'PANEPISTIMIOU', 'ATHENS', 'GREECE', '15342', 'STEREA ELLADA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('WORK PHONE', '2310 251888'),
PHONE_TYPE('HOME PHONE', '2310 314314')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('INSTAGRAM', 'NIKOS1'),
SOCIAL_MEDIA_TYPE('FACEBOOK', 'NIKOLAKIS')),
DATE '1992-11-6');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'KONSTANTINOS', 'KEX', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('OTHER', 'JOHNDOE@GMAIL.COM'),
EMAIL_TYPE('SECONDARY', 'KOSTASKEX@HOTMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('FIRST RESIDENCE', ADDRESS_TYPE(82, 'KOLOKOTRONI', 'ATHENS', 'GREECE', '13456', 'STEREA ELLADA')),
HOME_TYPE('COUNTRY HOUSE', ADDRESS_TYPE(23, 'ELYTI', 'PATRA', 'GREECE', '56732', 'PELOPONISSOS'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 251888'),
PHONE_TYPE('WORK PHONE', '6949999991')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'KOSTASK'),
SOCIAL_MEDIA_TYPE('TWITTER', '@KEXX')),
DATE '1979-12-5');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'KITS', 'FROZEN', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'JOHNDOE1@GMAIL.COM'),
EMAIL_TYPE('OTHER', 'FKITS@HOTMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('SECOND RESIDENCE', ADDRESS_TYPE(83, 'KARAISKAKI', 'THESSALONIKI', 'GREECE', '13456', 'STEREA ELLADA')),
HOME_TYPE('FIRST RESIDENCE', ADDRESS_TYPE(12, 'KAZANTZAKI', 'LARISSA', 'GREECE', '56732', 'THESSALONIKI'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 338254'),
PHONE_TYPE('WORK PHONE', '6972720053')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'FOTIS'),
SOCIAL_MEDIA_TYPE('TWITTER', '@FROZENGR'),
SOCIAL_MEDIA_TYPE('INSTAGRAM', 'FROZENGR')),
DATE '1995-7-26');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'CHRIS', 'DUNN', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'CDUNN@HOTMAIL.COM'),
EMAIL_TYPE('OTHER', 'CDUN@GMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('SECOND RESIDENCE', ADDRESS_TYPE(12, 'AG. TRIADOS', 'THESSALONIKI', 'GREECE', '54342', 'MACEDONIA')),
HOME_TYPE('FIRST RESIDENCE', ADDRESS_TYPE(23, 'AETORAHIS', 'VOLOS', 'GREECE', '56732', 'THESSALIA')),
HOME_TYPE('COUNTRY HOUSE', ADDRESS_TYPE(33, 'VYZANTIOU', 'KASSANDRA', 'GREECE', '66524', 'MACEDONIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 456462'),
PHONE_TYPE('WORK PHONE', '6972748611')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'CHRIS'),
SOCIAL_MEDIA_TYPE('TWITTER', '@CHRISD'),
SOCIAL_MEDIA_TYPE('INSTAGRAM', '@CHRISDUNN')),
DATE '1990-3-22');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'MARAKI', 'MARIO', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'MARAKI@YAHOO.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('OTHER', ADDRESS_TYPE(41, 'KATSIMIDI', 'THESSALONIKI', 'GREECE', '65723', 'MACEDONIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 996521')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'MARIA')),
DATE '1987-5-4');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'JOHN', 'JOHNNY', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'JOHNNY@HOTMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('FIRST RESIDENCE', ADDRESS_TYPE(52, 'MILTIADOU', 'KOZANI', 'GREECE', '87643', 'MACEDONIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 444658'),
PHONE_TYPE('WORK PHONE', '2310 874631')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'GIANNISJ')),
DATE '1982-5-26');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'SPIRAKOS', 'SPIRIDON', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('SECONDARY', 'SPIROSK@GMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('COUNTRY HOUSE', ADDRESS_TYPE(63, 'KONTOGOURI', 'CHIOS', 'GREECE', '12311', 'NORTH AEGEAN')),
	HOME_TYPE ('FIRST RESIDENCE', ADDRESS_TYPE(74, 'EVZONON', 'CHALKIDIKI', 'GREECE', '65466', 'MACEDONIA')),
	HOME_TYPE ('SECOND RESIDENCE', ADDRESS_TYPE(85, 'LYTRA', 'LARISSA', 'GREECE', '87644', 'THESSALIA')),
	HOME_TYPE ('OTHER', ADDRESS_TYPE(96, 'LAMPRAKI', 'ATHENS', 'GREECE', '35454', 'STEREA ELLADA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('OTHER', '2310 251888'),
PHONE_TYPE('WORK PHONE', '2310 314314')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('INSTAGRAM', '@SPYROS'),
SOCIAL_MEDIA_TYPE('FACEBOOK', 'SPYRAKOS')),
DATE '1977-6-15');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'BILLYS', 'BILLAKOS', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'BILL@GMAIL.COM'),
EMAIL_TYPE('SECONDARY', 'BILLAKOS@HOTMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('COUNTRY HOUSE', ADDRESS_TYPE(19, 'EDESSIS', 'ATHENS', 'GREECE', '13245', 'STEREA ELLADA')),
HOME_TYPE('SECOND RESIDENCE', ADDRESS_TYPE(28, 'ORFANIDOU', 'PATRA', 'GREECE', '77986', 'PELOPONISSOS')),
HOME_TYPE('FIRST RESIDENCE', ADDRESS_TYPE(37, 'LEONTOS SOFOU', 'FLORINA', 'GREECE', '78321', 'MACEDONIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 333215'),
PHONE_TYPE('WORK PHONE', '6978654312')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'BILLAKOS'),
SOCIAL_MEDIA_TYPE('TWITTER', '@BILLYS'),
SOCIAL_MEDIA_TYPE('INSTAGRAM', '@BILLYS')),
DATE '1966-10-12');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'PANOS', 'PANAIS', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'PANOS@HOTMAIL.COM'),
EMAIL_TYPE('SECONDARY', 'PANAGIOTIS@GMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('SECOND RESIDENCE', ADDRESS_TYPE(46, 'KATHOLIKON', 'THESSALONIKI', 'GREECE', '54642', 'MACEDONIA')),
HOME_TYPE('FIRST RESIDENCE', ADDRESS_TYPE(54, 'PALAMA', 'LARISSA', 'GREECE', '32657', 'THESSALIA')),
HOME_TYPE('OTHER', ADDRESS_TYPE(43, 'SYGGROU', 'THESSALONIKI', 'GREECE', '54638', 'MACEDONIA')),
HOME_TYPE('COUNTRY HOUSE', ADDRESS_TYPE(32, 'KASSANDROU', 'ATHENS', 'GREECE', '13256', 'STEREA ELLADA')),
HOME_TYPE('COUNTRY HOUSE', ADDRESS_TYPE(21, 'BALTADOROU', 'FLOGITA', 'GREECE', '47563', 'MACEDONIA')),
HOME_TYPE('OTHER', ADDRESS_TYPE(10, 'AG. DIMITRIOU', 'ALEXANDROUPOLI', 'GREECE', '12452', 'MACEDONIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('WORK PHONE', '2310 556321'),
PHONE_TYPE('OTHER', '6976598321')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'PANOS'),
SOCIAL_MEDIA_TYPE('TWITTER', '@PANAGIOTIS'),
SOCIAL_MEDIA_TYPE('INSTAGRAM', '@PANAGIOTIS')),
DATE '1986-9-6');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'KITS', 'FROZEN', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'JOHNDOE1@GMAIL.COM'),
EMAIL_TYPE('OTHER', 'FKITS@HOTMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('SECOND RESIDENCE', ADDRESS_TYPE(83, 'KARAISKAKI', 'THESSALONIKI', 'GREECE', '13456', 'STEREA ELLADA')),
HOME_TYPE('FIRST RESIDENCE', ADDRESS_TYPE(12, 'KAZANTZAKI', 'LARISSA', 'GREECE', '56732', 'THESSALIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 338254'),
PHONE_TYPE('WORK PHONE', '6972720053')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'FOTIS'),
SOCIAL_MEDIA_TYPE('TWITTER', '@FROZENGR'),
SOCIAL_MEDIA_TYPE('INSTAGRAM', 'FROZENGR')),
DATE '1985-1-28');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'GIWTOULA', 'PAP', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'GIWTA@GMAIL.COM'),
EMAIL_TYPE('OTHER', 'GIWTA4@HOTMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('FIRST RESIDENCE', ADDRESS_TYPE(17, 'VENIZELOU', 'THESSALONIKI', 'GREECE', '54632', 'MACEDONIA')),
HOME_TYPE('COUNTRY HOUSE', ADDRESS_TYPE(26, 'PLATONOS', 'LESVOS', 'GREECE', '12348', 'AEGEAN'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 436533'),
PHONE_TYPE('WORK PHONE', '6982156483')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'GIWTA'),
SOCIAL_MEDIA_TYPE('TWITTER', '@GIWTAGR'),
SOCIAL_MEDIA_TYPE('INSTAGRAM', '@GIWTA')),
DATE '1990-4-3');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'AIMILIANOS', 'AIMILIO', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'AIMILIOS@HOTMAIL.COM'),
EMAIL_TYPE('OTHER', 'AIM@GMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('SECOND RESIDENCE', ADDRESS_TYPE(35, 'IFESTIONOS', 'THESSALONIKI', 'GREECE', '53421', 'MACEDONIA')),
HOME_TYPE('FIRST RESIDENCE', ADDRESS_TYPE(48, 'TANTALOU', 'VOLOS', 'GREECE', '13254', 'THESSALIA')),
HOME_TYPE('COUNTRY HOUSE', ADDRESS_TYPE(29, 'KAPETAN GKONI', 'SARTI', 'GREECE', '66524', 'MACEDONIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('OTHER', '2310 32145'),
PHONE_TYPE('WORK PHONE', '6987413258')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'AIMILIOS'),
SOCIAL_MEDIA_TYPE('TWITTER', '@AIMILIOR'),
SOCIAL_MEDIA_TYPE('INSTAGRAM', '@AIMR')),
DATE '1993-3-20');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'GEORGE', 'GEORGINIO', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'GEORGE@YAHOO.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('OTHER', ADDRESS_TYPE(5, 'TAKI OIKONOMIDI', 'THESSALONIKI', 'GREECE', '45637', 'MACEDONIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 543186')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'GEORGE')),
DATE '1989-4-11');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'XAROULIS', 'SIDI', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'XARIS4@HOTMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('SECOND RESIDENCE', ADDRESS_TYPE(100, 'TRAPEZOUNTOS', 'KOZANI', 'GREECE', '45641', 'MACEDONIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 321455'),
PHONE_TYPE('WORK PHONE', '2310 436374')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'XARIS')),
DATE '1995-8-1');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'ANDI', 'ANTONAKIS', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'ANDI@GMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('COUNTRY HOUSE', ADDRESS_TYPE(123, 'PONTOU', 'THESSALONIKI', 'GREECE', '32152', 'MACEDONIA')),
	HOME_TYPE ('FIRST RESIDENCE', ADDRESS_TYPE(164, 'NIKOPOLEOS', 'OURANOUPOLI', 'GREECE', '32145', 'MACEDONIA')),
	HOME_TYPE ('SECOND RESIDENCE', ADDRESS_TYPE(66, 'METAMORFOSEOS', 'LARISSA', 'GREECE', '31553', 'THESSALIA')),
	HOME_TYPE ('OTHER', ADDRESS_TYPE(11, 'TRIPOLEOS', 'ATHENS', 'GREECE', '23152', 'STEREA ELLADA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('OTHER', '2310 321314'),
PHONE_TYPE('WORK PHONE', '2310 436332')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('INSTAGRAM', '@ANTONIS'),
SOCIAL_MEDIA_TYPE('FACEBOOK', 'ANTONAKIS')),
DATE '1992-2-5');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'SERGEI', 'KON', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'SERGKON@GMAIL.COM'),
EMAIL_TYPE('SECONDARY', 'DOCTORWHO@HOTMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('FIRST RESIDENCE', ADDRESS_TYPE(78, 'CHILIS', 'ATHENS', 'GREECE', '12315', 'STEREA ELLADA')),
HOME_TYPE('SECOND RESIDENCE', ADDRESS_TYPE(99, 'SOURMENON', 'PATRA', 'GREECE', '166632', 'PELOPONISSOS')),
HOME_TYPE('COUNTRY HOUSE', ADDRESS_TYPE(11, 'SOUMELA', 'FLORINA', 'GREECE', '32456', 'MACEDONIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('OTHER', '2310 333215'),
PHONE_TYPE('WORK PHONE', '6946135831')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'SERGIOS'),
SOCIAL_MEDIA_TYPE('TWITTER', '@SERG'),
SOCIAL_MEDIA_TYPE('INSTAGRAM', '@DOC')),
DATE '1991-3-12');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'ANEST', 'ANESTAKIS', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'ANEST@HOTMAIL.COM'),
EMAIL_TYPE('SECONDARY', 'ANESTIS42@GMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('SECOND RESIDENCE', ADDRESS_TYPE(33, 'KOTIORON', 'THESSALONIKI', 'GREECE', '54642', 'MACEDONIA')),
HOME_TYPE('FIRST RESIDENCE', ADDRESS_TYPE(11, 'IMERAS', 'NEA PLAGIA', 'GREECE', '21312', 'MACEDONIA')),
HOME_TYPE('OTHER', ADDRESS_TYPE(29, 'PARANIKA', 'KATERINI', 'GREECE', '12356', 'PIERIA')),
HOME_TYPE('COUNTRY HOUSE', ADDRESS_TYPE(110, 'PASSALIDI', 'ATHENS', 'GREECE', '73232', 'STEREA ELLADA')),
HOME_TYPE('COUNTRY HOUSE', ADDRESS_TYPE(56, 'KAROLIDOU', 'IERISSOS', 'GREECE', '13215', 'MACEDONIA')),
HOME_TYPE('OTHER', ADDRESS_TYPE(44, 'AIGAIOU', 'ALEXANDROUPOLI', 'GREECE', '43266', 'MACEDONIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('WORK PHONE', '2310 321567'),
PHONE_TYPE('OTHER', '6986554318')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'ANESTIS'),
SOCIAL_MEDIA_TYPE('TWITTER', '@ANESTAKIS4'),
SOCIAL_MEDIA_TYPE('INSTAGRAM', '@ANEST45')),
DATE '1989-6-27');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'ANTHOULA', 'ANTH', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'ANTHI@GMAIL.COM'),
EMAIL_TYPE('OTHER', 'ANTHOULA@HOTMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('SECOND RESIDENCE', ADDRESS_TYPE(44, 'ARISTOFANOUS', 'THESSALONIKI', 'GREECE', '43256', 'MACEDONIA')),
HOME_TYPE('FIRST RESIDENCE', ADDRESS_TYPE(34, 'EPANOMIS', 'LARISSA', 'GREECE', '43256', 'THESSALIA'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 321564'),
PHONE_TYPE('WORK PHONE', '6946785134')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'ANTHI'),
SOCIAL_MEDIA_TYPE('TWITTER', '@ANTHOULA'),
SOCIAL_MEDIA_TYPE('INSTAGRAM', 'ANTHOULA')),
DATE '1988-5-26');

INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'CHRISTINOULA', 'CHRISTINE', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'CHRISTINA@GMAIL.COM'),
EMAIL_TYPE('OTHER', 'CHRISTINE@HOTMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('FIRST RESIDENCE', ADDRESS_TYPE(78, 'IRODOTOU', 'THESSALONIKI', 'GREECE', '54632', 'MACEDONIA')),
HOME_TYPE('COUNTRY HOUSE', ADDRESS_TYPE(99, 'PALELOGOU', 'LIMNOS', 'GREECE', '32167', 'AEGEAN'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 123156'),
PHONE_TYPE('WORK PHONE', '6976131345')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'CHRISTINA'),
SOCIAL_MEDIA_TYPE('TWITTER', '@CHRISTINOULA'),
SOCIAL_MEDIA_TYPE('INSTAGRAM', '@CHRISTINE')),
DATE '1990-1-10');


INSERT INTO customers(customer_id, firstname, lastname, emails, homes, phones, social_media, dob)
VALUES (seq_customer_id.nextval, 'STELIOS', 'LAZAROU', EMAIL_VARRAY_TYPE(
EMAIL_TYPE('PRIMARY', 'STELLAZAROU@GMAIL.COM'),
EMAIL_TYPE('OTHER', 'STELLAZAROU@HOTMAIL.COM')),
HOME_TABLE_TYPE (
	HOME_TYPE ('FIRST RESIDENCE', ADDRESS_TYPE(78, 'M. ALEXANDROY', 'THESSALONIKI', 'GREECE', '52345', 'MACEDONIA')),
HOME_TYPE('COUNTRY HOUSE', ADDRESS_TYPE(99, 'EPANOMIS', 'LIMNOS', 'GREECE', '32167', 'AEGEAN'))),
PHONE_VARRAY_TYPE(
PHONE_TYPE('HOME PHONE', '2310 123156'),
PHONE_TYPE('WORK PHONE', '6976131345')),
SOCIAL_MEDIA_VARRAY_TYPE(
SOCIAL_MEDIA_TYPE('FACEBOOK', 'LAZAROU'),
SOCIAL_MEDIA_TYPE('TWITTER', '@LAZAROU'),
SOCIAL_MEDIA_TYPE('INSTAGRAM', '@LAZAROU')),
DATE '2000-12-17');


--CUSTOMER ROOMS
INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 2, 2, 'KITCHEN', REF(A) FROM ADDRESSES A WHERE STREET_NO = 66 AND STREET = 'KANARI' AND CITY = 'CHIOS';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 3, 3, 'BEDROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 44 AND STREET = 'BOTSARI' AND CITY = 'KATERINI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 4, 4, 'LIVING ROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 91 AND STREET = 'VENIZELOU' AND CITY = 'KALAMATA';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 5, 5, 'BATHROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 30 AND STREET = 'PAPANDREOU' AND CITY = 'ALEXANDROUPOLI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 6, 6, 'ATTIC', REF(A) FROM ADDRESSES A WHERE STREET_NO = 29 AND STREET = 'KARAMANLI' AND CITY = 'XANTHI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 7, 7, 'KIDS ROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 28 AND STREET = 'EGNATIA' AND CITY = 'FLORINA';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 8, 8, 'HALL', REF(A) FROM ADDRESSES A WHERE STREET_NO = 65 AND STREET = 'P. SYNDIKA' AND CITY = 'ARTA';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 9, 9, 'GARAGE', REF(A) FROM ADDRESSES A WHERE STREET_NO = 55 AND STREET = 'STADIOU' AND CITY = 'ARGOS';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 10, 10, 'OFFICE', REF(A) FROM ADDRESSES A WHERE STREET_NO = 34 AND STREET = 'ANAXIMANDROU' AND CITY = 'KOZANI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 11, 11, 'DRESSING ROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 43 AND STREET = 'VOULGARI' AND CITY = 'PTOLEMAIDA';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 12, 12, 'DINING ROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 66 AND STREET = 'MONASTIRIOU' AND CITY = 'VEROIA';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 13, 13, 'CELLAR', REF(A) FROM ADDRESSES A WHERE STREET_NO = 11 AND STREET = 'KASSANDROU' AND CITY = 'PATRA';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 14, 14, 'OTHER', REF(A) FROM ADDRESSES A WHERE STREET_NO = 32 AND STREET = 'OLYMPIADOS' AND CITY = 'ALEXANDROUPOLI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 15, 15, 'BEDROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 25 AND STREET = 'DELFON' AND CITY = 'ALEXANDROUPOLI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 16, 16, 'LIVING ROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 54 AND STREET = 'IONOS DRAGOUMI' AND CITY = 'KATERINI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 17, 17, 'BATHROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 10 AND STREET = 'SINOPIS' AND CITY = 'KATERINI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 18, 18, 'ATTIC', REF(A) FROM ADDRESSES A WHERE STREET_NO = 22 AND STREET = 'AGRIANON' AND CITY = 'THESSALONIKI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 19, 19, 'KIDS ROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 66 AND STREET = 'KANARI' AND CITY = 'VOLOS';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 5, 20, 'HALL', REF(A) FROM ADDRESSES A WHERE STREET_NO = 81 AND STREET = 'RODOU' AND CITY = 'RODOS';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 8, 21, 'GARAGE', REF(A) FROM ADDRESSES A WHERE STREET_NO = 99 AND STREET = 'METRON' AND CITY = 'THESSALONIKI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 3, 22, 'OFFICE', REF(A) FROM ADDRESSES A WHERE STREET_NO = 12 AND STREET = 'SIGALA' AND CITY = 'ALEXANDROUPOLI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 5, 23, 'DRESSING ROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 81 AND STREET = 'NIKOMIDEIAS' AND CITY = 'FLORINA';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 13, 24, 'DINING ROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 64 AND STREET = 'ARAVISSOU' AND CITY = 'KATERINI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 11, 25, 'KITCHEN', REF(A) FROM ADDRESSES A WHERE STREET_NO = 12 AND STREET = 'PAPAFI' AND CITY = 'XANTHI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 1, 26, 'CELLAR', REF(A) FROM ADDRESSES A WHERE STREET_NO = 44 AND STREET = 'KYZIKOU' AND CITY = 'THESSALONIKI';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 19, 27, 'OTHER', REF(A) FROM ADDRESSES A WHERE STREET_NO = 5 AND STREET = 'MALAKOPIS' AND CITY = 'PYRGOS';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 13, 28, 'BEDROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 77 AND STREET = 'AMFIPOLEOS' AND CITY = 'TILOS';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 12, 29, 'BATHROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 26 AND STREET = 'EPTALOFOU' AND CITY = 'DILOS';

INSERT INTO customer_rooms(customer_room_id, customer_id, booking_id, room_desc, room_address)
SELECT seq_customer_room_id.nextval, 12, 29, 'BATHROOM', REF(A) FROM ADDRESSES A WHERE STREET_NO = 26 AND STREET = 'EPTALOFOU' AND CITY = 'DILOS';


--Furniture Inserts
INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(33,44,55), 100, 'CHAIR', 'WOOD', 0, 30.50, 'CHAIRS', 10);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(11,32,66), 50, 'BEAN BAG', 'RED', 'LEATHER', 0, 69.99, 'SEATING', 10);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(21,32,44.73), 32, 'RECLINER', 'GREEN', 'LEATHER', 0, 299.90, 'SEATING', 11);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(12,63,34), 20, 'ROCKING CHAIR', 'BROWN', 'WOOD', 0, 120.80, 'SEATING', 20);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(88,44.32,55.55), 10, 'BENCH', 'WHITE', 'ALUMINIUM', 0, 70, 'SEATING', 19);
---------------
INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(63,74,17.32), 5, 'COUCH', 'PURPLE', 'NUBUCK', 0, 450.90, 'SEATING', 18);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(83,19,19), 6, 'BUNK BED',  'FEATHERS', 0, 120.50, 'SLEEPING', 14);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(91,88,10), 7, 'WATERBED', 'TRANSPARENT', 'PLASTIC', 0, 220, 'SLEEPING', 11);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(10.54,64.31,44.12), 8, 'FUTON', 'GRAY', 'WOOD', 1, 270, 'SEATING', 16);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(67.13,44,75), 9, 'HAMMOCK',  'CLOTH', 0, 15, 'SLEEPING', 18);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(5,99,83), 9, 'MATTRESS', 'WHITE', 'FEATHERS', 0, 120, 'SLEEPING', 19);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(24,73,100), 120, 'SOFA BED',  'WOOD', 1, 150.50, 'SLEEPING/SEATING', 10);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(124,77,120), 10, 'ENTERTAINMENT CENTER', 'BLACK', 'WOOD', 1, 1050, 'ENTERTAINMENT', 11);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(16,62.13,55), 11, 'JUKEBOX', 'RED', 'PLASTIC', 0, 350.50, 'ENTERTAINMENT', 15);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(12,91,89), 12, 'BILLIARD TABLE', 'GREEN', 'WOOD', 0, 1500, 'ENTERTAINMENT', 11);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(11,99,88.70), 13, 'TELEVISION SET', 'BLACK', 'PLASTIC', 1, 750, 'ENTERTAINMENT', 12);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(22,7,83), 14, 'VIDEO GAME CONSOLE', 'BLACK', 'PLASTIC', 0, 350, 'ENTERTAINMENT', 13);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(71,88,6), 15, 'DESK', 'BROWN', 'WOOD', 1, 70, 'TABLES', 15);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(60,43,25), 13, 'COFFEE TABLE', 'BROWN', 'WOOD', 0, 120, 'SEATING', 16);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(34,47,85), 14, 'DINING TABLE', 'BROWN', 'WOOD', 0, 350, 'SEATING', 10);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(18,27,130), 15, 'WORKBENCH', 'BROWN', 'WOOD', 1, 650, 'TABLE', 18);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(16,77,220), 15, 'BOOKCASE',  'PLASTIC', 1, 80, 'ENTERTAINMENT', 19);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(34,62,78.34), 17, 'KITCHEN CABINET', 'WHITE', 'WOOD', 1, 90, 'STORAGE', 10);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(29,19,50.50), 10, 'DRAWER',  'WOOD', 1, 20, 'STORAGE', 11);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(100,70,99.00), 10, 'PANTRY', 'BLACK', 'METAL', 1, 130, 'STORAGE', 12);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(130,112,150.50), 5, 'FILING CABINET', 'WHITE', 'METAL', 1, 30, 'STORAGE', 13);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(230,170.50,282), 5, 'NIGHTSTAND', 'BURGUNDY', 'WOOD', 1, 80, 'STORAGE', 14);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(120.50,32.70,44.66), 5, 'WARDROBE',  'WOOD', 1, 270.50, 'STORAGE', 15);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(82.50,32.30,120), 6, 'WINE RACK', 'BROWN', 'WOOD', 1, 299.90, 'STORAGE', 16);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(100,90,50), 6, 'RECLINER', 'WHITE', 'LEATHER', 0, 240.32, 'SEATING', 17);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(80,70,60), 6, 'WATERBED', 'TRANSPARENT', 'PLASTIC', 0, 78.29, 'SLEEPING', 18);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(33,66,55.10), 12, 'BEAN BAG',  'LEATHER', 0, 30.32, 'SEATING', 19);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(44.32,32,80), 12, 'HAMMOCK', 'WHITE', 'CLOTH', 0, 15.25, 'SLEEPING', 20);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(100,102.5,123), 12, 'MATTRESS', 'RED', 'FEATHERS', 0, 32.68, 'SLEEPING', 18);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(120.32,78.20,66), 12, 'COUCH', 'BLACK', 'LEATHER', 1, 170.24, 'SEATING', 12);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(162,44.55,80), 17, 'COUCH', 'WHITE', 'FABRIC', 1, 499.99, 'SEATING', 13);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(39,40,20), 17, 'SOFA BED', 'PINK', 'WOOD', 1, 264.34, 'SEATING/SLEEPING', 14);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(100,124,99), 17, 'FUTON', 'GRAY', 'WOOD', 1, 210.99, 'SEATING/SLEEPING', 15);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(99.20,115,63), 22, 'FUTON', 'ORANGE', 'WOOD', 1, 99.99, 'SEATING/SLEEPING', 16);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(24,120.66,30), 22, 'JUKEBOX',  'PLASTIC', 0, 350.24, 'ENTERTAINMENT', 17);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(105,66.55,40), 22, 'BILLIARD TABLE', 'GREEN', 'WOOD', 0, 1600.78, 'ENTERTAINMENT', 18);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(66.4,88.20,99), 32, 'KITCHEN CABINET', 'RED', 'WOOD', 1, 89.99, 'STORAGE', 14);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(120,100,110), 32, 'COFFEE TABLE', 'RED', 'WOOD', 0, 50.55, 'SEATING', 12);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(99.99,60.82,82.55), 32, 'DINING TABLE', 'BLACK', 'METAL', 0, 120.99, 'SEATING', 15);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(89.20,130.2,66.52), 4, 'BOOKCASE',  'WOOD', 1, 700, 'STORAGE', 16);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(36.89,130,82), 4, 'NIGHTSTAND',  'WOOD', 1, 50, 'STORAGE', 18);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(10,30,99), 4, 'DRAWER', 'WHITE', 'WOOD', 1, 30, 'STORAGE', 11);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(200,400,99), 3, 'PANTRY', 'GREEN', 'WOOD', 1, 299.80, 'STORAGE', 14);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_color, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(66.88,362,55.20), 3, 'DESK', 'GREEN', 'WOOD', 1, 70, 'TABLES', 19);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(99,120,59), 3, 'DESK',  'WOOD', 1, 80, 'TABLES', 10);

INSERT INTO furniture (furniture_id, furniture_size, furniture_weight, furniture_name, furniture_material, furniture_container, furniture_price, furniture_category, furniture_in_stock)
VALUES (seq_furniture_id.nextval, FURNITURE_SIZE_TYPE(99,120,59), 3, 'DESK',  'WOOD', 1, 80, 'TABLES', 10);


--Furniture Used inserts
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (100, 1000, 5, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (110, 2100, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (120, 3200, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (130, 4300, 5, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (140, 5400, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (150, 6000, 2, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (160, 1100, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (170, 2200, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (180, 3300, 1, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (190, 4400, 2, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (200, 5500, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (210, 1200, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (220, 2300, 2, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (230, 3400, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (240, 4500, 5, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (250, 5600, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (260, 1300, 2, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (270, 2400, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (280, 3500, 5, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (290, 4600, 1, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (300, 5700, 2, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (310, 1400, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (320, 2500, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (330, 3600, 5, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (340, 4700, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (350, 5800, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (360, 1500, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (110, 2600, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (150, 3700, 2, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (120, 4800, 1, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (300, 5900, 1, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (270, 1600, 1, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (230, 2700, 5, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (200, 3800, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (200, 4900, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (130, 1000, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (140, 2100, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (160, 3200, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (210, 4300, 2, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (220, 5400, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (230, 1100, 2, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (260, 2200, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (310, 3300, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (320, 4400, 2, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (310, 5500, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (340, 1200, 6, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (330, 2300, 4, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (360, 3400, 3, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (210, 4500, 2, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (290, 5600, 6, CURRENT_TIMESTAMP);
INSERT INTO furniture_used(customer_room_id, furniture_id, quantity, date_ordered) VALUES (280, 6000, 3, CURRENT_TIMESTAMP);

--FURNITURE REVIEWS INSERTS
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,1, 1000, 'VERY LIKEABLE', 5, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,2, 1100, '5 STARS', 5, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,3, 1200, 'GREAT FURNITURE', 4, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,4, 1300, 'HIGHLY REOMMENDED', 4, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,5, 1400, 'VERY COMFORTABLE', 5, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,6, 1500, 'DISAPPOINTED', 1, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,7, 1600, 'NOT RECOMMENDED', 2, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,8, 1700, 'DONT BOTHER!', 1, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,9, 1800, 'GREAT VALUE', 3, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,10, 1900, 'I LOVE IT!', 4, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,11, 2000, 'LOVE THE COLOR', 5, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,12, 2100, 'PERFECTLY SIZED', 3, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,13, 2200, 'GREAT COUCH', 4, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,14, 2300, 'ITS AWESOME!', 5, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,15, 2400, 'RETURNED, DEFECTIVE', 1.7, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,16, 2500, 'GREAT PRICE', 4.2, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,17, 2600, 'STURDY', 5.1, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,18, 2700, 'DONT WASTE YOUR MONEY', 1.3, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,19, 2800, 'SUITS MY NEEDS', 3.5, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);
INSERT INTO furniture_reviews(review_id, review_author, furniture_id, review_title, review_rating, review_comment, review_date) VALUES (seq_review_id.nextval,20, 2900, 'A WINNER', 1, 'LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT', CURRENT_TIMESTAMP);



SELECT * FROM TAB;
DESC CUSTOMERS;
DESC FURNITURE;
DESC FURNITURE_REVIEWS;
DESC FURNITURE_USED;
DESC CUSTOMER_ROOMS;

SELECT SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, INCREMENT_BY FROM USER_SEQUENCES;
