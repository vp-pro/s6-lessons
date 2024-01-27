drop table if exists STV2023121113__DWH.l_user_message;

create table STV2023121113__DWH.l_user_message
(
hk_l_user_message bigint primary key,
hk_user_id bigint not null CONSTRAINT fk_l_user_message_user REFERENCES STV2023121113__DWH.h_users (hk_user_id),
hk_message_id bigint not null CONSTRAINT fk_l_user_message_message REFERENCES STV2023121113__DWH.h_dialogs (hk_message_id),
load_dt datetime,
load_src varchar(20)
)
order by load_dt
SEGMENTED BY hk_user_id all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);


-- l_admins Table
DROP TABLE IF EXISTS STV2023121113__DWH.l_admins;

CREATE TABLE STV2023121113__DWH.l_admins
(
    hk_l_admin_id BIGINT PRIMARY KEY,
    hk_user_id BIGINT NOT NULL,
    hk_group_id BIGINT NOT NULL,
    load_dt DATETIME,
    load_src VARCHAR(20),
    CONSTRAINT fk_l_admin_user FOREIGN KEY (hk_user_id) REFERENCES STV2023121113__DWH.h_users (hk_user_id),
    CONSTRAINT fk_l_admin_group FOREIGN KEY (hk_group_id) REFERENCES STV2023121113__DWH.h_groups (hk_group_id)
)
ORDER BY load_dt
SEGMENTED BY hk_l_admin_id all nodes
PARTITION BY load_dt::DATE
GROUP BY calendar_hierarchy_day(load_dt::DATE, 3, 2);



-- l_groups_dialogs Table
DROP TABLE IF EXISTS STV2023121113__DWH.l_groups_dialogs;

CREATE TABLE STV2023121113__DWH.l_groups_dialogs
(
    hk_l_groups_dialogs BIGINT PRIMARY KEY,
    hk_group_id BIGINT NOT NULL,
    hk_dialog_id BIGINT NOT NULL,
    load_dt DATETIME,
    load_src VARCHAR(20),
    CONSTRAINT fk_l_groups_dialogs_group FOREIGN KEY (hk_group_id) REFERENCES STV2023121113__DWH.h_groups (hk_group_id),
    CONSTRAINT fk_l_groups_dialogs_dialog FOREIGN KEY (hk_dialog_id) REFERENCES STV2023121113__DWH.h_dialogs (hk_message_id)
)
ORDER BY load_dt
SEGMENTED BY hk_l_groups_dialogs ALL NODES
PARTITION BY load_dt::DATE
GROUP BY calendar_hierarchy_day(load_dt::DATE, 3, 2);

