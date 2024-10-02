-- 4. Liking a Post
INSERT INTO likes (user_id, post_id)
SELECT 1, 101 -- Replace with actual user_id and post_id
WHERE 1 != (SELECT user_id FROM posts WHERE post_id = 101); -- Ensure user doesn't like their own post
