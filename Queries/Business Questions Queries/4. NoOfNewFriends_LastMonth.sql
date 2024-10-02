-- How many users have added new friends in the past month?
SELECT COUNT(DISTINCT user_id) AS new_friendships
FROM friendships
WHERE request_status = 'accepted'
AND created_at > NOW() - INTERVAL 1 MONTH;
