select * from projects;

# CALENDER TABLE

    CREATE TABLE Calender AS
SELECT 
    YEAR(FROM_UNIXTIME(created_at)) AS Year,
    
    MONTH(FROM_UNIXTIME(created_at)) AS Monthno,
    
    MONTHNAME(FROM_UNIXTIME(created_at)) AS Monthfullname,
    
    CONCAT('Q', QUARTER(FROM_UNIXTIME(created_at))) AS Quarter,
    
    DATE_FORMAT(FROM_UNIXTIME(created_at), '%Y-%b') AS YearMonth,
    
    WEEKDAY(FROM_UNIXTIME(created_at)) AS Weekdayno,
    
    DAYNAME(FROM_UNIXTIME(created_at)) AS Weekdayname,
    CASE 
        WHEN MONTH(FROM_UNIXTIME(created_at)) IN (4,5,6,7,8,9,10,11,12) THEN CONCAT('FM', MONTH(FROM_UNIXTIME(created_at)) - 3)
        ELSE CONCAT('FM', MONTH(FROM_UNIXTIME(created_at)) + 9)
    END AS H_FinancialMonth,
    CASE 
        WHEN MONTH(FROM_UNIXTIME(created_at)) IN (1,2,3) THEN CONCAT('FQ', QUARTER(FROM_UNIXTIME(created_at)) + 3)
        ELSE CONCAT('FQ', QUARTER(FROM_UNIXTIME(created_at)))
    END AS I_FinancialQuarter
FROM 
    projects;
    
    select * from calender;

