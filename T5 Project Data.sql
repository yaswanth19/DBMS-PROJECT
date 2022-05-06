################################# CREATE DATABASE ##############################################
CREATE DATABASE ONLINE_XYS_INSURANCE_DATABASE;
USE ONLINE_XYS_INSURANCE_DATABASE;
drop database ONLINE_XYS_INSURANCE_DATABASE
################################################################################################

####################### PROCEDURE CREATE TABLES IN DATABASES  ##################################
DELIMITER $$
CREATE PROCEDURE CREATE_ONLINE_XYZ_INSURANCES_DATABASE_ENTITES ()
DETERMINISTIC
BEGIN

CREATE TABLE T5_Customer( 
	T5_CUST_ID INT, 
	T5_CUST_FNAME VARCHAR(10), 
	T5_CUST_LNAME VARCHAR(10), 
	T5_CUST_DOB DATE, 
	T5_CUST_GENDER CHAR(2), 
	T5_CUST_ADDRESS VARCHAR(20), 
	T5_CUST_MOB_NUMBER INT, 
	T5_CUST_EMAIL VARCHAR(20), 
	T5_CUST_PASSPORT_NUMBER VARCHAR(20), 
	T5_CUST_MARITAL_STATUS CHAR(8), 
	T5_CUST_PPS_NUMBER INT,
	PRIMARY KEY (T5_CUST_ID)
);

CREATE TABLE T5_INSURANCE_COMPANY (
	T5_COMPANY_NAME VARCHAR(40) PRIMARY KEY,
	T5_COMPANY_ADDRESS VARCHAR(20),
	T5_COMPANY_CONTACT_NUMBER INT,
	T5_COMPANY_FAX INT,
	T5_COMPANY_EMAIL VARCHAR(20),
	T5_COMPANY_WEBSITE VARCHAR(20),
	T5_NOK_PHONE_NUMBER INT,
	T5_COMPANY_LOCATION VARCHAR(20),
	T5_COMPANY_DEPARTMENT_NAME VARCHAR(20),
	T5_COMPANY_OFFICE_NAME VARCHAR(20)
);

CREATE TABLE T5_APPLICATION( 
	T5_APPLICATION_ID INT,
	T5_CUST_ID INT,
	T5_VEHICLE_ID INT,
	T5_APPLICATION_STATUS CHAR(8),
	T5_COVERAGE VARCHAR(50),
	PRIMARY KEY(T5_APPLICATION_ID),
	CONSTRAINT FOREIGN KEY(T5_CUST_ID) REFERENCES T5_CUSTOMER(T5_CUST_ID)
);

CREATE TABLE T5_QUOTE( 
	T5_QUOTE_ID INT PRIMARY KEY, 
	T5_APPLICATION_ID INT, 
	T5_CUST_ID INT, 
	T5_ISSUE_DATE DATE, 
	T5_VALID_FROM_DATE DATE, 
	T5_VALID_TILL_DATE DATE,
	T5_DESCRIPTION VARCHAR(100), 
	T5_PRODUCT_ID INT,
	T5_COVERAGE_LEVEL VARCHAR(20),
	CONSTRAINT FOREIGN KEY(T5_APPLICATION_ID) REFERENCES T5_APPLICATION(T5_APPLICATION_ID), 
	CONSTRAINT FOREIGN KEY(T5_CUST_ID) REFERENCES T5_CUSTOMER(T5_CUST_ID)
);


CREATE TABLE T5_INSURANCE_POLICY(
	T5_AGREEMENT_ID INT PRIMARY KEY,
    T5_APPLICATION_ID INT,
    T5_CUST_ID INT,
    T5_DEPARTMENT_NAME VARCHAR(20),
    T5_POLICY_NUMBER INT,
    T5_START_DATE DATE,
    T5_EXPIRY_DATE DATE,
    T5_TERM_CONDITION_DESCRIPTION VARCHAR(100),
    CONSTRAINT FOREIGN KEY (T5_APPLICATION_ID) REFERENCES T5_APPLICATION(T5_APPLICATION_ID),
    CONSTRAINT FOREIGN KEY (T5_CUST_ID) REFERENCES T5_CUSTOMER(T5_CUST_ID)
);



CREATE TABLE T5_PREMIUM_PAYMENT(
	T5_PREMIUM_PAYMENT_ID INT,
    T5_CUST_ID INT,
    T5_POLICY_ID INT UNIQUE,
    T5_PREMIUM_PAYMENT_SCHEDULE DATE,
    T5_PREMIUM_PAYMENT_AMOUNT INT, 
    T5_RECEIPT_ID INT,
    PRIMARY KEY (T5_PREMIUM_PAYMENT_ID),
    FOREIGN KEY (T5_CUST_ID) REFERENCES T5_CUSTOMER(T5_CUST_ID)
);



CREATE TABLE T5_VEHICLE(
	T5_VEHICLE_ID INT PRIMARY KEY,
    T5_CUST_ID INT,
    T5_POLICY_ID  INT UNIQUE,
    T5_DEPENDENT_NOK_ID INT,
    T5_VEHICLE_REGISTRATION_NUMBER INT,
    T5_VEHICLE_VALUE INT,
    T5_VEHICLE_TYPE VARCHAR(20),
    T5_VEHICLE_SIZE INT,
    T5_VEHICLE_NUMBER_OF_SEAT INT,
    T5_VEHICLE_MANUFACTURER VARCHAR(20),
    T5_VEHICLE_ENGINE_NUMBER INT,
    T5_VEHICLE_CHASIS_NUMBER INT,
    T5_VEHICLE_NUMBER INT,
    T5_VEHICLE_MODEL_NUMBER INT ,
    FOREIGN KEY (T5_CUST_ID) REFERENCES T5_CUSTOMER(T5_CUST_ID)
);

##TABLE 7,8,9
CREATE TABLE T5_CLAIM(
	T5_CLAIM_ID INT PRIMARY KEY,
    T5_CUST_ID INT,
    T5_AGREEMENT_ID INT,
    T5_CLAIM_AMOUNT INT,
    T5_INCIDENT_ID INT,
    T5_DAMAGE_TYPE VARCHAR(20),
    T5_DATE_OF_CLAIM DATE,
    T5_CLAIM_STATUS CHAR(10),
    FOREIGN KEY (T5_CUST_ID) REFERENCES T5_CUSTOMER(T5_CUST_ID)
);

CREATE TABLE T5_CLAIM_SETTLEMENT(
	T5_CLAIM_SETTLEMENT_ID INT PRIMARY KEY,
    T5_CLAIM_ID INT,
    T5_CUST_ID INT,
    T5_VEHICLE_ID INT,
    T5_DATE_SETTLED DATE,
    T5_AMAOUNT_PAID INT,
    T5_COVERAGE_ID INT ,
    FOREIGN KEY (T5_CUST_ID) REFERENCES T5_CUSTOMER(T5_CUST_ID),
    FOREIGN KEY (T5_CLAIM_ID) REFERENCES T5_CLAIM(T5_CLAIM_ID)
);

CREATE TABLE T5_STAFF(
	T5_STAFF_ID INT PRIMARY KEY,
    T5_COMPANY_NAME VARCHAR(20),
    T5_STAFF_FNAME VARCHAR(20),
    T5_STAFF_LNAME VARCHAR(10),
	T5_STAFF_ADDRESS VARCHAR(20),
    T5_STAFF_CONTACT INT,
    T5_STAFF_GENDER CHAR(2),
    T5_MARITAL_STATUS CHAR(8),
    T5_STAFF_NATIONALITY CHAR(15),
    T5_STAFF_QUALIFICATION VARCHAR(20),
    T5_STAFF_ALLOWANCE INT,
    T5_STAFF_PPS_NUMBER INT,
    FOREIGN KEY (T5_COMPANY_NAME) REFERENCES T5_INSURANCE_COMPANY(T5_COMPANY_NAME)
);

