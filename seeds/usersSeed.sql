INSERT INTO users (username, email, password_hash, date_of_birth, parental_controls_enabled, first_name, last_name)
VALUES
('john_doe', 'john@example.com', 'hashed_password', '2000-05-10', FALSE, 'John', 'Doe'),
('jane_smith', 'jane@example.com', 'hashed_password', '1995-03-15', FALSE, 'Jane', 'Smith'),
('alex_jones', 'alex@example.com', 'hashed_password', '2010-11-20', TRUE, 'Alex', 'Jones'),
('chris_wilson', 'chris@example.com', 'hashed_password', '1987-08-03', FALSE, 'Chris', 'Wilson');
