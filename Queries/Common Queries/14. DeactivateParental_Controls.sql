-- 14. Deactivating Parental Controls
UPDATE users
SET parental_controls_enabled = FALSE
WHERE user_id = 3; -- Deactivating parental controls for user with user_id 3
