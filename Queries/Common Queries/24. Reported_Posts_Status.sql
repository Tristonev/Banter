-- 24. Query to check for pending reported posts that need attention
SELECT reporter_id, reported_post_id, report_reason, status
FROM reported
WHERE status = "pending"
AND reported_post_id IS NOT NULL;