##TABLE 10,11,12
CREATE TABLE T5_DEPARTMENT(
	T5_DEPARTMENT_NAME VARCHAR(40),
    T5_COMPANY_NAME VARCHAR(20),
    T5_OFFICE VARCHAR(50),
    T5_CONTACT_INFORMATION VARCHAR(10),
    T5_DEPARTMENT_STAFF VARCHAR(20),
    T5_DEPARTMENT_LEADER VARCHAR(20) ,
    PRIMARY KEY(T5_DEPARTMENT_NAME, T5_OFFICE),
    FOREIGN KEY (T5_COMPANY_NAME) REFERENCES T5_INSURANCE_COMPANY (T5_COMPANY_NAME)
);

 CREATE TABLE T5_OFFICE(
	T5_OFFICE_NAME VARCHAR(20) PRIMARY KEY,
    T5_DEPARTMENT_NAME VARCHAR(40),
    T5_COMPANY_NAME VARCHAR(20),
    T5_OFFICE_LEADER VARCHAR(20),
    T5_CONTACT_INFORMATION VARCHAR(10),
    T5_ADDRESS VARCHAR(50),
    T5_ADMIN_COST INT,
    T5_STAFF VARCHAR(20),
    FOREIGN KEY (T5_COMPANY_NAME) REFERENCES T5_INSURANCE_COMPANY (T5_COMPANY_NAME),
    FOREIGN KEY (T5_DEPARTMENT_NAME) REFERENCES T5_DEPARTMENT (T5_DEPARTMENT_NAME)
);

CREATE TABLE T5_MEMBERSHIP(
	T5_MEMBERSHIP_ID INT PRIMARY KEY,
    T5_CUST_ID INT,
    T5_MEMBERSHIP_TYPE CHAR(15),
    T5_ORGANISATION_CONTACT INT,
    FOREIGN KEY (T5_CUST_ID) REFERENCES T5_CUSTOMER (T5_CUST_ID)
);

##TABLE 13,14,15

CREATE TABLE T5_VEHICLE_SERVICE( 
	T5_VEHICLE_SERVICE VARCHAR(20) PRIMARY KEY, 
	T5_VEHICLE_ID INT, 
	T5_CUST_ID INT, 
	T5_DEPARTMENT_NAME VARCHAR(20), 
	T5_VEHICLE_SERVICE_ADDRESS VARCHAR(20), 
	T5_VEHICLE_SERVICE_CONTACT INT, 
	T5_VEHICLE_SERVICE_INCHARGE VARCHAR(20), 
	T5_VEHICLE_SERVICE_TYPE VARCHAR(20),
	FOREIGN KEY (T5_VEHICLE_ID) REFERENCES T5_VEHICLE(T5_VEHICLE_ID),
	FOREIGN KEY (T5_CUST_ID) REFERENCES T5_CUSTOMER(T5_CUST_ID)
);

CREATE TABLE T5_NOK ( 
	t5_NOK_ID INT PRIMARY KEY,
	T5_AGREEMENT_ID INT, 
	T5_APPLICATION_ID INT, 
	T5_CUST_ID INT, 
	T5_NOK_NAME VARCHAR(20), 
	T5_NOK_ADDRESS VARCHAR(20), 
	T5_NOK_PHONE_NUMBER INT,
	T5_NOK_MARITAL_STATUS CHAR(10), 
	T5_NOK_GENDER CHAR(2),
	FOREIGN KEY (T5_AGREEMENT_ID) REFERENCES T5_INSURANCE_POLICY(T5_AGREEMENT_ID),
	FOREIGN KEY (T5_APPLICATION_ID) REFERENCES T5_INSURANCE_POLICY(T5_APPLICATION_ID),
	FOREIGN KEY (T5_CUST_ID) REFERENCES T5_CUSTOMER(T5_CUST_ID)
);

###table 16,17,18
CREATE TABLE T5_POLICY_RENEWABLE (
	T5_POLICY_RENEWABLE_ID INT PRIMARY KEY,
	T5_AGREEMENT_ID INT,	
	T5_APPLICATION_ID INT,
	T5_CUST_ID INT,
	T5_DATE_OF_RENEWAL DATE,
	T5_TYPE_OF_RENEWAL CHAR(15),
	FOREIGN KEY (T5_CUST_ID) REFERENCES T5_CUSTOMER(T5_CUST_ID),
	FOREIGN KEY (T5_APPLICATION_ID) REFERENCES T5_APPLICATION(T5_APPLICATION_ID),
	FOREIGN KEY (T5_AGREEMENT_ID) REFERENCES T5_INSURANCE_POLICY(T5_AGREEMENT_ID)
);


CREATE TABLE T5_INCIDENT(
	T5_INCIDENT_ID INT PRIMARY KEY,
	T5_INCIDENT_TYPE  VARCHAR(20),
	T5_INCIDENT_DATE DATE,
	T5_DESCRIPTION VARCHAR(100)
);

CREATE TABLE T5_INCIDENT_REPORT(
	T5_INCIDENT_REPORT_ID INT PRIMARY KEY,
	T5_INCIDENT_ID INT,
	T5_CUST_ID INT,
	T5_INCIDENT_INSPECTOR VARCHAR(20),
	T5_INCIDENT_COST INT,
	T5_INCIDENT_TYPE CHAR(10),
	T5_INCIDENT_REPORT_DESCRIPTION VARCHAR(100),
	FOREIGN KEY(T5_INCIDENT_ID) REFERENCES T5_INCIDENT(T5_INCIDENT_ID),
	FOREIGN KEY(T5_CUST_ID) REFERENCES T5_CUSTOMER(T5_CUST_ID)
);

 
##tABLE 19,20,21,22

CREATE TABLE T5_COVERAGE(
	T5_COVERAGE_ID INT PRIMARY KEY,
	T5_COVERAGE_AMOUNT INTEGER,
	T5_COVERAGE_TYPE CHAR(10),
	T5_COVERAGE_LEVEL CHAR(15),
	T5_PRODUCT_ID INT,
	T5_COVERAGE_DESCRIPTION VARCHAR(100),
	T5_COVERAGE_TERMS VARCHAR(50),
	T5_COMPANY_NAME VARCHAR(20),
	FOREIGN KEY(T5_COMPANY_NAME) REFERENCES T5_INSURANCE_COMPANY(T5_COMPANY_NAME)
);

CREATE TABLE T5_PRODUCT(
	T5_PRODUCT_NUMBER INT PRIMARY KEY,
	T5_PRODUCT_PRICE INTEGER,
	T5_PRODUCT_TYPE CHAR(15),
	T5_COMPANY_NAME VARCHAR(20),
	FOREIGN KEY(T5_COMPANY_NAME) REFERENCES T5_INSURANCE_COMPANY(T5_COMPANY_NAME)
);

CREATE TABLE T5_RECEIPT(
	T5_RECEIPT_ID INT PRIMARY KEY,
	T5_COST INTEGER,
	T5_TIME DATE,
	T5_PREMIUM_PAYMENT_ID int,
	T5_CUST_ID int,
	FOREIGN KEY(T5_PREMIUM_PAYMENT_ID) REFERENCES T5_PREMIUM_PAYMENT(T5_PREMIUM_PAYMENT_ID),
	FOREIGN KEY(T5_CUST_ID) REFERENCES T5_CUSTOMER(T5_CUST_ID)
);

CREATE TABLE T5_INSURANCE_POLICY_COVERAGE(
	T5_AGREEMENT_ID VARCHAR(20) PRIMARY KEY ,
	T5_COVERAGE_ID INT ,
	FOREIGN KEY(T5_COVERAGE_ID) REFERENCES T5_COVERAGE(T5_COVERAGE_ID)
);

/*
create table test(
	id int primary key,
    stringid varchar(10)
);
*/
SET SQL_SAFE_UPDATES=0;
SHOW TABLES;
END $$ 
########################################################################################################

