-- 17. Unliking a Post
DELETE FROM likes
WHERE user_id = 1 AND post_id = 101; -- John unlikes the post with ID 101
