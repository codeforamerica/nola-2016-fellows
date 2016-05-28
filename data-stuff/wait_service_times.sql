-- create table with average wait and service times by day & by hour
CREATE TEMP TABLE average_times AS
SELECT gd_hour_of_day(arrived) AS visit_hr, 
       gd_day_of_week(date_in) AS visit_day, 
       ROUND(AVG(wait_time)) AS avg_wait, 
       ROUND(AVG(service_time)) AS avg_service
FROM visits
WHERE service_time != 0
GROUP BY ROLLUP(visit_hr, visit_day)
ORDER BY visit_day, visit_hr;

SELECT * FROM average_times;

-- 'buckets' the wait times to see where to look for recommended times
SELECT width_bucket(avg_wait::integer, ARRAY[10, 15, 30, 60]), count(*), min(avg_wait), max(avg_wait)
FROM average_times
WHERE visit_day IS NOT NULL
GROUP BY 1
ORDER BY 1;

-- shows hour & day that have low wait times + the average wait at that time
SELECT * FROM average_times
WHERE avg_wait <= 15 
	AND visit_day IS NOT NULL;