############################## PROCEDURE DELETE ALL TABLES IN DATABASES  ################################
DELIMITER //
CREATE PROCEDURE DELETE_ALL_TABLES ()
DETERMINISTIC 
BEGIN
DROP TABLES t5_application , t5_claim ,t5_claim_settlement ,t5_coverage ,t5_customer ,t5_department , t5_incident , t5_incident_report , t5_insurance_company , 
t5_insurance_policy , t5_insurance_policy_coverage , t5_membership ,t5_nok , t5_office , t5_policy_renewable , t5_premium_payment , t5_product , 
t5_quote , t5_receipt , t5_staff , t5_vehicle , t5_vehicle_service;
SHOW TABLES;
END // 
########################################################################################################

############################## PROCEDURE TO INSERT DATASET  #############################################
DELIMITER //
CREATE PROCEDURE INSERT_DATASET ()
DETERMINISTIC 
BEGIN

INSERT INTO t5_customer VALUES (2001, 'Taylor', 'swift', '1990-12-23', 'F', 'Pennsylvania',245698, 'taylorvma@gmail.com', 'A123456', 'Single', 3054586) ;
INSERT INTO t5_customer VALUES (2002, 'James', 'Harden', '1987-10-6', 'M', 'Brooklyn', 685684, 'james@gmail.com', 'T848758', 'Married', 5648624) ;
INSERT INTO t5_customer VALUES (2003, 'Lebron', 'James', '1980-03-1', 'M', 'Cleveland', 745356, 'lj@gmail.com', 'P365944', 'Married', 5478923) ;
INSERT INTO t5_customer VALUES (2004, 'Dua', 'Lipa', '1996-12-5', 'F', 'London', 764513, 'dlipa@gmail.com', 'A432543', 'Single', 2159764) ;
INSERT INTO t5_customer VALUES (2005, 'Shubh', 'Bindal', '2000-08-10', 'M', 'Delhi', 984235, 'shubh@gmail.com', 'L346895', 'Single', 4546952) ;
INSERT INTO t5_customer VALUES (2006, 'Yaswanth', 'Gali', '2001-06-14', 'M', 'Vijayawada', 709759, 'yaswanth@gmail.com', 'K375159', 'Single', 8866825) ;
INSERT INTO t5_customer VALUES (2007, 'Kobe', 'Brynt', '1979-08-10', 'M', 'Stapple centre', 856348, 'kobe@gmail.com', 'O486213', 'Married', 2168745) ;
INSERT INTO t5_customer VALUES (2008, 'Shreya', 'Ghoshal', '1985-06-28', 'F', 'Mumbai', 758595, 'shreya@gmail.com', 'T139782', 'Married', 2186385) ;
INSERT INTO t5_customer VALUES (2009, 'Sanket', 'Singh', '1976-06-07', 'M', 'Amritsar', 758556, 'sanket@gmail.com', 'U742368', 'Single', 2386131) ;
INSERT INTO t5_customer VALUES (2010, 'Abdul', 'Kareem', '1970-09-12', 'M', 'Kolkata', 946754, 'akr@gmail.com', 'P951735', 'Single', 4581677) ;
INSERT INTO t5_customer VALUES (2011, 'Pooja', 'Shetty', '1984-12-03', 'F', 'Banglore', 956545, 'pooja@gmail.com', 'D864869', 'Single', 5815973) ;
INSERT INTO t5_customer VALUES (2012, 'Salman', 'Khan', '1972-08-09', 'M', 'Mumbai', 957845, 'bhai@gmail.com', 'X123789', 'Married', 695173) ;
INSERT INTO t5_customer VALUES (2013, 'Kavya', 'Maran', '1995-04-24', 'F', 'Chennai', 335548, 'sunrisers@gmail.com', 'S456739', 'Single', 4486251) ;
INSERT INTO t5_customer VALUES (2014, 'Kevin', 'Hart', '1988-06-14', 'M', 'Las vegas', 123456, 'comedy@gmail.com', 'U258469', 'Married', 2139755) ;
INSERT INTO t5_customer VALUES (2015, 'Kajal', 'Aggarwal', '1985-07-23', 'F', 'Hyderabad', 789895, 'kajal36@gmail.com', 'E415885', 'Married', 2426859) ;
INSERT INTO t5_customer VALUES (2016, 'Arjun', 'Desai', '1979-07-25', 'M', 'Kochi', 852963, 'arjun@gmail.com', 'G135652', 'Single', 5458626) ;

## 2 Application Table
INSERT INTO t5_application VALUES ('2101', '2001', '2501', 'Accepted', 'Collision Coverage');
INSERT INTO t5_application  VALUES ('2102', '2002', '2502', 'Accepted', 'Comprehensive Coverage');
INSERT INTO t5_application  VALUES ('2103', '2003', '2503', 'Accepted', 'Liability Coverage');
INSERT INTO t5_application  VALUES ('2104', '2004', '2504', 'Accepted', 'Collision Coverage\'');
INSERT INTO t5_application VALUES ('2105', '2005', '2505', 'Accepted', 'Personal Accident Coverage');
INSERT INTO t5_application  VALUES ('2106', '2006', '2506', 'Accepted', 'Collision Coverage\'');
INSERT INTO t5_application VALUES ('2107', '2007', '2507', 'Accepted', 'Liability Coverage');
INSERT INTO t5_application VALUES ('2108', '2008', '2508', 'Accepted', 'Zero Depreciation Coverage');
INSERT INTO t5_application  VALUES ('2109', '2009', '2509', 'Accepted', 'Third party liability only Cover');
INSERT INTO t5_application  VALUES ('2110', '2010', '2510', 'Accepted', 'Liability Coverage');
INSERT INTO t5_application  VALUES ('2111', '2011', '2511', 'Accepted', 'Third party liability only Cover');
INSERT INTO t5_application  VALUES ('2112', '2012', '2512', 'Accepted', 'Collision Coverage\'');
INSERT INTO t5_application  VALUES ('2113', '2013', '2513', 'Accepted', 'Zero Depreciation Coverage');
INSERT INTO t5_application  VALUES ('2114', '2014', '2514', 'Accepted', 'Liability Coverage');
INSERT INTO t5_application  VALUES ('2115', '2015', '2515', 'Accepted', 'Liability Coverage');
INSERT INTO t5_application  VALUES ('2116', '2001', '2516', 'Accepted', 'Collision Coverage');
INSERT INTO t5_application  VALUES ('2117', '2002', '2517', 'Accepted', 'Liability Coverage');
INSERT INTO t5_application  VALUES ('2118', '2005', '2518', 'Accepted', 'Liability Coverage');


