-- 23. Based on the date of birth of the user, parental controls may be suggested
SELECT user_id, YEAR(CURDATE()) - YEAR(date_of_birth) AS "age", date_of_birth
FROM users
WHERE YEAR(CURDATE()) - YEAR(date_of_birth) < 18;