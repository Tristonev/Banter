-- 24. Query to check for pending reported users that need attention
SELECT reporter_id, report_reason, status
FROM reported
WHERE status = "pending"
AND reported_post_id IS NULL;