## 3 Quote Table
INSERT INTO T5_QUOTE VALUES ('2201', '2101', '2001', '2020-1-15', '2020-1-15', '2022-1-15', 'KTM DUKE', '3901', '2000');
INSERT INTO T5_QUOTE VALUES ('2202', '2102', '2002', '2020-1-29', '2020-1-29', '2022-1-29', 'Hyundai Creta ex', '3902', '5000');
INSERT INTO T5_QUOTE VALUES ('2203', '2103', '2003', '2020-2-13', '2020-2-13', '2025-2-13', 'ACTIVA 5G', '3903', '1500');
INSERT INTO T5_QUOTE VALUES ('2204', '2104', '2004', '2020-3-2', '2020-3-2', '2023-3-2', 'Land Rover Defender 2.0 L Petrol (90) SE', '3904', '10000');
INSERT INTO T5_QUOTE VALUES ('2205', '2105', '2005', '2020-4-23', '2020-4-23', '2023-4-23', 'KTM 390 Adventure', '3905', '4000');
INSERT INTO T5_QUOTE VALUES ('2206', '2106', '2006', '2020-5-17', '2020-5-17', '2024-5-17', 'BMW X3 Drive30i Luxury Line', '3906', '6500');
INSERT INTO T5_QUOTE VALUES ('2207', '2107', '2007', '2020-6-19', '2020-6-19', '2021-6-19', 'Royal Enfield Classic 350', '3907', '3500');
INSERT INTO T5_QUOTE VALUES ('2208', '2108', '2008', '2020-7-12', '2020-7-12', '2026-7-12', 'Jeep Wrangler Unlimited 2.0L GME T4 Petrol', '3908', '7000');
INSERT INTO T5_QUOTE VALUES ('2209', '2109', '2009', '2020-8-5', '2020-8-5', '2022-8-5', 'BMW X3 Drive30i Luxury Line', '3909', '3500');
INSERT INTO T5_QUOTE VALUES ('2210', '2110', '2010', '2020-9-12', '2020-9-12', '2024-9-12', 'Volvo XC60', '3910', '5000');
INSERT INTO T5_QUOTE VALUES ('2211', '2111', '2011', '2020-10-20', '2020-10-20', '2025-10-20', 'Hyundai i20', '3911', '6000');
INSERT INTO T5_QUOTE VALUES ('2212', '2112', '2012', '2021-1-3', '2021-1-3', '2025-1-3', 'TATA Harrier xm', '3912', '5500');
INSERT INTO T5_QUOTE VALUES ('2213', '2113', '2013', '2021-2-27', '2021-2-27', '2024-2-27', 'Ford EcoSport titanium', '3913', '4500');
INSERT INTO T5_QUOTE VALUES ('2214', '2114', '2014', '2021-3-23', '2021-3-23', '2025-3-23', 'Royal Enfield Interceptor 650', '3914', '5000');
INSERT INTO T5_QUOTE VALUES ('2215', '2115', '2015', '2021-4-14', '2021-4-14', '2025-4-14', 'Royal Enfield Himalayan', '3915', '4500');
INSERT INTO T5_QUOTE VALUES ('2216', '2116', '2001', '2020-3-17', '2020-3-17', '2024-3-16', 'Hyndai Creta', '3916', 'Comprh. coverage');
insert into t5_quote values ('2217', '2117', '2002', '2021-5-13', '2021-5-13', '2025-5-12', 'Maruti Suzuki Brezza', '3917', 'Collision Coverage');
insert into t5_quote values ('2218', '2118', '2005', '2022-1-13', '2022-1-13', '2026-1-12', 'Kia Celtos', '3918', 'Comprh. Coverage');

## 4 INSURANCE POLICY
INSERT INTO T5_INSURANCE_POLICY  VALUES (2301, 2101, 2001, 'Claims', 25011, '2019-12-01', '2024-12-01', 'Coverage against loss of or damage to your vehicle caused by accident');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2302, 2102, 2002, 'Legal', 25022, '2019-12-12', '2024-12-12', 'Coverage against loss of or damage to your vehicle caused by natural calamities');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2303, 2103, 2003, 'Reinsurance ', 25033, '2019-12-20', '2024-12-20', 'Coverage against loss of or damage to your vehicle caused by accident');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2304, 2104, 2004, 'Claims', 25044, '2020-01-12', '2025-01-12', 'Coverage against loss of or damage to your vehicle caused by riots,strikes');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2305, 2105, 2005, 'Legal', 25055, '2020-01-28', '2025-01-28', 'Coverage against loss of or damage to your vehicle caused by natural calamities');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2306, 2106, 2006, 'Marketing', 25066, '2020-02-26', '2025-02-26', 'Coverage against loss of or damage to your vehicle caused by accident');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2307, 2107, 2007, 'Agency', 25077, '2020-03-02', '2025-03-02', 'Coverage against loss of or damage to your vehicle caused by riots,strikes');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2308, 2108, 2008, 'Reinsurance', 25088, '2020-04-07', '2025-04-07', 'Coverage against loss of or damage to your vehicle caused by natural calamities');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2309, 2109, 2009, 'Agency', 25099, '2020-05-29', '2025-05-29', 'Coverage against loss of or damage to your vehicle caused by accident');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2310, 2110, 2010, 'Marketing', 25111, '2020-06-17', '2025-06-17', 'Coverage against loss of or damage to your vehicle caused by riots,strikes');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2311,2111,2011,'Claims',25112,'2020-07-03','2025-07-03','Coverage against loss of or damage');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2312,2112,2012,'Claims',25133,'2020-08-09','2025-08-09','Coverage against loss of or damage');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2313,2113,2013,'Claims',25144,'2020-09-14','2025-09-14','Third Party cover ');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2314,2114,2014,'Claims',25155,'2020-10-05','2025-10-05','Coverage against loss of or damage');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2315,2115,2015,'Legal',25166,'2021-01-06','2026-01-06','Third party cover');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2316,2116,2001,'Claims',25177,'2021-02-16','2026-02-16','Coverage against loss of or damage');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2317,2117,2002,'Legal',25188,'2021-03-21','2026-03-21','Third party cover');
INSERT INTO T5_INSURANCE_POLICY  VALUES (2318,2118,2005,'Agency',25199,'2021-02-18','2026-02-18','Coverage against loss of or damage');

## 5 premium payment

INSERT INTO t5_premium_payment VALUES ('2401', '2001', '25011', '2020-1-15', '11000', '4001');
INSERT INTO t5_premium_payment VALUES ('2402', '2002', '25022', '2020-1-29', '9000', '4002');
INSERT INTO t5_premium_payment VALUES ('2403', '2003', '25033', '2020-2-13', '15000', '4003');
INSERT INTO t5_premium_payment VALUES ('2404', '2004', '25044', '2020-3-2', '21000', '4004');
INSERT INTO t5_premium_payment VALUES ('2405', '2005', '25055', '2020-4-23', '4000', null);
INSERT INTO t5_premium_payment VALUES ('2406', '2006', '25066', '2020-5-17', '40000', '4006');
INSERT INTO t5_premium_payment VALUES ('2407', '2007', '25077', '2020-6-19', '20000', '4007');
INSERT INTO t5_premium_payment VALUES ('2408', '2008', '25088', '2020-7-12', '16500', '4008');
INSERT INTO t5_premium_payment VALUES ('2409', '2009', '25099', '2020-8-5', '30000', '4009');
INSERT INTO t5_premium_payment VALUES ('2410', '2010', '25111', '2020-9-12', '16500', '4010');
INSERT INTO t5_premium_payment VALUES ('2411', '2011', '25122', '2020-10-20', '21000', '4011');
INSERT INTO t5_premium_payment VALUES ('2412', '2012', '25133', '2021-1-3', '29000', '4012');
INSERT INTO t5_premium_payment VALUES ('2413', '2013', '25144', '2021-2-27', '13500', '4013');
INSERT INTO t5_premium_payment VALUES ('2414', '2014', '25155', '2021-3-23', '9500', '4014');
INSERT INTO t5_premium_payment VALUES ('2415', '2015', '25166', '2021-4-14', '22000', '4015');
INSERT INTO t5_premium_payment VALUES ('2416', '2001', '25177', '2021-5-01', '25000', null);
INSERT INTO t5_premium_payment VALUES ('2417', '2002', '25188', '2021-6-12', '17000', '4017');
INSERT INTO t5_premium_payment VALUES ('2418', '2005', '25199', '2021-3-17', '18000', '4018');

