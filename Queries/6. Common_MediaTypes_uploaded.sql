-- What are the most common types of media uploaded by users (text, images, videos)?

SELECT media_type, COUNT(post_id) AS total_posts
FROM posts
GROUP BY media_type
ORDER BY total_posts DESC;
