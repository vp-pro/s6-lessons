SELECT
    COUNT(g.id) AS total_groups,
    COUNT(DISTINCT g.group_name) AS uniq_group_names
FROM STV2023121113__STAGING.groups g;