## 6 Vehicle Table
insert into t5_vehicle values (2501, 2001, 25011, 3301, 2531, 900000, '2 wheeler', 3.6, 2, 'KTM', 2501001, 250101, 25011, 2015);
insert into t5_vehicle values (2502, 2002, 25022, 3302, 2532, 700000, '4 wheeler', 5.8, 7, 'Hyundai', 2501002, 250102, 25012, 2014);
insert into t5_vehicle values (2503, 2003, 25033, 3303, 2533, 50000, '2 wheeler', 3.6, 2, 'Honda', 2501003, 250103, 25013, 2017);
insert into t5_vehicle values (2504, 2004, 25044, 3304, 2534, 35000000, '4 wheeler', 6.3, 6, 'Land Rover', 2501004, 250104, 25014, 2016);
insert into t5_vehicle values (2505, 2005, 25055, 3305, 2535, 840000, '2 wheeler', 3.4, 2, 'KTM', 2501005, 250105, 25015, 2015);
insert into t5_vehicle values (2506, 2006, 25066, 3306, 2536, 14000000, '4 wheeler', 4.6, 4, 'BMW', 2501006, 250106, 25016, 2019);
insert into t5_vehicle values (2507, 2007, 25077, 3307, 2537, 970000, '2 wheeler', 3.8, 2, 'Royal Enfield', 2501007, 250107, 25017, 2019);
insert into t5_vehicle values (2508, 2008, 25088, 3308, 2538, 1250000, '4 wheeler', 5.6, 4, 'Jeep', 2501008, 250108, 25018, 2020);
insert into t5_vehicle values (2509, 2009, 25099, 3309, 2539, 6400000, '4 wheeler', 4.6, 4, 'BMW', 2501009, 250109, 25019, 2017);
insert into t5_vehicle values (2510, 2010, 25111, 3310, 2540, 720000, '4 wheeler', 5.2, 6, 'Volvo', 2501010, 250110, 25020, 2016);
insert into t5_vehicle values (2511, 2011, 25122, 3311, 2541, 1000000, '4 wheeler', 6.6, 5, 'Hyundai', 2501011, 250111, 25021, 2015);
insert into t5_vehicle values (2512, 2012, 25133, 3312, 2542, 1100000, '4 wheeler', 5.7, 5, 'TATA', 2501012, 250112, 25023, 2014);
insert into t5_vehicle values (2513, 2013, 25144, 3313, 2543, 1400000, '4 wheeler', 5.9, 5, 'Ford', 2501013, 250113, 25024, 2013);
insert into t5_vehicle values (2514, 2014, 25155, 3314, 2544, 1300000, '2 wheeler', 5.0, 2, 'Royal Enfield', 2501014, 250114, 25025, 2019);
insert into t5_vehicle values (2515, 2015, 25166, 3315, 2545, 1500000, '2 wheeler', 5.2, 2, 'Royal Enfield', 2501015, 250115, 25026, 2014);
insert into t5_vehicle values (2516, 2001, 25177, 3301, 2546, 1100000, '4 wheeler', 5.8, 5, 'Hyundai', 2501016, 250116, 25027, 2016);
insert into t5_vehicle values (2517, 2002, 25188, 3302, 2547, 600000, '4 wheeler', 6.1, 4, 'Maruti Suzuki', 2501017, 250117, 25028, 2016);
insert into t5_vehicle values (2518, 2005, 25199, 3303, 2548, 1700000, '4 wheeler', 6.2, 5, 'Kia', 2501018, 250118, 25029, 2019);


## 7 Claim
INSERT INTO  t5_claim VALUES (2601,2008,25088,3235,3602,"Bumper to Bumper",'2022-04-03','Pending');
INSERT INTO  t5_claim VALUES (2602,2005,25055,6722,3603,"Bonnet, Fender Dent",'2022-03-01','Pending');
INSERT INTO  t5_claim VALUES (2603,2011,25122,357,3605,"2 rear view mirror",'2022-04-15','Settled');
INSERT INTO  t5_claim VALUES (2604,2013,25144,3105,3601,"Bumper W/O 0 dept",'2021-11-14','Rejected');
INSERT INTO  t5_claim VALUES (2605,2007,25077,2700,3604,"2 Headlight damage",'2022-04-12','Settled');
INSERT INTO  t5_claim VALUES (2606,2004,25044,1132,3606,"Head light damage",'2022-04-11','Settled');
INSERT INTO  t5_claim VALUES (2607,2001,25177,20113,3607,"Car trunk major acc",'2022-03-28','Pending');
INSERT INTO  t5_claim VALUES (2608,2008,25088,4567,3608,"Door paint",'2021-08-03','Settled');
INSERT INTO  t5_claim VALUES (2609,2007,25077,1021,3609,"Front plastic grill",'2022-01-12','Rejected');
INSERT INTO  t5_claim VALUES (2610,2005,25199,1786,3610,"Rear view mirror",'2022-04-12','Settled');
INSERT INTO  t5_claim VALUES (2611,2001,25011,432000,3611,'Theft','2022-03-29','Pending');
INSERT INTO  t5_claim VALUES (2612,2003,25033,42500,3612,"2 Headlight damage",'2021-03-19','Pending');
INSERT INTO  t5_claim VALUES (2613,2009,25099,43000,3613,'Theft','2021-05-02','Pending');

## 8 Claim settlement
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2701, 2601, 2001, 2501, '2026-08-11', 300000, 3801) ;
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2702, 2602, 2002, 2502, '2024-11-16', 190000, 3802) ;
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2703, 2603, 2003, 2503, '2023-04-25', 90000, 3803) ;
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2704, 2604, 2004, 2504, '2019-12-09', 150000, 3804) ;
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2705, 2605, 2005, 2505, '2020-08-26', 450000, 3805) ;
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2706, 2606, 2006, 2506, '2029-11-25', 300000, 3806) ;
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2707, 2607, 2007, 2507, '2023-09-15', 600000, 3807) ;
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2708, 2608, 2008, 2508, '2022-12-11', 140000, 3808) ;
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2709, 2609, 2009, 2509, '2023-06-04', 220000, 3809) ;
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2710, 2610, 2010, 2510, '2018-11-25', 110000, 3810) ;
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2711, 2611, 2011, 2511, '2024-12-01', 25000, 3811) ;
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2712, 2612, 2012, 2512, '2021-08-03', 17000, 3812) ;
INSERT INTO T5_CLAIM_SETTLEMENT  VALUES (2713, 2613, 2013, 2513, '2024-03-14', 21000, 3813) ;

## 15 Insurance company
INSERT INTO t5_insurance_company VALUES ('SBI Life Insurance', '110001, New Delhi', '874135', '259369', 'sbi@outlook.com', 'sbilife.com', '874135', 'New Delhi', 'SBI Life Insurance', 'SBI office');
INSERT INTO t5_insurance_company VALUES ('TATA Life Insurance', '831001, Jamshedpur', '931393', '197563', 'tata@yahoo.co.in', 'tatainsurance.com', '931393', 'Jamshedpur', 'TATA Life Insurance', 'TATA office');
INSERT INTO t5_insurance_company VALUES ('RN Life Insurance', '400001, Mumbai', '856352', '137928', 'reliance@yahoo.com', 'reliancelife.com', '856352', 'Mumbai', 'RN Life Insurance', 'reliance office');
INSERT INTO t5_insurance_company VALUES ('LIC of India', '700001, Kolkata', '799718', '469932', 'lic@gmail.com', 'licindia.com', '799718', 'Kolkata','', 'LIC office');
INSERT INTO t5_insurance_company VALUES ('HDFC Life Insurance', '226001, Lucknow', '959943', '582924', 'hdfc@gmail.com', 'hdfclife.com', '959943', 'Lucknow', 'HDFC Life Insurance', 'HDFC office');
INSERT INTO t5_insurance_company VALUES ('ICICI Life Insurance', '380058, Bopal', '732771', '527273', 'icici@yahoo.in', 'icicilife.com', '732771', 'Bopal', 'ICICI Life Insurance', 'ICICI office');
INSERT INTO t5_insurance_company VALUES ('Kotak Life Insurance', '530068, Bangalore', '820449', '373156', 'kotak@gmail.co.in', 'kotakmahindra.com', '820449', 'Bangalore', 'Kotak Life Insurance', 'Kotak office');
INSERT INTO t5_insurance_company VALUES ('Birla Insurance', '600001, Chennai', '962610', '152937', 'aditya@yahoo.in', 'adityabirla.com', '962610', 'Chennai', 'Birla Life Insurance', 'Birla office');
INSERT INTO t5_insurance_company VALUES ('Exide Life Insurance', '500001, Hyderabad', '722373', '399331', 'exide@gmail.com', 'exidelife.com', '722373', 'Hyderabad', 'Exide Life Insurance', 'Exide office');
INSERT INTO t5_insurance_company VALUES ('Max Life Insurance', '444601, Amaravati', '870032', '312146', 'maxlife@gmail.com', 'maxlife.com', '870032', 'Amaravati', 'Max Life Insurance', 'Max office');
INSERT INTO t5_insurance_company VALUES ('PNB Life Insurance', '140119, Chandigarh', '819986', '664028', 'pnb@outlook.co.in', 'pnblife.com', '819986', 'Chandigarh', 'PNB Life Insurance', 'PNB office');
INSERT INTO t5_insurance_company VALUES ('HSBC Life Insurance', '320008, Ahmedabad', '873848', '721287', 'hsbc@outlook.in', 'hdfclife.com', '873848', 'Ahmedabad', 'HSBC Life Insurance', 'HSBC office');

