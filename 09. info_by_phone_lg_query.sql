--Info by phone

/* SELECT calls_ivr_id, step_name,
  CASE
    WHEN step_name = 'CUSTOMERINFOBYPHONE.TX'AND UPPER(step_result) = 'OK' THEN 1 ELSE 0
  END AS info_by_phone_lg
FROM (
    SELECT calls_ivr_id, step_name,step_result,
           ROW_NUMBER() OVER (PARTITION BY (CAST (calls_ivr_id AS int64)) ORDER BY calls_ivr_id DESC) AS row_num
    FROM `keepcoding.ivr_detail`
) AS ranked_table
WHERE row_num = 1; */

SELECT calls_ivr_id, step_name,
  CASE
    WHEN step_name = 'CUSTOMERINFOBYPHONE.TX' AND UPPER(step_result) = 'OK' THEN 1 ELSE 0
  END AS info_by_phone_lg
FROM `keepcoding.ivr_detail`;