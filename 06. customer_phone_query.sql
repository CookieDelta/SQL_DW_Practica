--CREATE TABLE `keepcoding.customer_phone` AS

SELECT calls_ivr_id, step_customer_phone 
FROM `keepcoding.ivr_detail`
QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS int) ORDER BY calls_ivr_id, NULLIF(step_customer_phone, 'UNKNOWN') DESC) = 1
ORDER BY calls_ivr_id, step_customer_phone DESC