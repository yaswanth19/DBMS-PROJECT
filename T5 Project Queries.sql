use ONLINE_XYS_INSURANCE_DATABASE;
########################################### QUERIES ###########################################################

-- Query 1
select * from t5_customer as c, t5_vehicle as v 
where c.t5_cust_id=v.t5_cust_id and v.t5_policy_id in 
( SELECT t5_agreement_id  FROM T5_CLAIM  WHERE T5_Claim_status='Pending');


-- Query 2
select * from t5_customer c 
where c.T5_CUST_ID in 
(select a.T5_CUST_ID from t5_customer a 
inner join t5_premium_payment b on a.T5_CUST_ID = b.T5_CUST_ID 
where b.T5_PREMIUM_PAYMENT_AMOUNT > (select sum(t5_cust_id) from t5_customer));



##Query 3
select * from t5_insurance_company where 
(select count(*) from t5_product 
where t5_product.t5_company_name = t5_insurance_company.t5_company_name) 
>
(select count(*) from (select count(*) from t5_office 
where t5_office.t5_company_name=t5_insurance_company.t5_company_name 
group by t5_office.t5_department_name
having count(*) > 1) as Sec);


-- Query 4
select * from t5_customer 
where t5_cust_id in(
	select t5_cust_id from t5_incident_report
	where t5_incident_id in(
		select t5_incident_id from t5_claim
		where t5_agreement_id in(
			select t5_policy_id from t5_premium_payment
			where t5_policy_id in (
				select t5_policy_id from t5_vehicle 
				where t5_cust_id in
				(select t5_cust_id from t5_vehicle
					group by T5_CUST_ID 
					having count(t5_cust_id)>1)
 and T5_RECEIPT_ID is null)) and T5_INCIDENT_TYPE = 'Accident'));
 
-- Query 5 
select * from t5_vehicle 
where t5_vehicle_id in 
(select c.t5_vehicle_id from 
(select t5_vehicle_id, t5_vehicle_number, return_premium_amount(t5_policy_id) as b 
from t5_vehicle a)c 
where (c.b > c.t5_vehicle_number));


-- Query 6
select * from t5_customer 
where t5_cust_id in (select d.t5_cust_id from (select t5_cust_id, 
return_claim_amount(t5_claim_id) as a, 
return_coverage_amount(t5_coverage_id)as b, 
sum_of_id(t5_CLAIM_SETTLEMENT_ID, t5_VEHICLE_ID, t5_CLAIM_ID, t5_CUST_ID)as c 
from t5_claim_settlement)d where (d.a < d.b and d.a > d.c));



#################################################################################################################

