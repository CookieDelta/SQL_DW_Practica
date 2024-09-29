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
FROM info_24hrs_calls;
