INSERT INTO friendships (user_id, friend_id, request_status)
VALUES
(1, 2, 'accepted'), -- John and Jane are friends
(2, 3, 'accepted'), -- Jane and Alex are friends
(1, 3, 'pending'); -- John sent a friend request to Alex
