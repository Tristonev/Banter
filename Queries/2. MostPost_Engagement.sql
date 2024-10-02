-- Which posts receive the most engagement (based on likes/comments) ?

SELECT p.post_id, COUNT(DISTINCT l.like_id) AS total_likes, COUNT(DISTINCT c.comment_id) AS total_comments
FROM posts p
LEFT JOIN likes l ON p.post_id = l.post_id
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id
ORDER BY (total_likes + total_comments) DESC;