### 9 Staff
INSERT INTO t5_staff  VALUES ('2801','ICICI Life Insurance','Nikitha','Gandhi','Chennai','789563','F','Single','Indian','Btech','33000','221256');
INSERT INTO t5_staff  VALUES ('2802','HSBC Life Insurance','Tarun','Avula','Chicago','455665','M','Single','Indian','MS',46000,202546);
INSERT INTO t5_staff  VALUES ('2803', 'SBI Life Insurance', 'Jnardhan', 'Reddy', 'Vizag', '159876', 'M', 'Married', 'Indian', 'Btech', '25000', '200201');
INSERT INTO t5_staff  VALUES ('2804', 'TATA Life Insurance', 'Simran', 'Chowdary', 'Hyderabad', '254682', 'F', 'Married', 'Indian', 'Btech', '40000', '200202');
INSERT INTO t5_staff  VALUES ('2805', 'Kotak Life Insurance', 'Harsha', 'Viva', 'Kolkata', '654895', 'M', 'Single', 'Indian', 'Mtech', '45000', '200203');
INSERT INTO t5_staff  VALUES ('2806', 'LIC of India', 'Harnoor', 'Singh', 'Ropar', '846297', 'M', 'Married', 'Indian', 'Btech', '36000', '200204');
INSERT INTO t5_staff  VALUES ('2807', 'RN Life Insurance', 'Naredra', 'Modi', 'Delhi', '731592', 'M', 'Married', 'Indian', 'MBA', '50000', '200205');
INSERT INTO t5_staff  VALUES ('2808', 'ICICI Life Insurance', 'Steph', 'Curry', 'Stapple centre', '556984', 'M', 'Single', 'American', 'MS', '60000', '200206');
INSERT INTO t5_staff  VALUES ('2809', 'Birla Insurance', 'Aditya', 'Birla', 'Lucknow', '124589', 'M', 'Married', 'Indian', 'Btech', '30000', '200207');
INSERT INTO t5_staff  VALUES ('2810', 'PNB Life Insurance', 'Pratik ', 'Agarwal', 'Agra', '648219', 'M', 'Single', 'Indian', 'Btech', '35000', '200208');
INSERT INTO t5_staff  VALUES ('2811', 'HSBC Life Insurance', 'Kevin', 'Durant', 'Broklyn', '324689', 'M', 'Single', 'English', 'MBA', '53500', '200209');
INSERT INTO t5_staff  VALUES ('2812', 'Exide Life Insurance', 'James', 'Harden', 'London', '147896', 'M', 'Married', 'English', 'Btech', '55000', '200210');
INSERT INTO t5_staff  VALUES ('2813', 'SBI Life Insurance', 'Chetan', 'Sharma', 'Mumbai', '187695', 'M', 'Married', 'Indian', 'Mtech', '45000', '200553');
INSERT INTO t5_staff  VALUES ('2814', 'Max Life Insurance', 'Deepak', 'Sujay', 'Dharwad', '548255', 'M', 'Married', 'Indian', 'Btech', '20000', '200225');
INSERT INTO t5_staff  VALUES ('2815', 'HDFC Life Insurance', 'Chris', 'Paul', 'Las Vegas', '874185', 'M', 'Single', 'American', 'MS', '60000', '200289');


### 12 Membership Table
INSERT INTO T5_MEMBERSHIP VALUES (3101,2001,'permanent',913453);
INSERT INTO T5_MEMBERSHIP VALUES (3102,2002,'temporary',819272);
INSERT INTO T5_MEMBERSHIP VALUES (3103,2003,'permanent',980641);
INSERT INTO T5_MEMBERSHIP VALUES (3104,2004,'permanent',781927);
INSERT INTO T5_MEMBERSHIP VALUES (3105,2005,'temporary',981417);
INSERT INTO T5_MEMBERSHIP VALUES (3106,2006,'temporary',905183);
INSERT INTO T5_MEMBERSHIP VALUES (3107,2007,'permanent',692817);
INSERT INTO T5_MEMBERSHIP VALUES (3108,2008,'temporary',298601);
INSERT INTO T5_MEMBERSHIP VALUES (3109,2009,'permanent',786142);
INSERT INTO T5_MEMBERSHIP VALUES (3110,2010,'permanent',990102);
INSERT INTO T5_MEMBERSHIP VALUES (3111,2011,'permanent',898920);
INSERT INTO T5_MEMBERSHIP VALUES (3112,2012,'temporary',881546);
INSERT INTO T5_MEMBERSHIP VALUES (3113,2003,'temporary',908182);
INSERT INTO T5_MEMBERSHIP VALUES (3114,2014,'permanent',818191);
INSERT INTO T5_MEMBERSHIP VALUES (3115,2015,'temporary',778162);
INSERT INTO T5_MEMBERSHIP VALUES (3116,2016,'temporary',646591);

INSERT INTO t5_incident VALUES ('3601','Accident','2021-11-12','Delhi-Seltos and i20 had Bumber to Bumper collision');
INSERT INTO t5_incident VALUES ('3602','Accident','2022-04-01','Chandigarh-EcoSport bumber to bumper collision at Sector-14 traffic signal');
INSERT INTO t5_incident VALUES ('3603','Accident','2022-02-28','Amritsar-BMW X3 collided and its fender was completely damaged with minor scratches on bonnet');
INSERT INTO t5_incident VALUES ('3604','Accident','2022-04-10','Delhi-Customer  parked car was hit from back while person accused was reversing his car');
INSERT INTO t5_incident VALUES ('3605','Accident','2022-04-11','Mohalli-Rear view mirror broke when car was passing by a tight lane');
INSERT INTO t5_incident VALUES ('3606','Accident','2022-04-04','GT Road-Harrier collided head lights damaged');
INSERT INTO t5_incident VALUES ('3607','Accident','2022-03-25','GT Road-Creta hit by truck from back complete trunk damaged');
INSERT INTO t5_incident VALUES ('3608','Accident','2021-07-29','Delhi-Karol Bagh Parked Car door dented by a reversing car');
INSERT INTO t5_incident VALUES ('3609','Accident','2022-01-10','Jalandhar-Minor accident damage to front grill claim rejected');
INSERT INTO t5_incident VALUES ('3610','Accident','2022-04-09','Kanpur-Volvo XC60 Rear view mirror broke due to collision with a cow');
INSERT INTO t5_incident VALUES ('3611','Theft','2022-03-26','Gurugram-Car stole from Sector-16 DK complex parking');
INSERT INTO t5_incident VALUES ('3612','Accident','2021-03-16','Yamuna Expressway-Land Rover Defender collided head lights damaged');
INSERT INTO t5_incident VALUES ('3613','Theft','2021-05-01','Delhi-Activa 5G stolen from Pitampura');


