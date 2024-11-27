-- 7. Monthly Report percentage related to posts and users
-- Step 1: Count total reports per month
SELECT 
    DATE_FORMAT(report_date, '%Y-%m') AS report_month,
    COUNT(report_id) AS total_reports,
    
    -- Step 2: Count post-related reports per month
    COUNT(reported_post_id) AS post_reports,
    
    -- Step 3: Count user-related reports per month
    COUNT(reported_user_id) AS user_reports,
    
    -- Step 4: Calculate percentage of post-related reports
    ROUND((COUNT(reported_post_id) / COUNT(report_id)) * 100, 2) AS post_report_percentage,
    
    -- Step 5: Calculate percentage of user-related reports
    ROUND((COUNT(reported_user_id) / COUNT(report_id)) * 100, 2) AS user_report_percentage

FROM reported
GROUP BY report_month
ORDER BY report_month DESC;
