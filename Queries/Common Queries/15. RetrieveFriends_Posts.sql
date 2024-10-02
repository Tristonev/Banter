-- 15. Retrieving Posts from Friends
SELECT p.post_id, p.content, p.media_type, p.created_at, u.username AS author
FROM posts p
JOIN users u ON p.user_id = u.user_id
JOIN friendships f ON (u.user_id = f.user_id OR u.user_id = f.friend_id)
WHERE (f.user_id = 1 OR f.friend_id = 1) -- Replace 1 with the user_id
AND f.request_status = 'accepted'
ORDER BY p.created_at DESC;
