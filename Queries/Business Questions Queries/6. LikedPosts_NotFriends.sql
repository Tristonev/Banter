-- 6. How many users have liked posts from users who are not their friends?
SELECT COUNT(DISTINCT l.user_id) AS non_friend_likes
FROM likes l
JOIN posts p ON l.post_id = p.post_id
LEFT JOIN friendships f ON l.user_id = f.user_id AND p.user_id = f.friend_id
WHERE f.friendship_id IS NULL;
