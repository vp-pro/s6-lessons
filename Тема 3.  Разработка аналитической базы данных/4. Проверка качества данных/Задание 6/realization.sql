-- Check for missing administrators in groups
SELECT
    COUNT(g.id) - COUNT(u.id) AS count
FROM STV2023121113__STAGING.groups g
LEFT JOIN STV2023121113__STAGING.users u ON g.admin_id = u.id
WHERE u.id IS NULL;
