-- Check earliest and latest user registration dates
SELECT
    min(u.registration_dt) AS datestamp,
    'earliest user registration' AS info
FROM STV2023121113__STAGING.users u
UNION ALL
SELECT
    max(u.registration_dt),
    'latest user registration'
FROM STV2023121113__STAGING.users u

UNION ALL

-- Check for registrations before platform launch or after the query date
SELECT
    min(g.registration_dt),
    'earliest group registration'
FROM STV2023121113__STAGING.groups g
UNION ALL
SELECT
    max(g.registration_dt),
    'latest group registration'
FROM STV2023121113__STAGING.groups g

UNION ALL

-- Check for registrations before platform launch or after the query date
SELECT
    min(d.message_ts) AS datestamp,
    'earliest message timestamp'
    FROM STV2023121113__STAGING.dialogs d
UNION ALL
SELECT
    max(d.message_ts),
    'latest message timestamp'
FROM STV2023121113__STAGING.dialogs d;
