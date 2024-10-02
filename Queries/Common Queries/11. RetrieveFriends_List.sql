-- 11. Retrieving a User’s Friends
SELECT u.user_id, u.username, u.email
FROM users u
JOIN friendships f ON (u.user_id = f.user_id OR u.user_id = f.friend_id)
WHERE (f.user_id = 1 OR f.friend_id = 1) -- Replace with the user_id
AND f.request_status = 'accepted';
