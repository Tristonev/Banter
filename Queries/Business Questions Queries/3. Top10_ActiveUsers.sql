-- 3. Who are the top 10 most active users based on posts or interactions (based on likes/comments)?
SELECT u.username, 
    COUNT(DISTINCT p.post_id) AS total_posts, 
    COUNT(DISTINCT l.like_id) AS total_likes_given, 
    COUNT(DISTINCT c.comment_id) AS total_comments_given,
    (COUNT(DISTINCT p.post_id) + COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id)) AS total_interactions
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
LEFT JOIN likes l ON u.user_id = l.user_id
LEFT JOIN comments c ON u.user_id = c.user_id
GROUP BY u.user_id
ORDER BY total_interactions DESC
LIMIT 10;
