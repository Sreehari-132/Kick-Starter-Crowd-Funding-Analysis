select * from projects;

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

-- # Convert the Goal amount into USD using the Static USD Rate
SELECT  goal * static_usd_rate AS Goal_amount_usd
FROM projects;

 -- #   Total Number of Projects based on outcome  
    SELECT state, COUNT(*) AS project_count
FROM projects
GROUP BY state;

-- #Total Number of Projects based on Locations
SELECT l.name as Location, COUNT(p.ProjectID) AS project_count
FROM projects p
INNER JOIN location l ON p.location_id = l.location_id
GROUP BY l.name;

-- #Total Number of Projects based on  Category
SELECT c.name as Category, COUNT(p.ProjectID) AS project_count
FROM projects p
INNER JOIN category c ON p.category_id = c.category_id
GROUP BY c.name;

-- #Total Number of Projects created by Year , Quarter , Month
SELECT 
    YEAR(FROM_UNIXTIME(created_at)) AS Year,
    QUARTER(FROM_UNIXTIME(created_at)) AS Quarter,
    MONTH(FROM_UNIXTIME(created_at)) AS Month,
    COUNT(*) AS TotalProjects
FROM 
    projects
GROUP BY 
    YEAR(FROM_UNIXTIME(created_at)),
    QUARTER(FROM_UNIXTIME(created_at)),
    MONTH(FROM_UNIXTIME(created_at))
ORDER BY 
    Year, Quarter, Month;

-- #  Successful Projects Amount Raised 
SELECT SUM(usd_pledged) AS total_amount_raised
FROM projects
WHERE state = 'Successful';

-- #successful projects number of backers
SELECT COUNT(backers_count) AS successful_backers_count
FROM projects
WHERE state = 'Successful';

-- #Avg number of days for successful projects
SELECT 
    AVG(DATEDIFF(FROM_UNIXTIME(created_at), FROM_UNIXTIME(successful_at))) AS avg_duration_days
FROM 
    projects
WHERE 
    state = 'Successful';
    
-- # Top 10 successful Projects based on number of backers
SELECT name,backers_count
FROM projects WHERE state = 'Successful'
ORDER BY backers_count DESC
LIMIT 10;


-- # Top 10 successful Projects based on Amount raised
SELECT name,usd_pledged
FROM projects WHERE state = 'Successful'
ORDER BY usd_pledged DESC
LIMIT 10;

-- #Percentage of Successful Projects overall
SELECT 
    (COUNT(CASE WHEN state= 'Successful' THEN 1 END) / COUNT(*)) * 100 AS success_percentage
FROM projects;
    
-- #Percentage of Successful Projects  by Category
SELECT c.name,
    (COUNT(CASE WHEN p.state = 'Successful' THEN 1 END) / COUNT(*)) * 100 AS success_percentage
FROM projects p
INNER JOIN category c ON p.category_id = c.category_id
GROUP BY c.name;

-- #Percentage of Successful Projects by Year , Month
SELECT 
    YEAR(FROM_UNIXTIME(created_at)) AS Year,
    QUARTER(FROM_UNIXTIME(created_at)) AS Quarter,
    MONTH(FROM_UNIXTIME(created_at)) AS Month,
    (COUNT(CASE WHEN state = 'Successful' THEN 1 END) / COUNT(*)) * 100 AS success_percentage
FROM 
    projects
GROUP BY 
    Year, Quarter, Month
ORDER BY 
    Year, Quarter, Month;
    
#Percentage of Successful projects by Goal Range 
SELECT 
    goal,
    (SUM(CASE WHEN state = 'Successful' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS success_percentage
FROM (
	SELECT
        CASE 
            WHEN goal <= 5000 THEN '0 to 5000'
            WHEN goal > 5000 AND goal <= 10000 THEN '5001 to 10000'
            WHEN goal > 10000 AND goal <= 25000 THEN '10001 to 25000'
            ELSE 'Over 25000'
        END AS goal,
	 state FROM projects ) AS goal
GROUP BY goal
ORDER BY FIELD(goal, '0 to 5000', '5001 to 10000', '10001 to 25000', 'Over 25000');


