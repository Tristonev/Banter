-- How many posts are made daily by users?

SELECT DATE(created_at) AS post_date, COUNT(*) AS total_posts
FROM posts
GROUP BY post_date
ORDER BY post_date DESC;
