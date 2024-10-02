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
