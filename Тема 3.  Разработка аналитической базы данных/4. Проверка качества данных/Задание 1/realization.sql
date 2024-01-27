SELECT
    count(u.id)             as count_total,
    count(DISTINCT u.id)    as count_uniq
FROM STV2023121113__STAGING.users u;