-- Populate l_admins
INSERT INTO STV2023121113__DWH.l_admins(hk_l_admin_id, hk_group_id, hk_user_id, load_dt, load_src)
SELECT
    hash(hg.hk_group_id, hu.hk_user_id),
    hg.hk_group_id,
    hu.hk_user_id,
    NOW() AS load_dt,
    's3' AS load_src
FROM STV2023121113__STAGING.groups AS g
LEFT JOIN STV2023121113__DWH.h_users AS hu ON g.admin_id = hu.user_id
LEFT JOIN STV2023121113__DWH.h_groups AS hg ON g.id = hg.group_id
WHERE hash(hg.hk_group_id, hu.hk_user_id) NOT IN (SELECT hk_l_admin_id FROM STV2023121113__DWH.l_admins);

-- Populate l_groups_dialogs
INSERT INTO STV2023121113__DWH.l_groups_dialogs(hk_l_groups_dialogs, hk_group_id, hk_dialog_id, load_dt, load_src)
SELECT
    hash(hg.hk_group_id, hd.hk_message_id),
    hg.hk_group_id,
    hd.hk_message_id,
    NOW() AS load_dt,
    's3' AS load_src
FROM STV2023121113__DWH.h_groups AS hg
JOIN STV2023121113__DWH.h_dialogs AS hd ON hg.group_id = hd.message_id
WHERE hash(hg.hk_group_id, hd.hk_message_id) NOT IN (SELECT hk_l_groups_dialogs FROM STV2023121113__DWH.l_groups_dialogs);


-- Populate l_user_message
INSERT INTO STV2023121113__DWH.l_user_message(hk_l_user_message, hk_user_id, hk_message_id, load_dt, load_src)
SELECT
    hash(hu.hk_user_id, hd.hk_message_id),
    hu.hk_user_id,
    hd.hk_message_id,
    NOW() AS load_dt,
    's3' AS load_src
FROM STV2023121113__STAGING.dialogs AS d
LEFT JOIN STV2023121113__DWH.h_users AS hu ON d.message_from = hu.user_id
LEFT JOIN STV2023121113__DWH.h_dialogs AS hd ON d.message_id = hd.message_id
WHERE hash(hd.hk_message_id, hu.hk_user_id) NOT IN (SELECT hk_l_user_message FROM STV2023121113__DWH.l_user_message)
    AND hu.hk_user_id IS NOT NULL;
