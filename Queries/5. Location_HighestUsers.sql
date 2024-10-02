-- What locations have the highest number of registered users?

SELECT location, COUNT(user_id) AS total_users
FROM users
GROUP BY location
ORDER BY total_users DESC;
