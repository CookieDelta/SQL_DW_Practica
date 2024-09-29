CREATE OR REPLACE TABLE `keepcoding.ivr_summary` AS

WITH 

vdn_aggregation_data AS (
    SELECT calls_ivr_id,calls_vdn_label,
        CASE
            WHEN calls_vdn_label LIKE 'ATC%' THEN 'FRONT'
            WHEN calls_vdn_label LIKE 'TECH%' THEN 'TECH'
            WHEN calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
            ELSE 'RESTO'
            END AS vdn_aggregation
    FROM `keepcoding.ivr_detail`
),

document_type_id AS (
    SELECT calls_ivr_id, document_identification, document_type
    FROM `keepcoding.ivr_detail`
    QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS int) ORDER BY calls_ivr_id DESC) = 1
),

customer_phone_data AS (
    SELECT calls_ivr_id, step_customer_phone 
    FROM `keepcoding.ivr_detail`
    QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS int) ORDER BY calls_ivr_id, NULLIF(step_customer_phone, 'UNKNOWN') DESC) = 1
    ORDER BY calls_ivr_id, step_customer_phone DESC 
),

billing_account_id_data AS (
    SELECT calls_ivr_id, billing_account_id
    FROM `keepcoding.ivr_detail`
    QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS int) ORDER BY calls_ivr_id DESC) = 1
),

masiva_lg_data AS (
    SELECT calls_ivr_id, 
        CASE
            WHEN module_name = 'AVERIA_MASIVA' THEN 1 ELSE 0
        END AS masiva_lg
    FROM (
        SELECT calls_ivr_id, module_name,
               ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS int64) ORDER BY calls_ivr_id DESC) AS row_num
        FROM `keepcoding.ivr_detail`
    ) AS ranked_table
    WHERE row_num = 1  
),

info_by_phone_lg_data AS (
    SELECT calls_ivr_id, 
        CASE
            WHEN step_name = 'CUSTOMERINFOBYPHONE.TX' AND UPPER(step_result) = 'OK' THEN 1 ELSE 0
        END AS info_by_phone_lg
    FROM `keepcoding.ivr_detail`
),

info_by_dni_lg_data AS (
  SELECT 
    det.calls_ivr_id,
    COUNT(CASE 
      WHEN 
      UPPER(det.step_name) = 'CUSTOMERINFOBYDNI.TX' AND 
      UPPER(det.step_result) = 'OK' 
      THEN 1 END) AS info_by_dni_lg
  FROM `keepcoding.ivr_detail` AS det
  LEFT JOIN `keepcoding.ivr_calls` AS cal
    ON det.calls_ivr_id = cal.ivr_id
  GROUP BY det.calls_ivr_id
  ORDER BY info_by_dni_lg
),

repeated_phone AS (
    --repeated_phone_24hrs, cause_recall_phone_24hrs

WITH info_24hrs_calls AS
(
SELECT calls_ivr_id, calls_phone_number, calls_start_date,
--previous call
LAG(calls_start_date) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date) AS previous_date,
--next    
LEAD(calls_start_date) OVER (PARTITION BY calls_phone_number ORDER BY calls_start_date) AS next_date
FROM `keepcoding.ivr_detail`
--take out unkown
WHERE calls_phone_number != 'UNKNOWN'
GROUP BY calls_ivr_id, calls_phone_number, calls_start_date
)

--Now, we work with the filtered table
SELECT 
    calls_ivr_id,
--called previously?
    CASE 
        WHEN previous_date IS NOT NULL AND DATETIME_DIFF(calls_start_date, previous_date, HOUR) <= 24 
        THEN 1 ELSE 0 
    END AS previous_call_within_24hrs,
--called after 24hrs?
    CASE 
        WHEN next_date IS NOT NULL AND DATETIME_DIFF(next_date, calls_start_date, HOUR) <= 24 
        THEN 1 ELSE 0 
    END AS next_call_within_24hrs
FROM info_24hrs_calls
)

SELECT
    ivr_detail.calls_ivr_id AS ivr_id,
    ivr_detail.calls_phone_number AS phone_number,
    ivr_detail.calls_ivr_result AS ivr_result,
    vdn_aggregation_data.vdn_aggregation AS vdn_aggregation,
    ivr_detail.calls_start_date AS `start_date`,
    ivr_detail.calls_end_date AS end_date,
    ivr_detail.calls_total_duration AS total_duration,
    ivr_detail.calls_customer_segment AS customer_segment,
    ivr_detail.calls_ivr_language AS ivr_language,
    ivr_detail.calls_steps_module AS steps_module,
    ivr_detail.calls_module_aggregation AS module_aggregation,
    document_type_id.document_type AS document_type,
    document_type_id.document_identification AS document_identification,
    customer_phone_data.step_customer_phone AS customer_phone,
    billing_account_id_data.billing_account_id AS billing_account_id,
    masiva_lg_data.masiva_lg AS masiva_lg,
    info_by_phone_lg_data.info_by_phone_lg AS info_by_phone_lg,
    info_by_dni_lg_data.info_by_dni_lg AS info_by_dni_lg,
    repeated_phone.previous_call_within_24hrs AS previous_call_within_24hrs,
    repeated_phone.next_call_within_24hrs AS next_call_within_24hrs




FROM `keepcoding.ivr_detail` AS ivr_detail

LEFT JOIN vdn_aggregation_data ON ivr_detail.calls_ivr_id = vdn_aggregation_data.calls_ivr_id
LEFT JOIN document_type_id ON ivr_detail.calls_ivr_id = document_type_id.calls_ivr_id
LEFT JOIN customer_phone_data ON ivr_detail.calls_ivr_id = customer_phone_data.calls_ivr_id
LEFT JOIN billing_account_id_data ON ivr_detail.calls_ivr_id = billing_account_id_data.calls_ivr_id
LEFT JOIN masiva_lg_data ON ivr_detail.calls_ivr_id = masiva_lg_data.calls_ivr_id
LEFT JOIN info_by_phone_lg_data ON ivr_detail.calls_ivr_id = info_by_phone_lg_data.calls_ivr_id
LEFT JOIN info_by_dni_lg_data ON ivr_detail.calls_ivr_id = info_by_dni_lg_data.calls_ivr_id
LEFT JOIN repeated_phone ON ivr_detail.calls_ivr_id = repeated_phone.calls_ivr_id


GROUP BY 
    ivr_detail.calls_ivr_id,
    ivr_detail.calls_phone_number,
    ivr_detail.calls_ivr_result,
    vdn_aggregation_data.vdn_aggregation,
    ivr_detail.calls_start_date,
    ivr_detail.calls_end_date, 
    ivr_detail.calls_total_duration,
    ivr_detail.calls_customer_segment,
    ivr_detail.calls_ivr_language,
    ivr_detail.calls_steps_module,
    ivr_detail.calls_module_aggregation,
    document_type_id.document_type,
    document_type_id.document_identification,
    customer_phone_data.step_customer_phone,
    billing_account_id_data.billing_account_id,
    masiva_lg_data.masiva_lg,
    info_by_phone_lg_data.info_by_phone_lg,
    info_by_dni_lg_data.info_by_dni_lg,
    repeated_phone.previous_call_within_24hrs,
    repeated_phone.next_call_within_24hrs

ORDER BY ivr_detail.calls_ivr_id;
