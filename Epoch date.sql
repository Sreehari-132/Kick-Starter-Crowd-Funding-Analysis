-- # EPOCH DATE TO HUMAN READABLE DATE

SELECT DATE(FROM_UNIXTIME(created_at)) AS Created_at
FROM projects;

SELECT DATE(FROM_UNIXTIME(deadline)) AS Deadline_at
FROM projects;

SELECT DATE(FROM_UNIXTIME(updated_at)) AS Updated_at
FROM projects;

SELECT DATE(FROM_UNIXTIME(state_changed_at)) AS state_changed_at
FROM projects;

SELECT DATE(FROM_UNIXTIME(successful_at)) AS Successful_at
FROM projects;

SELECT DATE(FROM_UNIXTIME(launched_at)) AS Launched_at
FROM projects;