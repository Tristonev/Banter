-- 1. User Registration (Creating a User)
INSERT INTO users (username, email, password_hash, date_of_birth, parental_controls_enabled)
VALUES ('john_doe', 'john@example.com', 'hashed_password', '2000-05-10', FALSE);
