-- 10. Checking if Two Users are Friends
SELECT * FROM friendships
WHERE (user_id = 1 AND friend_id = 2) OR (user_id = 2 AND friend_id = 1)
AND request_status = 'accepted';
