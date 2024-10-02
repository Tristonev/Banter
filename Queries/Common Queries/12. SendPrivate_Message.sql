-- 12. Sending a Private Message
INSERT INTO messages (sender_id, receiver_id, message_content)
SELECT 1, 2, 'Hey did u check the Banter app? LOL...'
FROM friendships
WHERE (user_id = 1 AND friend_id = 2 OR user_id = 2 AND friend_id = 1)
AND request_status = 'accepted';
