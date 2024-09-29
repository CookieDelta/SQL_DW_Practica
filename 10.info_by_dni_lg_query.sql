--Info_by_dni_lg
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
ORDER BY info_by_dni_lg;