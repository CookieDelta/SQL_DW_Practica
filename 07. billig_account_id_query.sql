--CREATE TABLE `keepcoding.billing_account_id` AS

SELECT calls_ivr_id,document_type,document_identification,billing_account_id
FROM `keepcoding.ivr_detail`
QUALIFY ROW_NUMBER() OVER (PARTITION BY CAST(calls_ivr_id AS int) ORDER BY calls_ivr_id DESC) = 1;