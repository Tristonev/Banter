-- 20. Check if a User is Blocked
SELECT * FROM blocked_users
WHERE blocker_id = 1 AND blocked_id = 3; -- Check if John has blocked Alex
