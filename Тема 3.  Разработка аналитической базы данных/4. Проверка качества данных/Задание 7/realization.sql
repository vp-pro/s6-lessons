-- Check for missing sender and receiver info in dialogs using STV2023121113__STAGING schema
SELECT
    COUNT(1) AS count,
    'missing group admin info' AS info
FROM STV2023121113__STAGING.groups g
WHERE g.admin_id IS NOT NULL AND NOT EXISTS (
    SELECT 1
    FROM STV2023121113__STAGING.users u
    WHERE u.id = g.admin_id
)
UNION ALL
SELECT
    COUNT(1),
    'missing sender info'
FROM STV2023121113__STAGING.dialogs d
WHERE NOT EXISTS (
    SELECT 1
    FROM STV2023121113__STAGING.users u
    WHERE u.id = d.message_from
)
UNION ALL
SELECT
    COUNT(1),
    'missing receiver info'
FROM STV2023121113__STAGING.dialogs d
WHERE NOT EXISTS (
    SELECT 1
    FROM STV2023121113__STAGING.users u
    WHERE u.id = d.message_to
)
UNION ALL
SELECT
    COUNT(1),
    'norm receiver info'
FROM STV2023121113__STAGING.dialogs d
WHERE EXISTS (
    SELECT 1
    FROM STV2023121113__STAGING.users u
    WHERE u.id = d.message_to
);
