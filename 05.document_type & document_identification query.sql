--CREATE TABLE `keepcoding.client_identification` AS

/*SELECT calls_ivr_id, document_type, document_identification FROM

  (
  SELECT calls_ivr_id, document_type, document_identification,

  ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS int) ORDER BY calls_ivr_id DESC) AS organized
  FROM `keepcoding.ivr_detail`
  ) 
WHERE organized = 1 */

SELECT calls_ivr_id, document_identification, document_type
FROM `keepcoding.ivr_detail`
QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS int) ORDER BY calls_ivr_id DESC) = 1;