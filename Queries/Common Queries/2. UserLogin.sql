-- 2. User Login (Fetching User by Email/Username)
SELECT user_id, username, email, password_hash FROM users
WHERE email = 'john@example.com' OR username = 'john_doe';