INSERT INTO t5_COVERAGE VALUES (3801,2100,'Damage','1',3901,'Any Damage','Agreed','ICICI Life Insurance');
INSERT INTO t5_COVERAGE VALUES (3802,5677,'Comphr','2',3902,'Only tires','Semi Agreed','HSBC Life Insurance');
INSERT INTO t5_COVERAGE VALUES (3803,456,'Damage','3',3903,'Only steering','Semi Agreed','SBI Life Insurance');
INSERT INTO t5_COVERAGE VALUES (3804,4107,'Comphr','10',3904,'All','Agreed','TATA Life Insurance');
INSERT INTO t5_COVERAGE VALUES (3805,1700,'Damage','4',3905,'Only Bonet','Semi Agreed','Kotak Life Insurance');
INSERT INTO t5_COVERAGE VALUES (3806,989,'Damage','6',3906,'Any Damage','Agreed','LIC of India');
INSERT INTO t5_COVERAGE VALUES (3807,22322,'Comphr','5',3907,'All','Agreed','RN Life Insurance');
INSERT INTO t5_COVERAGE VALUES (3808,5600,'Comphr','1',3908,'Only tires','Semi Agreed','Birla Insurance');
INSERT INTO t5_COVERAGE VALUES (3809,1019,'Damage','10',3909,'Only Wheels','Agreed','PNB Life Insurance');
INSERT INTO t5_COVERAGE VALUES (3810,354,'Comphr','8',3910,'Only tires','Agreed','Exide Life Insurance');
INSERT INTO t5_COVERAGE VALUES (3811,465000,'Damage','2',3911,'Any Damage','Semi Agreed','Max Life Insurance');
INSERT INTO t5_COVERAGE VALUES (3812,98900,'Comphr','7',3912,'All','Agreed','HDFC Life Insurance');
INSERT INTO t5_COVERAGE VALUES (3813,52000,'Damage','9',3913,'Any Damage','Semi Agreed','SBI Life Insurance');

INSERT INTO t5_department VALUES ('Underwriting department','SBI Life Insurance','Pune',6794210413,'Ramu','Mahesh');
INSERT INTO t5_department VALUES ('Sales department','SBI Life Insurance','Kota',1800569411,'Karan','Jackson');
INSERT INTO t5_department VALUES ('Claims and audit department','SBI Life Insurance','Sricity',9472630142,'vivek','Rajeev');
INSERT INTO t5_department VALUES ('Investment department','ICICI Life Insurance','Dharwad',9721631421,'Swathi','Sampoornesh'); 
INSERT INTO t5_department VALUES ('Marketing department','ICICI Life Insurance','Anantapur',6351201614,'Kumari','Rakesh');
INSERT INTO t5_department VALUES ('legal department','ICICI Life Insurance','Kottayam',7143261401,'Ramesh','Saketh');
INSERT INTO t5_department VALUES ('Underwriting department','ICICI Life Insurance','vyurru',7942631206,'Harshad','Mehath');
INSERT INTO t5_department VALUES ('Sales department','HDFC Life Insurance','Srinagar',6305176421,'Rashmi','Raju');
INSERT INTO t5_department VALUES ('Claims and audit department','HDFC Life Insurance','Amaravathi',9762143216,'Renuka','Amarnath');
INSERT INTO t5_department VALUES ('Investment department','HSBC Life Insurance','Ahmedhabad',7216421416,'Ravi','Naresh');
INSERT INTO t5_department VALUES ('Marketing department','PNB Life Insurance','Raichur',6341261431,'Harsha','Neethu');
INSERT INTO t5_department VALUES ('legal department','Exide Life Insurance','Hyderabad',7421461216,'Ranjeeth','Likith');
INSERT INTO t5_department VALUES ('Underwriting department','Birla Insurance','Durgapur',9417216304,'Mahalakshmi','Ravi');
INSERT INTO t5_department VALUES ('Claims and audit department','Max Life Insurance','Vaddodhara',6351421673,'Kriti','Karan');
INSERT INTO t5_department VALUES ('Investment department','Kotak Life Insurance','Ghandhinagar',1470421638,'Rahul','Lavanya');
INSERT INTO t5_department VALUES ('Marketing department','RN Life Insurance','Kammam',7321463142,'Giridhar','Tarun');
INSERT INTO t5_department VALUES ('legal department','LIC of India','Kanchipuram',9741620162,'Pooja','Sriram');
INSERT INTO t5_department VALUES ('Sales department','TATA Life Insurance','Jaipur',8794216372,'Rupesh','Kushal');
INSERT INTO t5_department VALUES ('Claims and audit department','ICICI Life Insurance','Delhi',7466928464,'Vani','Kalyan');
INSERT INTO t5_department VALUES ('Sales department','TATA Life Insurance','Hubli',9873253763,'Hanesh','Manoj');
INSERT INTO t5_department VALUES ('Claims and audit department','SBI Life Insurance','Nellore',7654516364,'Varun','Pranathi');
INSERT INTO t5_department VALUES ('Investment department','HSBC Life Insurance','Ameerpet',9764567635,'Ravikant','Mahesh');
INSERT INTO t5_department VALUES ('Marketing department','RN Life Insurance','Mumbai',8754262644,'Manohar','Karhikeya');
INSERT INTO t5_department VALUES ('legal department','ICICI Life Insurance','Madhapur',7143265462,'Lokesh','Ganesh');

INSERT INTO t5_OFFICE VALUES ('Kota', 'Sales department','SBI Life Insurance','Tarun',7262345612,'Gumanpura kota-3244007', 90000, 'Rajesh');
INSERT INTO t5_OFFICE VALUES ('Dharwad', 'Investment department','ICICI Life Insurance','Lokesh',8124356471,'PB,No-9,college road,malmaddi', 120000, 'Anil');
INSERT INTO t5_OFFICE VALUES ('Ananthapur', 'Marketing department','ICICI Life Insurance','Rohan',6737562654,'flat num: 1204/9, HB colony', 100000, 'Karthik');
INSERT INTO t5_OFFICE VALUES ('vyurru','Underwriting department','ICICI Life Insurance','Aryan',8764563549,'KATURU ROAD ,GANNAVARAM',74000,'Bushan');
INSERT INTO t5_OFFICE VALUES ('Ahmedhabad','Investment department','HSBC Life Insurance','Ganesh',8765423476,'C N Vidyalaya Compound, Ambawadi',85000,'Bhuvan');
INSERT INTO t5_OFFICE VALUES ('Ghandhinagar','Investment department','Kotak Life Insurance','Skandan',7653487346,' KUDALANNAVAR COMPLEX',66000,'Srinivas');
INSERT INTO t5_OFFICE VALUES ('Ameerpet','Investment department','HSBC Life Insurance','Ramu',9492635492,'NO.7-1-613, TARUN TOWERS',95000,'Phani');
INSERT INTO t5_OFFICE VALUES ('Durgapur', 'Underwriting department','Birla Insurance','skandan',9120384657,'Trunck road,Satyaveda Mandal,517588', 122000, 'Yash');
INSERT INTO t5_OFFICE VALUES ('Sri city', 'Claims and audit department','SBI Life Insurance','kiran',6723901356,'Regional bussiness office,Thiruvunanthapuram', 110000, 'Tarun');
INSERT INTO t5_OFFICE VALUES ('Nellore',  'Claims and audit department','SBI Life Insurance','Abinav',8736353471,'PB,No-9,college road,malmaddi', 90000, 'Tejesh');
INSERT INTO t5_OFFICE VALUES ('Kottayam','legal department','ICICI Life Insurance','umesh',6677223344,'K K Road,Polachirackal Chambers-686002', 80000, 'Deepak');
INSERT INTO t5_OFFICE VALUES ('Madhapur','legal department','ICICI Life Insurance','Uma',6635223344,'NGO Colony near temple', 89000, 'Deepika');
INSERT INTO t5_OFFICE VALUES ('Raichur', 'Marketing department','PNB Life Insurance','Mahesh',9988776655,'Gunji road-584101', 99000, 'Yaswanth');
INSERT INTO t5_OFFICE VALUES ('Vaddodhara', 'Claims and audit department','Max Life Insurance','Anupama',9577308494,'opposite Aradhana Cinema-390001', 2000, 'Prakash');
INSERT INTO t5_OFFICE VALUES ('Hubli', 'Sales department','TATA Life Insurance','Anuhya',9994488822,'UMACHAGI COMPLEX KOPPIKAR ROAD 580020', 60000, 'Harsha');
INSERT INTO t5_OFFICE VALUES ('Jaipur', 'Sales department','TATA Life Insurance','Annanya',7777488822,'1st Floor Tilak Marg,Udyog Bhawan302005', 75000, 'Harshitha');
INSERT INTO t5_OFFICE VALUES ('Hyderabad', 'legal department','Exide Life Insurance','Abhiram',8882233445,'Sultan Bazar-500095', 70000, 'Aryan');
INSERT INTO t5_OFFICE VALUES ('Mumbai', 'Marketing department','RN Life Insurance','Ramesh',9900887766,'SAMACHAR MARG 400001', 30330, 'Swathi');
INSERT INTO t5_OFFICE VALUES ('Kammam', 'Marketing department','RN Life Insurance','Rahul',8764263761,'WARD NO.7 DR.NO.5-1-19/1, Wyra Rd', 65000, 'Swetha');
INSERT INTO t5_OFFICE VALUES ('Amaravathi', 'Claims and audit department','HDFC Life Insurance','roshan',8880002233,'Cotton Market, opposite sbi', 66000, 'Raj');
INSERT INTO t5_OFFICE VALUES ('Srinagar', 'Sales department','HDFC Life Insurance','Spandana',9807653425,'Nishat Brein Link Rd', 99000, 'Vivek');
INSERT INTO t5_OFFICE VALUES ('Kanchipuram', 'legal department','LIC of India','Hailee',8720937614,'Annai Indira Gandhi Salai', 78000, 'Ramya');
INSERT INTO t5_OFFICE VALUES ('Pune', 'Underwriting department','SBI Life Insurance','Aravind',8753728352,'Kamayani Towers Plot No 547', 67000, 'Rithvik');
INSERT INTO t5_OFFICE VALUES ('Delhi', 'Claims and audit department','Max Life Insurance','Rakesh',7639876451,'N. D. MAIN BRANCH, 11, Sansad Marg', 90999, 'Patel');

