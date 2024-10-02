-- 8. Rejecting or Canceling a Friend Request
DELETE FROM friendships
WHERE user_id = 1 AND friend_id = 2; -- Either John cancels the request, or Jane rejects it
