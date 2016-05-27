SELECT gd_hour_of_day(arrived) AS visit_hr, 
       gd_day_of_week(date_in) AS visit_day, 
       ROUND(AVG(wait_time)) AS avg_wait, 
       ROUND(AVG(service_time)) AS avg_service
FROM visits
WHERE service_time != 0
GROUP BY ROLLUP(visit_hr, visit_day)
ORDER BY visit_day, visit_hr;