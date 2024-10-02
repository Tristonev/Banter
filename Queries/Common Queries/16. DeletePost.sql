-- 16. Deleting a Post
DELETE FROM posts
WHERE post_id = 101 AND user_id = 1; -- Ensure the post belongs to the user
