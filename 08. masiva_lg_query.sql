--CREATE TABLE `keepcoding.customer_phone` AS

/* SELECT calls_ivr_id,document_type,document_identification,module_name
FROM `keepcoding.ivr_detail`
QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS int) ORDER BY calls_ivr_id DESC) = 1;*/

/*SELECT 
  calls_ivr_id,
  MAX(CASE WHEN module_name = 'AVERIA_MASIVA' THEN 1 ELSE 0 END) AS masiva_lg
FROM 
  keepcoding.ivr_detail

SELECT calls_ivr_id, document_type, document_identification, module_name

  IF module_name = 'AVERIA_MASIVA'
  (
  SELECT calls_ivr_id, document_type, document_identification,module_name,
  ROW_NUMBER() OVER (PARTITION BY (CAST(calls_ivr_id AS int64)) ORDER BY calls_ivr_id DESC) AS organized
  FROM `keepcoding.ivr_detail`
  WHERE module_name = 'AVERIA_MASIVA'
  ) 
WHERE organized = 1 */

SELECT calls_ivr_id, document_type, document_identification, module_name,
  CASE
    WHEN module_name = 'AVERIA_MASIVA' THEN 1 ELSE 0
  END AS masiva_lg
FROM (
    SELECT calls_ivr_id, document_type, document_identification, module_name,
           ROW_NUMBER() OVER (PARTITION BY (CAST (calls_ivr_id AS int64)) ORDER BY calls_ivr_id DESC) AS row_num
    FROM `keepcoding.ivr_detail`
) AS ranked_table
WHERE row_num = 1;
