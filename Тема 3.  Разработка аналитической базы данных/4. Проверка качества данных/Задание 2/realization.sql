SELECT
    COUNT(u.id) AS total,
    COUNT(DISTINCT u.id) AS uniq,
    'users' AS dataset
FROM STV2023121113__STAGING.users u
UNION ALL
SELECT
    COUNT(g.id) AS total,
    COUNT(DISTINCT g.id) AS uniq,
    'groups' AS dataset
FROM STV2023121113__STAGING.groups g
UNION ALL
SELECT
    COUNT(d.message_id) AS total,
    COUNT(DISTINCT d.message_id) AS uniq,
    'dialogs' AS dataset
FROM STV2023121113__STAGING.dialogs d;
