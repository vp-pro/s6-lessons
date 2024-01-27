-- Creating h_users hub
DROP TABLE IF EXISTS STV2023121113__DWH.h_users;

CREATE TABLE STV2023121113__DWH.h_users
(
    hk_user_id         BIGINT PRIMARY KEY,
    user_id            INT,
    chat_name          VARCHAR(200),
    registration_dt    DATE,
    country            VARCHAR(200),
    age                INT,
    load_dt            DATETIME,
    load_src           VARCHAR(20)
)
ORDER BY load_dt
SEGMENTED BY hk_user_id ALL NODES
PARTITION BY load_dt::DATE
GROUP BY calendar_hierarchy_day(load_dt::DATE, 3, 2);

-- Creating h_groups hub
DROP TABLE IF EXISTS STV2023121113__DWH.h_groups;

CREATE TABLE STV2023121113__DWH.h_groups
(
    hk_group_id        BIGINT PRIMARY KEY,
    group_id           INT,
    registration_dt    TIMESTAMP,
    load_dt            DATETIME,
    load_src           VARCHAR(20)
)
ORDER BY load_dt
SEGMENTED BY hk_group_id ALL NODES
PARTITION BY load_dt::DATE
GROUP BY calendar_hierarchy_day(load_dt::DATE, 3, 2);

-- Creating h_dialogs hub
-- Creating h_dialogs hub
DROP TABLE IF EXISTS STV2023121113__DWH.h_dialogs;

CREATE TABLE STV2023121113__DWH.h_dialogs
(
    hk_message_id    BIGINT PRIMARY KEY,
    message_id       INT,
    message_ts       TIMESTAMP,
    load_dt          TIMESTAMP,
    load_src         VARCHAR(20)
)
ORDER BY load_dt
SEGMENTED BY hk_message_id ALL NODES
PARTITION BY load_dt::DATE
GROUP BY calendar_hierarchy_day(load_dt::DATE, 3, 2);