INSERT INTO t5_PRODUCT VALUES (3902,34000,'Motor','HSBC Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3903,67191,'Car','SBI Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3904,791280,'Car','TATA Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3905,18912,'Motor','Kotak Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3906,82837,'Motor','LIC of India');
INSERT INTO t5_PRODUCT VALUES (3907,73101,'Car','RN Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3908,389111,'Motor','Birla Insurance');
INSERT INTO t5_PRODUCT VALUES (3909,389101,'Motor','PNB Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3910,38191,'Car','Exide Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3911,37181,'Car','Max Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3912,37811,'Motor','HDFC Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3913,381802,'Car','SBI Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3914,38912,'Motor','ICICI Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3915,380191,'Motor','SBI Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3916,90181,'Car','ICICI Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3917,80179,'Car','ICICI Life Insurance');
INSERT INTO t5_PRODUCT VALUES (3918,319019,'Motor','SBI Life Insurance');

INSERT INTO t5_incident_report VALUES ('3701','3601','2013','Harnoor Singh','3105','Accident','i20 is insured without 0 debt hence claim is rejected as in case of bumber-bumper cdamage ');
INSERT INTO t5_incident_report VALUES ('3702','3602','2001','James Harden','3235','Accident','');
INSERT INTO t5_incident_report VALUES ('3703','3603','2005','Chris Paul','6722','Accident','');
INSERT INTO t5_incident_report VALUES ('3704','3604','2007','Reddy Vizag','2700','Accident','Parked car hit from back, claim settled');
INSERT INTO t5_incident_report VALUES ('3705','3605','2011','Deepak Sujay','357','Accident','Rear view mirror broke when car was passing by a tight lane ');
INSERT INTO t5_incident_report VALUES ('3706','3606','2004','Harnoor Singh','1132','Accident','Car collided, claim settled after scrutinizing extent of damage');
INSERT INTO t5_incident_report VALUES ('3707','3607','2001','Nikitha Gandhi','20113','Accident','');
INSERT INTO t5_incident_report VALUES ('3708','3608','2008','Pratik Agarwal','4567','Accident','Claim settled after receiving basic charges from customer as in case of 5 years old car');
INSERT INTO t5_incident_report VALUES ('3709','3609','2016','Nikitha Gandhi','1021','Accident','Plastic grill damaged, claim rejected as plastic damage is not insured');
INSERT INTO t5_incident_report VALUES('3710','3610','2005','Narendra Modi','1786','Accident','Collision with a cow and rear view damaged, claim approved after getting CCTV footage');
INSERT INTO t5_incident_report VALUES('3711','3611','2001','Simran Chowdary','432000','Theft','');
INSERT INTO t5_incident_report VALUES('3712','3612','2016','Steph Curry','43500','Accident','');
INSERT INTO t5_incident_report VALUES('3713','3613','2009','Jnardhan Reddy','43000','Theft','');

insert into t5_nok 
values
('3301','2301','2101','2001','Shubham','Pennsylvania',245698,'Married','M'),
('3302','2302','2102','2002','Hardik','Brooklyn',342413,'Unmarried','M') ,
('3303','2303','2103','2003','Claire','Cleveland',109645,'Married','F'),
('3304','2304','2104','2004','Akanksha','London',347234,'Married','F'),
('3305','2305','2105','2005','Saif','Delhi',123456,'Unmarried','M'),
('3306','2306','2106','2006','Rini','Vijayawada',234567,'Married','F'),
('3307','2307','2107','2007','Kareena','Stapple centre',758595,'Married','F'),
('3308','2308','2108','2008','Prapti','Mumbai',956545,'Unmarried','F'),
('3309','2309','2109','2009','Anmol','Amritsar',264534,'Unmarried','M'),
('3310','2310','2110','2010','Harshit','Kolkata',345243,'Unmarried','M'),
('3311','2311','2111','2011','Rahul','Banglore',123459,'Unmarried','M'),
('3312','2312','2112','2012','Kiara','Mumbai',987654,'Married','F'),
('3313','2313','2113','2013','Twinkle','Chennai',999424,'Married','F'),
('3314','2314','2114','2014','Tara','Las vegas',999909,'Married','F'),
('3315','2315','2115','2015','Akshay','Hyderabad',789895,'Unmarried','M');

insert into t5_receipt
values
('4001',2435,'2021-12-11',2401,2001),
('4002',1254,'2021-12-11',2402,2002),
('4003',4990,'2021-12-11',2403,2003),
('4004',12345,'2021-12-11',2404,2004),
('4006',3345,'2021-12-11',2406,2006),
('4007',2345,'2021-12-11',2407,2007),
('4008',2423,'2021-12-11',2408,2008),
('4009',5788,'2021-12-11',2409,2009),
('4010',6799,'2021-12-11',2410,2010),
('4011',3978,'2021-08-03',2411,2011),
('4012',19245,'2021-07-04',2412,2012),
('4013',2345,'2022-03-03',2413,2013),
('4014',12000,'2022-02-05',2414,2014),
('4015',2567,'2022-01-06',2415,2015),
('4017',2567,'2022-04-12',2417,2002),
('4018',2567,'2022-03-16',2418,2005);

END // 
########################################################################################################

########################################### OTHER HELPING PROCEDURES ###################################################

delimiter $$
create function sum_of_id (a int , b int, c int, d int)
returns int
reads sql data
deterministic
begin
	declare sumofids int;
    set sumofids = a+b+c+d;
    return (sumofids);
    
end$$ 

delimiter $$
create function return_coverage_amount (a int)
returns int
reads sql data
deterministic
begin
	declare coverage_amount int;
    set coverage_amount = (select t5_coverage_amount from t5_coverage where T5_COVERAGE_ID = a);
    return (coverage_amount);
    
end$$ 

delimiter $$
create function return_claim_amount (a int)
returns int
reads sql data
deterministic
begin
	declare claim_amount int;
    set claim_amount = (select t5_claim_amount from t5_claim where T5_CLAIM_ID = a);
    return (claim_amount);
    
end$$ 

delimiter $$
create function return_premium_amount (a int)
returns int
reads sql data
deterministic
begin
	declare premium_amount int;
    set premium_amount = (select t5_premium_payment_amount from t5_premium_payment where T5_POLICY_ID = a);
    return (premium_amount);
    
end$$ 

###############################################################################################################

########################################### COMMANDS ###################################################
CALL CREATE_ONLINE_XYZ_INSURANCES_DATABASE_ENTITES ();
CALL INSERT_DATASET ();
-- DROP PROCEDURE INSERT_DATASET;

-- CALL DELETE_ALL_TABLES () ;
###############################################################################################################
