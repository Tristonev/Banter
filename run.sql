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
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
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


--- Users Seed
INSERT INTO users (username, email, password_hash, date_of_birth, parental_controls_enabled, first_name, last_name)
VALUES
('john_doe', 'john@example.com', 'hashed_password', '2000-05-10', FALSE, 'John', 'Doe'),
('jane_smith', 'jane@example.com', 'hashed_password', '1995-03-15', FALSE, 'Jane', 'Smith'),
('alex_jones', 'alex@example.com', 'hashed_password', '2010-11-20', TRUE, 'Alex', 'Jones'),
('chris_wilson', 'chris@example.com', 'hashed_password', '1987-08-03', FALSE, 'Chris', 'Wilson'),
('sam_green', 'sam@example.com', 'hashed_password', '2005-09-22', TRUE, 'Sam', 'Green'),
('emma_brown', 'emma@example.com', 'hashed_password', '1990-06-18', FALSE, 'Emma', 'Brown'),
('liam_taylor', 'liam@example.com', 'hashed_password', '1998-12-12', FALSE, 'Liam', 'Taylor'),
('olivia_white', 'olivia@example.com', 'hashed_password', '1993-04-25', FALSE, 'Olivia', 'White'),
('noah_hall', 'noah@example.com', 'hashed_password', '2007-03-05', TRUE, 'Noah', 'Hall'),
('ava_clark', 'ava@example.com', 'hashed_password', '2002-11-30', FALSE, 'Ava', 'Clark');

-- Posts Seed
INSERT INTO posts (user_id, content, media_type)
VALUES
(1, 'Check out this awesome sunset!', 'image'),
(2, 'Had a great time at the event today', 'text'),
(3, 'Watch this cool video I made', 'video'),
(4, 'Exploring the mountains!', 'image'),
(5, 'My first blog post!', 'text'),
(6, 'Travel memories captured perfectly.', 'image'),
(7, 'Happy to share this milestone.', 'text'),
(8, 'The cutest cat video ever.', 'video'),
(9, 'Nature never ceases to amaze me.', 'image'),
(10, 'Throwback to an unforgettable day.', 'text');

-- Likes Seed
INSERT INTO likes (user_id, post_id)
VALUES
(1, 2), 
(2, 3), 
(3, 1), 
(4, 5),
(5, 4),
(6, 7),
(7, 8),
(8, 9),
(9, 10),
(10, 6);

-- Comments Seed 
INSERT INTO comments (post_id, user_id, comment_text)
VALUES
(1, 2, 'That looks amazing!'),
(2, 3, 'Glad you had fun!'),
(3, 1, 'Great video!'),
(4, 5, 'Looks so peaceful!'),
(5, 4, 'Well written.'),
(6, 7, 'Stunning shot!'),
(7, 8, 'Congrats!'),
(8, 9, 'Haha, hilarious!'),
(9, 10, 'Beautiful as always!'),
(10, 6, 'This is inspiring!');

-- Friendships Seed
INSERT INTO friendships (user_id, friend_id, request_status)
VALUES
(1, 2, 'accepted'), 
(2, 3, 'accepted'), 
(1, 3, 'pending'),
(4, 5, 'accepted'),
(5, 6, 'rejected'),
(6, 7, 'accepted'),
(7, 8, 'accepted'),
(8, 9, 'pending'),
(9, 10, 'accepted'),
(10, 1, 'accepted');

-- Messages Seed
INSERT INTO messages (sender_id, receiver_id, message_content)
VALUES
(1, 2, 'Hey Jane, how’s it going?'),
(2, 1, 'I’m doing well! How about you?'),
(3, 4, 'Loved your recent post!'),
(4, 5, 'Thanks for the message!'),
(5, 6, 'Let’s catch up soon.'),
(6, 7, 'Sure, sounds great.'),
(7, 8, 'Sent you the details.'),
(8, 9, 'Got it, thanks!'),
(9, 10, 'When are we meeting?'),
(10, 1, 'Let me know your availability.');

-- Blocked Users Seed
INSERT INTO blocked_users (blocker_id, blocked_id)
VALUES
(2, 3), 
(4, 5), 
(6, 7), 
(8, 9), 
(10, 1);

-- Reported Seed
INSERT INTO reported (reporter_id, reported_post_id, report_reason)
VALUES
(1, 3, 'Inappropriate content'),
(2, 4, 'Spam'),
(3, 5, 'Offensive language'),
(4, 6, 'Copyright infringement'),
(5, 7, 'Harassment');

INSERT INTO reported (reporter_id, reported_user_id, report_reason)
VALUES
(6, 8, 'Fake account'),
(7, 9, 'Spam activity'),
(8, 10, 'Bullying behavior'),
(9, 1, 'Hate speech'),
(10, 2, 'Inappropriate comments');
