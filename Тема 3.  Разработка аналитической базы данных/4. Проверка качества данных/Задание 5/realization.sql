SELECT
    COUNT(u.id) = 0 AS no_future_dates,
    COUNT(u.id) = 0 AS no_false_start_dates,
    'users' AS dataset
FROM STV2023121113__STAGING.users u
WHERE u.registration_dt > now() OR u.registration_dt < '2020-09-03'

UNION ALL

SELECT
    COUNT(g.id) = 0,
    COUNT(g.id) = 0,
    'groups'
FROM STV2023121113__STAGING.groups g
WHERE g.registration_dt > now() OR g.registration_dt < '2020-09-03'

UNION ALL

SELECT
    COUNT(d.message_id) = 0,
    COUNT(d.message_id) = 0,
    'dialogs'
FROM STV2023121113__STAGING.dialogs d
WHERE d.message_ts > now() OR d.message_ts < '2020-09-03';
