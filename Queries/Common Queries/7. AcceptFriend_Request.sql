-- 7. Accepting a Friend Request
UPDATE friendships
SET request_status = 'accepted'
WHERE user_id = 1 AND friend_id = 2; -- Jane accepts John's friend request
