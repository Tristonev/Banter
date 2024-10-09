COMMIT; -- saves your current state of db, before we apply below
DROP DATABASE IF EXISTS social_media; -- deletes your current db if you have, before we apply the below script
CREATE DATABASE social_media; -- Creates db
USE social_media; -- Uses db
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    parental_controls_enabled BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT, -- Can store both text and media
    media_type ENUM('image', 'video', 'text') DEFAULT 'text',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE
);

CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE friendships (
    friendship_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    friend_id INT NOT NULL,
    request_status ENUM('pending', 'accepted', 'rejected') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    message_content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CHECK (sender_id != receiver_id) -- Users cannot message themselves
);

CREATE TABLE blocked_users (
    block_id INT AUTO_INCREMENT PRIMARY KEY,
    blocker_id INT NOT NULL,
    blocked_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (blocker_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (blocked_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CHECK (blocker_id != blocked_id)
);

CREATE TABLE reported (
    report_id SERIAL PRIMARY KEY,             
    reporter_id INT NOT NULL,                 
    reported_post_id INT,                     
    reported_user_id INT,                     
    report_reason TEXT NOT NULL,              
    report_date TIMESTAMP DEFAULT NOW(),      
    status VARCHAR(20) DEFAULT 'pending',     -- The status of the report (e.g., pending, reviewed, resolved)

    -- Foreign Key Constraints
    FOREIGN KEY (reporter_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (reported_post_id) REFERENCES posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (reported_user_id) REFERENCES users(user_id) ON DELETE CASCADE
);


-- Users Seed
INSERT INTO users (username, email, password_hash, date_of_birth, parental_controls_enabled)
VALUES
('john_doe', 'john@example.com', 'hashed_password', '2000-05-10', FALSE),
('jane_smith', 'jane@example.com', 'hashed_password', '1995-03-15', FALSE),
('alex_jones', 'alex@example.com', 'hashed_password', '2010-11-20', TRUE),
('chris_wilson', 'chris@example.com', 'hashed_password', '1987-08-03', FALSE);

-- Posts Seed
INSERT INTO posts (user_id, content, media_type)
VALUES
(1, 'Check out this awesome sunset!', 'image'),
(2, 'Had a great time at the event today', 'text'),
(3, 'Watch this cool video I made', 'video');

-- Likes seed
INSERT INTO likes (user_id, post_id)
VALUES
(1, 2), -- John likes Jane's post
(2, 3), -- Jane likes Alex's post
(3, 1); -- Alex likes John's post

-- Comments Seed 
INSERT INTO comments (post_id, user_id, comment_text)
VALUES
(1, 2, 'That looks amazing!'),
(2, 3, 'Glad you had fun!'),
(3, 1, 'Great video!');

-- Friendships Seed
INSERT INTO friendships (user_id, friend_id, request_status)
VALUES
(1, 2, 'accepted'), -- John and Jane are friends
(2, 3, 'accepted'), -- Jane and Alex are friends
(1, 3, 'pending'); -- John sent a friend request to Alex

-- Messages Seed
INSERT INTO messages (sender_id, receiver_id, message_content)
VALUES
(1, 2, 'Hey Jane, how’s it going?'),
(2, 1, 'I’m doing well! How about you?');

-- Blocked Users Seed
INSERT INTO blocked_users (blocker_id, blocked_id)
VALUES
(2, 3); -- Jane blocked Alex


-- Reported Seed

INSERT INTO reported (reporter_id, reported_post_id, report_reason)
VALUES
(1, 3, 'Inappropriate content');  -- John reports Alex's post

INSERT INTO reported (reporter_id, reported_user_id, report_reason)
VALUES
(2, 3, 'Harassment');  -- Jane reports Alex as a user for harassment