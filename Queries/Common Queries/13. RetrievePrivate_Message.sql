-- 13. Retrieving Private Messages Between Two Users
SELECT m.message_id, m.message_content, m.created_at, sender.username AS sender_name, receiver.username AS receiver_name
FROM messages m
JOIN users sender ON m.sender_id = sender.user_id
JOIN users receiver ON m.receiver_id = receiver.user_id
WHERE (m.sender_id = 1 AND m.receiver_id = 2) OR (m.sender_id = 2 AND m.receiver_id = 1)
ORDER BY m.created_at ASC;
